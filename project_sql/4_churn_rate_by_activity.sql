/*
Question: Are inactive members more likely to churn than active ones?
- Classify each customer as "Active" or "Inactive" based on is_active_member,
  then calculate churn rate for each group.
- Why? Member activity is a common retention indicator — if inactive
  members churn significantly more, engagement campaigns could directly
  reduce churn.
*/

SELECT
    CASE
        WHEN is_active_member = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS member_status,
    COUNT(*) AS num_of_customers,
    SUM(churn) AS churned_customers,
    ROUND(100.0 * SUM(churn) / COUNT(*), 2) AS churn_rate_pct
FROM
    customer_churn
GROUP BY
    member_status
ORDER BY
    churn_rate_pct DESC;