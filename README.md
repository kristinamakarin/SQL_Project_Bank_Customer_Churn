# 🏦 Bank Customer Churn Analysis

## Business Problem
Bank management has noticed customers are leaving (churning) and needs an analysis to identify **which** customers are most at risk, **what factors** most strongly correlate with leaving, and **which segment** should be prioritized for a retention campaign.

## Introduction
This project analyzes a bank customer dataset using SQL to understand churn patterns and provide actionable recommendations for reducing customer attrition.

The data comes from the [Bank Customer Churn dataset](https://www.kaggle.com/) on Kaggle, and includes customer demographics, account details, and whether each customer has churned.

The queries I wrote can be found in the [`project_sql/`](./project_sql/) folder.

## Questions I wanted to answer
1. What is the overall customer churn rate?
2. Does churn rate vary by country/geography?
3. Does churn rate vary by number of products the customer holds?
4. Are inactive members more likely to churn than active ones?
5. Does churn correlate with age group?
6. Does churn correlate with credit score?
7. Which single category is the highest-risk within each individual factor (geography, product count, activity, age)?
8. How many customers match all four highest-risk factors simultaneously, and what is their combined churn rate?

## Tools I used
- **SQL** — for querying and analyzing the data
- **PostgreSQL** — database management system
- **VS Code** — for writing queries and version control
- **Git & GitHub** — for version control and sharing the project

## The Analysis

### 1. Overall Churn Rate

To establish a baseline, I counted total customers and summed the churn flag to calculate what percentage of the customer base has left the bank.

**Key finding:** Out of 10,000 customers, 2,037 have churned — an overall churn rate of 20.37%. This is a meaningful baseline: any segment with a churn rate notably above 20.37% represents elevated risk worth investigating further, while segments below this rate are relatively stable.

### 2. Churn Rate by Geography

To see whether churn varies by country, I calculated the churn rate for each country and compared it against the overall baseline (20.37%) using a CTE for each, joined together.

**Key finding:** Germany stands out sharply with a 32.44% churn rate — 12.07 percentage points above the baseline, meaning German customers are leaving at roughly 1.6x the overall rate. Spain (16.67%) and France (16.15%) are both notably below average, at 3-4 points under baseline. This points to Germany as a clear priority market for retention efforts, rather than a bank-wide issue.

### 3. Churn Rate by Number of Products

To see how product count relates to churn, I calculated the churn rate for each product count group, compared against the overall baseline.

**Key finding:** This is the strongest signal in the dataset. All 60 customers with 4 products have churned — a 100% churn rate, and with a large enough sample size (60 customers) that this isn't a statistical fluke. Customers with 3 products aren't far behind at 82.71% (266 customers, 62.34 points above baseline). In sharp contrast, customers with 1 product churn at 27.71% (5,084 customers, close to baseline), and customers with 2 products are the most stable segment at just 7.58% (4,590 customers, 12.79 points *below* baseline). This strongly suggests that 2 products is the "sweet spot" for retention, while pushing customers toward 3+ products — likely intended as a loyalty/cross-sell strategy — is instead strongly correlated with churn, possibly due to product complexity, fees, or dissatisfaction with bundled services.

*Note: The dataset doesn't specify which exact products are counted (e.g. checking account, savings, credit card, loan) — only the total count per customer.*

### 4. Churn Rate: Active vs. Inactive Members

To test whether member engagement affects retention, I classified customers as "Active" or "Inactive" and calculated churn rate for each group.

**Key finding:** Inactive members churn at 26.85% (1,302 of 4,849), nearly double the rate of active members at 14.27% (735 of 5,151). This confirms that engagement is a strong retention lever — a customer who isn't actively using the bank's services is significantly more likely to leave, making re-engagement campaigns for inactive members a straightforward, high-impact opportunity.

### 5. Churn Rate by Age Group

To see how age relates to churn, I bucketed customers into four age groups and calculated the churn rate for each.

**Key finding:** The 45-59 age group has by far the highest churn rate at 49.45% (897 of 1,814 customers) — nearly half of this group has left. The 60+ group is also elevated at 27.95%, while younger customers are much more stable: 30-44 churns at 14.44% and 18-29 at just 7.56%. This suggests churn risk increases sharply with age, particularly around the 45-59 range — possibly tied to life-stage financial decisions (retirement planning, switching to specialized wealth management elsewhere) rather than dissatisfaction with day-to-day banking.

### 6. Churn Rate by Credit Score

To see how credit score relates to churn, I bucketed customers into standard credit score ranges (Poor, Fair, Good, Very Good, Excellent) and used `HAVING` to filter results down to only the groups exceeding the bank's overall 20.37% churn rate.

**Key finding:** Three groups exceed the baseline — Poor (22.02%), Very Good (20.59%), and Fair (20.56%) — but the differences are small, only 0.2 to 1.65 percentage points above average. This is a much weaker signal than age or product count: credit score alone doesn't strongly predict churn in this dataset, suggesting it's not a priority factor for the retention strategy compared to product count, age, and geography.

### 7. Highest-Risk Category per Factor

Summarizing the highest-risk finding from each prior analysis into a single view: for geography, product count, activity status, and age, which specific category has the highest churn rate?

**Key finding:** Germany (32.44%), 4 products (100%), Inactive members (26.85%), and the 45-59 age group (49.45%) each represent the highest-risk category within their respective factor. Notably, these individual "worst" rates vary dramatically in severity — product count and age are far stronger risk indicators than geography or activity status, suggesting the retention strategy should weight these factors accordingly rather than treating all four as equally important.

*Note: this table shows the worst category within each factor independently — it doesn't mean these customers necessarily overlap into a single profile. Query 8 tests that directly.*

### 8. Combined Risk Segment

Combining all four highest-risk categories identified in Query 7 (Germany, 4 products, inactive membership, age 45-59), I queried how many customers match this exact combined profile, and what their churn rate is — using dynamic subqueries rather than hardcoded values, so the query automatically adapts if the underlying data changes.

**Key finding:** Only 7 customers in the entire bank match this precise combination of risk factors — and all 7 have churned (100%). While this exact segment is too small to justify a standalone campaign, it validates that these four factors compound rather than operate independently: a customer accumulating multiple risk factors faces near-certain churn.

**Recommendation:** Rather than targeting this narrow 7-customer segment directly, the bank should prioritize retention outreach for customers matching *any two or more* of these high-risk factors — starting with the strongest individual driver (4 products, 100% churn) and layering in geography (Germany), inactivity, and the 45-59 age range as secondary flags. Proactively re-engaging inactive, multi-product German customers in this age range — before they reach the full four-factor profile — represents the highest-leverage intervention point identified in this analysis.

## What I Learned
*(fill in at the end)*

## Conclusions
*(fill in at the end)*
