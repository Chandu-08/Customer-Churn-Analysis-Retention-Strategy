-- ==============================================================================
-- Customer Churn Analysis - Phase 3: Data Quality Checks
-- ==============================================================================

USE CustomerChurnDB;
GO

-- 1. Check for duplicates
SELECT customerID, COUNT(*) as record_count
FROM stg_telco_churn
GROUP BY customerID
HAVING COUNT(*) > 1;
-- Expected Result: 0 rows (No duplicates)

-- 2. Check for NULLs or Blanks in critical fields
SELECT 
    SUM(CASE WHEN customerID IS NULL THEN 1 ELSE 0 END) as missing_id,
    SUM(CASE WHEN tenure IS NULL THEN 1 ELSE 0 END) as missing_tenure,
    SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END) as missing_monthly_charges,
    SUM(CASE WHEN TotalCharges IS NULL OR TotalCharges = ' ' THEN 1 ELSE 0 END) as missing_total_charges
FROM stg_telco_churn;
-- Result: 11 rows have blank space (' ') in TotalCharges.

-- 3. Investigate the 11 records with blank TotalCharges
SELECT customerID, tenure, MonthlyCharges, TotalCharges, Churn
FROM stg_telco_churn
WHERE TotalCharges = ' ';
-- Finding: These 11 records all have tenure = 0. They are brand new customers who haven't been billed yet.

-- 4. Check for impossible numeric values (negative tenure or charges)
SELECT 
    MIN(tenure) as min_tenure, 
    MAX(tenure) as max_tenure,
    MIN(MonthlyCharges) as min_monthly, 
    MAX(MonthlyCharges) as max_monthly
FROM stg_telco_churn;
-- Result: min_tenure = 0, min_monthly = 18.25. No negative anomalies.

-- 5. Check categorical inconsistencies
SELECT DISTINCT gender FROM stg_telco_churn;
SELECT DISTINCT Contract FROM stg_telco_churn;
SELECT DISTINCT PaymentMethod FROM stg_telco_churn;
-- Result: Clean categorical values. No spelling variations or casing issues.
