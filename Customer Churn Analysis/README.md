# Customer Churn Analysis

This project analyzes customer churn patterns in a telecommunications company, focusing on various factors that influence customer retention.

## Table of Contents
1. [Introduction](#introduction)
2. [Data Loading and Preprocessing](#data-loading-and-preprocessing)
3. [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
4. [Univariate Analysis](#univariate-analysis)
5. [Bivariate Analysis](#bivariate-analysis)
6. [Multivariate Analysis](#multivariate-analysis)
7. [Conclusions](#conclusions)

## Introduction

Customer churn, or customer attrition, refers to the loss of customers over a given period. This analysis aims to understand the factors contributing to customer churn and provide insights for retention strategies.

## Data Loading and Preprocessing

- The dataset is loaded from a CSV file using pandas.
- Initial data exploration is performed using `df.head()`, `df.describe()`, and `df.info()`.
- The 'TotalCharges' column is converted to numeric type, and null values are handled.
- Outliers are identified and visualized for 'MonthlyCharges', 'TotalCharges', and 'tenure'.

## Exploratory Data Analysis (EDA)

- The overall churn rate is calculated and visualized.
- Distribution of various categorical variables is examined.

## Univariate Analysis

This section explores individual variables:
- Contract types
- Internet service types
- Payment methods

Visualizations include pie charts to show the distribution of these variables.

## Bivariate Analysis

This section examines relationships between pairs of variables:
- Gender vs. Churn
- SeniorCitizen vs. Churn
- Partner vs. Churn
- Dependents vs. Churn
- InternetService vs. Churn
- PhoneService vs. Churn
- OnlineBackup vs. Churn
- OnlineSecurity vs. Churn

Visualizations include histograms and count plots to show these relationships.

## Multivariate Analysis

This section explores relationships between multiple variables:
- InternetService and MonthlyCharges vs. Churn
- PhoneService and MonthlyCharges vs. Churn
- Tenure by Senior Citizen Status vs. Churn
- MonthlyCharges and Contract vs. Churn

Visualizations include bar plots, violin plots, and box plots to illustrate these complex relationships.

## Conclusions

Key findings from the analysis:
1. Contract type significantly influences churn, with month-to-month contracts having higher churn rates.
2. Higher monthly charges are associated with increased churn, especially for fiber optic internet users.
3. Senior citizens and customers without partners or dependents are more likely to churn.
4. Longer tenure is associated with lower churn rates, particularly among senior citizens.
5. Additional services like online backup and security seem to reduce churn rates.

These insights can be used to develop targeted retention strategies and improve customer satisfaction.

## Acknowledgments

- The dataset utilized in this analysis is sourced from a telecommunications company.
- The visualizations and analysis techniques are inspired by common practices in data science and machine learning.
