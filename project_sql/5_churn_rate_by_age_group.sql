/*
Question: Does churn correlate with age group?
- Bucket customers into age groups (18-29, 30-44, 45-59, 60+) using CASE,
  then calculate churn rate for each group.
- Why? Age often correlates with life stage and financial needs;
  identifying high-risk age groups helps target retention efforts
  more precisely than a one-size-fits-all approach.
*/

SELECT
    CASE
        WHEN age < 30 THEN '18-29'
        WHEN age BETWEEN 30 AND 44 THEN '30-44'
        WHEN age BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS num_of_customers,
    SUM(churn) AS churned_customers,
    ROUND(100.0 * SUM(churn) / COUNT(*), 2) AS churn_rate_pct
FROM
    customer_churn
GROUP BY
    age_group
ORDER BY
    churn_rate_pct DESC;

