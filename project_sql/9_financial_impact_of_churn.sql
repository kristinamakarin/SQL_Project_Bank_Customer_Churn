/*
Question: What is the financial impact of churn — do churned customers
have higher or lower account balances than retained customers?
- Classify customers as "Churned" or "Retained", then compare average
  and total account balance between the two groups.
- Why? Churn rate alone doesn't capture business impact — losing a few
  high-balance customers can matter more than losing many low-balance
  ones. This reframes the problem in financial terms for leadership.
*/

SELECT
    CASE WHEN churn = 1 THEN 'Churned' ELSE 'Retained' END AS status,
    COUNT(*) AS num_of_customers,
    ROUND(AVG(balance), 2) AS avg_balance,
    ROUND(SUM(balance), 2) AS total_balance
FROM customer_churn
GROUP BY status;