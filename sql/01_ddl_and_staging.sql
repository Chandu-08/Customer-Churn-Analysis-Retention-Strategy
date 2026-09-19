-- ==============================================================================
-- Customer Churn Analysis - Phase 3: DDL and Staging
-- ==============================================================================

-- 1. Create Database
CREATE DATABASE CustomerChurnDB;
GO

USE CustomerChurnDB;
GO

-- 2. Create Staging Table for Raw Data
-- Note: TotalCharges is imported as VARCHAR because the raw CSV contains blank spaces for some rows.
CREATE TABLE stg_telco_churn (
    customerID VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(50),
    InternetService VARCHAR(50),
    OnlineSecurity VARCHAR(50),
    OnlineBackup VARCHAR(50),
    DeviceProtection VARCHAR(50),
    TechSupport VARCHAR(50),
    StreamingTV VARCHAR(50),
    StreamingMovies VARCHAR(50),
    Contract VARCHAR(50),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges FLOAT,
    TotalCharges VARCHAR(50), 
    Churn VARCHAR(5)
);
GO

-- 3. Bulk Insert Instruction (for SSMS)
/*
BULK INSERT stg_telco_churn
FROM 'C:\path\to\your\data\raw\Telco-Customer-Churn.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
);
GO
*/
