/*
Question: How many customers match ALL FOUR highest-risk categories
simultaneously (Germany + 4 products + inactive + age 45-59), and
what is their churn rate?
- Use a subquery in the WHERE clause for each factor, dynamically
  pulling the riskiest category from Query 7's logic rather than
  hardcoding values, then filter customer_churn to that exact profile.
- Why? Tests whether the four risk factors compound when combined in
  a single customer, versus operating independently.
*/

WITH riskiest_country AS (
    SELECT geography
    FROM customer_churn
    GROUP BY geography
    ORDER BY ROUND(100.0 * SUM(churn) / COUNT(*), 2) DESC
    LIMIT 1
),
riskiest_products AS (
    SELECT num_of_products
    FROM customer_churn
    GROUP BY num_of_products
    ORDER BY ROUND(100.0 * SUM(churn) / COUNT(*), 2) DESC
    LIMIT 1
),
riskiest_activity AS (
    SELECT is_active_member
    FROM customer_churn
    GROUP BY is_active_member
    ORDER BY ROUND(100.0 * SUM(churn) / COUNT(*), 2) DESC
    LIMIT 1
),
riskiest_age AS (
    SELECT
        CASE
            WHEN age < 30 THEN '18-29'
            WHEN age BETWEEN 30 AND 44 THEN '30-44'
            WHEN age BETWEEN 45 AND 59 THEN '45-59'
            ELSE '60+'
        END AS age_group
    FROM customer_churn
    GROUP BY age_group
    ORDER BY ROUND(100.0 * SUM(churn) / COUNT(*), 2) DESC
    LIMIT 1
)

SELECT
    COUNT(*) AS num_of_customers,
    SUM(churn) AS churned_customers,
    ROUND(100.0 * SUM(churn) / COUNT(*), 2) AS segment_churn_rate
FROM customer_churn
WHERE
    geography = (SELECT geography FROM riskiest_country)
    AND num_of_products = (SELECT num_of_products FROM riskiest_products)
    AND is_active_member = (SELECT is_active_member FROM riskiest_activity)
    AND CASE
            WHEN age < 30 THEN '18-29'
            WHEN age BETWEEN 30 AND 44 THEN '30-44'
            WHEN age BETWEEN 45 AND 59 THEN '45-59'
            ELSE '60+'
        END = (SELECT age_group FROM riskiest_age);