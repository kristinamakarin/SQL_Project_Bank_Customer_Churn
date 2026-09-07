/*
Question: Does churn correlate with credit score, and which score
groups exceed the bank's overall churn rate?
- Bucket customers into credit score ranges using CASE, calculate
  churn rate per group, then use HAVING (with a dynamic baseline CTE)
  to filter to only groups performing worse than the 20.37% overall
  churn rate from Query 1.
- Why? HAVING filters aggregated results (unlike WHERE, which filters
  before aggregation) — useful here to surface only the score ranges
  that warrant attention, without manually scanning the full table.
*/

WITH baseline AS (
    SELECT
        ROUND(100.0 * SUM(churn) / COUNT(churn), 2) AS baseline_rate
    FROM
        customer_churn
)

SELECT  
    CASE
        WHEN credit_score < 580 THEN 'Poor (<580)'
        WHEN credit_score BETWEEN 580 AND 669 THEN 'Fair (580-669)'
        WHEN credit_score BETWEEN 670 AND 739 THEN 'Good (670-739)'
        WHEN credit_score BETWEEN 740 AND 799 THEN 'Very Good (740-799)'
        ELSE 'Excellent (800+)'
    END AS credit_score_group,
    COUNT(*) AS num_of_customers,
    SUM(churn) AS count_churn,
    --baseline_rate,
    ROUND(100.0 * SUM(churn) / COUNT(*), 2) AS churn_rate_ptc
FROM 
    customer_churn
CROSS JOIN 
    baseline
GROUP BY 
    credit_score_group,
    baseline_rate
HAVING
    ROUND(100.0 * SUM(churn) / COUNT(*), 2) > baseline_rate
ORDER BY 
    churn_rate_ptc DESC;