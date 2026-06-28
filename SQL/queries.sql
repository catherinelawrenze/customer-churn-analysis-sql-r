
CREATE DATABASE customer_churn_project;
USE customer_churn_project;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    gender VARCHAR(10),
    tenure INT,
    contract_type VARCHAR(50),
    monthly_charges DECIMAL(10,2),
    churn VARCHAR(5)
);
SELECT * FROM customers;
SELECT COUNT(*) AS total_customers
FROM customers;
INSERT INTO customers VALUES
(1, 'Female', 5, 'Month-to-month', 70.50, 'Yes'),
(2, 'Male', 24, 'One year', 55.20, 'No'),
(3, 'Female', 12, 'Month-to-month', 89.00, 'Yes'),
(4, 'Male', 36, 'Two year', 40.75, 'No'),
(5, 'Female', 2, 'Month-to-month', 95.60, 'Yes'),
(6, 'Male', 18, 'One year', 60.30, 'No');
SELECT COUNT(*) AS total_customers
FROM customers;
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customers;
SELECT 
    contract_type,
    COUNT(*) AS total,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM customers
GROUP BY contract_type;
SELECT * 
FROM customers
WHERE contract_type = 'Month-to-month';
SELECT *
FROM customers
WHERE monthly_charges > 80;
SELECT 
    contract_type,
    COUNT(*) AS total_customers
FROM customers
WHERE monthly_charges > 50
GROUP BY contract_type;


SELECT COUNT(*) FROM telco_churn;
SELECT COUNT(*) FROM telco_churn;
USE customer_churn_project;
SELECT COUNT(*) FROM telco_churn;
DESCRIBE telco_churn;
SELECT COUNT(*) AS missing_totalcharges
FROM telco_churn
WHERE TotalCharges IS NULL;
SELECT COUNT(*) AS blank_totalcharges
FROM telco_churn
WHERE TotalCharges = 0;
SELECT COUNT(*) 
FROM telco_churn
WHERE tenure = 0;
SELECT 
    Churn,
    COUNT(*) AS total,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM telco_churn), 2) AS percentage
FROM telco_churn
GROUP BY Churn;
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn
GROUP BY Contract
ORDER BY churn_rate_percentage DESC;
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charge,
    ROUND(AVG(TotalCharges),2) AS avg_total_charge,
    ROUND(AVG(tenure),2) AS avg_tenure
FROM telco_churn
GROUP BY Churn;
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-1 Year'
        WHEN tenure <= 24 THEN '1-2 Years'
        WHEN tenure <= 48 THEN '2-4 Years'
        ELSE '4+ Years'
    END AS tenure_group,
    
    COUNT(*) AS total_customers,

    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,

    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM telco_churn

GROUP BY tenure_group

ORDER BY churn_rate DESC;
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM telco_churn

GROUP BY PaymentMethod

ORDER BY churn_rate DESC;
SELECT 
    InternetService,
    COUNT(*) AS total_customers,

    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,

    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM telco_churn

GROUP BY InternetService

ORDER BY churn_rate DESC;

SELECT 
    Contract,
    PaymentMethod,
    
    COUNT(*) AS total_customers,
    
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM telco_churn

GROUP BY Contract, PaymentMethod

ORDER BY churn_rate DESC;
SELECT 
    ROUND(SUM(MonthlyCharges),2) AS monthly_revenue_lost
FROM telco_churn
WHERE Churn = 'Yes';
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges),2) AS avg_monthly_revenue
FROM telco_churn
GROUP BY Churn;
SELECT 
    Contract,
    
    COUNT(*) AS churned_customers,
    
    ROUND(SUM(MonthlyCharges),2) AS revenue_lost,
    
    ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charge
    
FROM telco_churn

WHERE Churn = 'Yes'

GROUP BY Contract

ORDER BY revenue_lost DESC;
