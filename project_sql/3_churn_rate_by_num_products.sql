/*
Question: Does churn rate vary by number of products the customer holds?
- Calculate churn rate per product count, compared against the overall
  baseline using the same CTE + CROSS JOIN pattern as Query 2.
- Why? Product count often reflects how "embedded" a customer is with
  the bank; understanding this relationship could reveal whether cross-
  selling more products helps or hurts retention.
*/

WITH baseline AS (
    SELECT
        COUNT(*) AS number_of_customers,
        SUM(churn) AS churn_customers,
        ROUND(100.0 * SUM(churn) / COUNT(*),2) AS baseline_churn_rate
    FROM 
        customer_churn
),
by_num_of_products AS (
    SELECT
        num_of_products,
        COUNT(*) AS num_of_customers,
        ROUND(100.0 * SUM(churn) / COUNT(*),2) AS churn_rate_pct
    FROM 
        customer_churn
    GROUP BY
        num_of_products
)

SELECT
    ROUND(by_num_of_products.churn_rate_pct - baseline.baseline_churn_rate, 2) AS diff_from_baseline,
    by_num_of_products.*
FROM 
    by_num_of_products
CROSS JOIN 
    baseline
ORDER BY
    churn_rate_pct DESC;

