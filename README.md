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
7. Which customer segment should be prioritized for a retention campaign? (combining the highest-risk, highest-value factors)

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
*(fill in)*

### 3. Churn Rate by Number of Products
*(fill in)*

### 4. Churn Rate: Active vs. Inactive Members
*(fill in)*

### 5. Churn Rate by Age Group
*(fill in)*

### 6. Churn Rate by Credit Score
*(fill in)*

### 7. Recommended Segment for Retention Campaign
*(fill in)*

## What I Learned
*(fill in at the end)*

## Conclusions
*(fill in at the end)*
