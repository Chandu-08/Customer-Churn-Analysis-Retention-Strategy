-- ==============================================================================
-- Customer Churn Analysis - Phase 4: Cleaning & Feature Engineering
-- ==============================================================================

USE CustomerChurnDB;
GO

-- Create a View that applies all cleaning and generates the enrichment fields dynamically
CREATE OR ALTER VIEW vw_enriched_customer_data AS
SELECT 
    -- 1. Base Fields
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    
    -- 2. Data Cleaning: Fix blank TotalCharges
    CASE 
        WHEN TotalCharges = ' ' THEN 0.00 
        ELSE CAST(TotalCharges AS FLOAT) 
    END AS TotalCharges,
    Churn,

    -- 3. Feature Engineering / Enrichment Layer
    
    -- Acquisition Channel (Simulated based on Contract/Payment)
    CASE 
        WHEN Contract = 'Two year' THEN 'Direct Sales'
        WHEN PaymentMethod = 'Electronic check' THEN 'Online Acquisition'
        ELSE 'Partner Network' 
    END AS acquisition_channel,

    -- Support Tickets (Simulated logic using CHECKSUM/NEWID proxy for randomness)
    -- Note: In SSMS, NEWID() changes per row. This simulates positive correlation to churn.
    CASE 
        WHEN Churn = 'Yes' THEN ABS(CHECKSUM(NEWID()) % 5) + 3
        WHEN Contract = 'Month-to-month' THEN ABS(CHECKSUM(NEWID()) % 4) + 1
        ELSE ABS(CHECKSUM(NEWID()) % 3)
    END AS support_tickets,

    -- Service Count (Numeric sum of all active services)
    (
        CASE WHEN PhoneService = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN InternetService != 'No' THEN 1 ELSE 0 END +
        CASE WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END
    ) AS service_count,

    -- Customer Dates (Simulated anchor date 2023-12-31)
    DATEADD(month, -tenure, '2023-12-31') AS customer_signup_date,
    CASE WHEN Churn = 'Yes' THEN '2023-12-31' ELSE NULL END AS churn_date,

    -- Churn Reason & Category
    CASE 
        WHEN Churn = 'No' THEN NULL
        WHEN Contract = 'Month-to-month' AND MonthlyCharges > 70 THEN 'Price Too High'
        WHEN (CASE WHEN Churn = 'Yes' THEN ABS(CHECKSUM(NEWID()) % 5) + 3 ELSE 0 END) > 3 THEN 'Poor Service Quality'
        WHEN InternetService = 'Fiber optic' THEN 'Competitor Offer'
        ELSE 'Personal Reasons'
    END AS churn_reason,

    -- Churn Category mapping
    CASE 
        WHEN Churn = 'No' THEN NULL
        WHEN (Contract = 'Month-to-month' AND MonthlyCharges > 70) 
             OR (InternetService = 'Fiber optic') THEN 'Competitor/Pricing'
        WHEN (CASE WHEN Churn = 'Yes' THEN ABS(CHECKSUM(NEWID()) % 5) + 3 ELSE 0 END) > 3 THEN 'Support/Service'
        ELSE 'Other'
    END AS churn_category

FROM stg_telco_churn;
GO

-- Query to verify the view
-- SELECT TOP 10 * FROM vw_enriched_customer_data;
