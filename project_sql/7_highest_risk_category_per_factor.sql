/*
Question: Which single category is highest-risk within each individual
risk factor (geography, product count, activity status, age)?
- For each factor, find the category with the highest churn rate using
  a CTE + LIMIT 1, then combine all four into one summary row via
  CROSS JOIN.
- Why? Summarizes the highest-risk finding from each prior query into
  a single view, setting up the combined segment analysis in Query 8.
- Note: this shows the worst category *within each factor independently*
  — it does not imply these customers overlap into a single profile.
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
    ORDER BY
        churn_rate_pct DESC
    LIMIT 1
      
), 
num_of_products AS (
    SELECT
        num_of_products,
        COUNT(*) AS num_of_customers,
        ROUND(100.0 * SUM(churn) / COUNT(*),2) AS churn_rate_pct
    FROM 
        customer_churn
    GROUP BY
        num_of_products
    ORDER BY
        churn_rate_pct DESC
    LIMIT 1
), 
by_active_member AS (
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
        churn_rate_pct DESC
    LIMIT 1
), 
by_age AS (
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
        churn_rate_pct DESC
    LIMIT 1
)

SELECT
    by_geography.geography AS riskiest_country,
    by_geography.churn_rate_pct AS country_churn_rate,
    num_of_products.num_of_products AS riskiest_product_count,
    num_of_products.churn_rate_pct AS product_churn_rate,
    by_active_member.member_status AS riskiest_activity_status,
    by_active_member.churn_rate_pct AS activity_churn_rate,
    by_age.age_group AS riskiest_age_group,
    by_age.churn_rate_pct AS age_churn_rate
FROM by_geography
CROSS JOIN num_of_products
CROSS JOIN by_active_member
CROSS JOIN by_age;

