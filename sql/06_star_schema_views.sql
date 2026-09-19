-- ==============================================================================
-- Customer Churn Analysis - Phase 7: Power BI Star Schema Creation
-- ==============================================================================

USE CustomerChurnDB;
GO

-- 1. Dimension: Contract
CREATE OR ALTER VIEW vw_DimContract AS
SELECT DISTINCT 
    DENSE_RANK() OVER (ORDER BY Contract) AS ContractID,
    Contract AS ContractType
FROM vw_enriched_customer_data;
GO

-- 2. Dimension: Payment
CREATE OR ALTER VIEW vw_DimPayment AS
SELECT DISTINCT 
    DENSE_RANK() OVER (ORDER BY PaymentMethod, PaperlessBilling) AS PaymentID,
    PaymentMethod,
    PaperlessBilling
FROM vw_enriched_customer_data;
GO

-- 3. Dimension: Service (Junk Dimension for service combinations)
CREATE OR ALTER VIEW vw_DimService AS
SELECT DISTINCT 
    DENSE_RANK() OVER (ORDER BY 
        PhoneService, MultipleLines, InternetService, OnlineSecurity, 
        OnlineBackup, DeviceProtection, TechSupport, StreamingTV, StreamingMovies
    ) AS ServiceID,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies
FROM vw_enriched_customer_data;
GO

-- 4. Dimension: Customer (Contains slow-changing or static demographics)
CREATE OR ALTER VIEW vw_DimCustomer AS
SELECT 
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    acquisition_channel,
    customer_signup_date,
    churn_date,
    churn_reason,
    churn_category
FROM vw_enriched_customer_data;
GO

-- 5. Fact Table: Customer Metrics and Foreign Keys
CREATE OR ALTER VIEW vw_FactCustomerChurn AS
SELECT 
    base.customerID,
    c.ContractID,
    p.PaymentID,
    s.ServiceID,
    base.tenure,
    base.MonthlyCharges,
    base.TotalCharges,
    base.support_tickets,
    base.service_count,
    base.login_frequency,
    base.Churn
FROM vw_enriched_customer_data base
LEFT JOIN vw_DimContract c 
    ON base.Contract = c.ContractType
LEFT JOIN vw_DimPayment p 
    ON base.PaymentMethod = p.PaymentMethod 
    AND base.PaperlessBilling = p.PaperlessBilling
LEFT JOIN vw_DimService s 
    ON base.PhoneService = s.PhoneService
    AND base.MultipleLines = s.MultipleLines
    AND base.InternetService = s.InternetService
    AND base.OnlineSecurity = s.OnlineSecurity
    AND base.OnlineBackup = s.OnlineBackup
    AND base.DeviceProtection = s.DeviceProtection
    AND base.TechSupport = s.TechSupport
    AND base.StreamingTV = s.StreamingTV
    AND base.StreamingMovies = s.StreamingMovies;
GO
