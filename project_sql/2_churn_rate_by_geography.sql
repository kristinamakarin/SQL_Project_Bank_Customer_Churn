/*
Question: Does churn rate vary by country/geography, and by how much
compared to the overall average?
- Calculate the overall baseline churn rate in one CTE, and churn rate
  per country in another, then CROSS JOIN them to compare each country
  against the baseline.
- Why? Raw churn rates by country are only meaningful in context —
  showing the deviation from the overall average immediately highlights
  which countries are genuinely at elevated risk.
*/

WITH baseline AS (
    SELECT 
        COUNT(*) AS number_of_customers,
        SUM(churn) AS custom_churn,
        ROUND(100.0 * SUM(churn) / COUNT(*), 2) AS baseline_churn_rate
    FROM 
        customer_churn
), 
by_geography AS (
    SELECT
        geography,
        ROUND(100.0 * SUM(churn) / COUNT(*) , 2) AS churn_rate_pct
    FROM 
        customer_churn
    GROUP BY 
        customer_churn.geography
)

SELECT 
    by_geography.*,
    ROUND(by_geography.churn_rate_pct - baseline.baseline_churn_rate, 2) AS diff_from_baseline
FROM 
    by_geography
CROSS JOIN 
    baseline        
ORDER BY
    churn_rate_pct DESC;