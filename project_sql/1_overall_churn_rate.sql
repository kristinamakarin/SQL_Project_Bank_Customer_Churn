/*
Question: What is the overall customer churn rate?
- Count total customers and sum the churn flag (0/1) to get the number
  who churned, then calculate the percentage.
- Why? Establishes the baseline churn rate — the starting point for
  understanding whether specific segments have higher or lower risk
  than average.
*/

SELECT 
     COUNT(*) AS number_of_customers,
     SUM(churn) AS custom_churn,
     ROUND(100.0 * SUM(churn) / COUNT(*), 2) AS churn_rate_pct
FROM 
    customer_churn;



