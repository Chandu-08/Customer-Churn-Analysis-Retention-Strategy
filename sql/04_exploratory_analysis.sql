-- ==============================================================================
-- Customer Churn Analysis - Phase 5: Exploratory Data Analysis (KPIs)
-- ==============================================================================

USE CustomerChurnDB;
GO

-- 1. High-Level KPIs: Overall Churn Rate and Volume
SELECT 
    COUNT(customerID) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(customerID) AS Churn_Rate_Pct
FROM vw_enriched_customer_data;

-- 2. Financial Impact: MRR (Monthly Recurring Revenue) Lost
SELECT 
    SUM(MonthlyCharges) AS Total_MRR,
    SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) AS Lost_MRR,
    SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) / SUM(MonthlyCharges) AS Revenue_Churn_Pct
FROM vw_enriched_customer_data;

-- 3. Segment Analysis: Churn by Contract Type
SELECT 
    Contract,
    COUNT(customerID) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(customerID) AS Churn_Rate
FROM vw_enriched_customer_data
GROUP BY Contract
ORDER BY Churn_Rate DESC;

-- 4. Segment Analysis: Churn by Tenure Bands
-- We use a CTE to create the bands dynamically
WITH TenureBanded AS (
    SELECT 
        customerID,
        Churn,
        CASE 
            WHEN tenure <= 12 THEN '0-12 Months'
            WHEN tenure <= 24 THEN '13-24 Months'
            WHEN tenure <= 48 THEN '25-48 Months'
            ELSE '49-72+ Months'
        END AS Tenure_Band
    FROM vw_enriched_customer_data
)
SELECT 
    Tenure_Band,
    COUNT(customerID) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(customerID) AS Churn_Rate
FROM TenureBanded
GROUP BY Tenure_Band
ORDER BY 
    CASE Tenure_Band 
        WHEN '0-12 Months' THEN 1 
        WHEN '13-24 Months' THEN 2 
        WHEN '25-48 Months' THEN 3 
        ELSE 4 
    END;
