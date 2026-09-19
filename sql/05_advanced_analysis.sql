-- ==============================================================================
-- Customer Churn Analysis - Phase 6: Advanced SQL Analysis
-- ==============================================================================

USE CustomerChurnDB;
GO

-- 1. Internet Service & Tech Support Correlation
-- Does lack of tech support on premium internet drive churn?
SELECT 
    InternetService,
    TechSupport,
    COUNT(customerID) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(customerID) AS Churn_Rate
FROM vw_enriched_customer_data
WHERE InternetService != 'No'
GROUP BY InternetService, TechSupport
ORDER BY InternetService, Churn_Rate DESC;

-- 2. Behavioral Driver: Support Ticket Thresholds (Using CTE)
-- Identifying the "breaking point" of customer patience
WITH TicketBands AS (
    SELECT 
        customerID,
        Churn,
        CASE 
            WHEN support_tickets <= 2 THEN 'Low (0-2)'
            WHEN support_tickets BETWEEN 3 AND 4 THEN 'Medium (3-4)'
            ELSE 'High (5+)' 
        END AS Ticket_Severity
    FROM vw_enriched_customer_data
)
SELECT 
    Ticket_Severity,
    COUNT(customerID) AS Volume,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned,
    CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(customerID) AS Churn_Rate
FROM TicketBands
GROUP BY Ticket_Severity
ORDER BY Churn_Rate DESC;

-- 3. Value Segmentation Using Window Functions (NTILE)
-- Segmenting customers into 4 equal quartiles based on their MonthlyCharges
WITH ValueQuartiles AS (
    SELECT 
        customerID,
        Churn,
        MonthlyCharges,
        NTILE(4) OVER (ORDER BY MonthlyCharges DESC) AS Revenue_Quartile
    FROM vw_enriched_customer_data
)
SELECT 
    Revenue_Quartile,
    MIN(MonthlyCharges) AS Min_Charge_In_Tier,
    MAX(MonthlyCharges) AS Max_Charge_In_Tier,
    COUNT(customerID) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(customerID) AS Tier_Churn_Rate
FROM ValueQuartiles
GROUP BY Revenue_Quartile
ORDER BY Revenue_Quartile ASC;
