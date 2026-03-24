# Project Description – Metrics and Business Logic

## Introduction

This project is not only a dashboard project, but a data model and business metrics project.  
A large part of the work was focused on building meaningful metrics using DAX and on creating a semantic layer for analytics.

The goal was to transform raw price, volume and market cap data into business metrics that allow market analysis, coin comparison and category analysis.

---

## Semantic Layer and Metrics Table

In Power BI a dedicated metrics table was created.  
This table does not contain data, but only DAX measures.

This approach separates:
- Raw data (fact tables)
- Dimensions
- Business metrics
- Report visuals

This structure is similar to a semantic model used in business intelligence projects.

---

## Time-Based Metrics

Many metrics are based on the concept of **Last Visible Date**.  
This is important because the dashboard uses filters, slicers and animations over time.

The main idea is:
The dashboard should always calculate values using the last available date in the current filter context.

Example logic:
- If the user selects a year, the metric uses the last date of that year.
- If the user selects a period, the metric uses the last date of that period.
- If the user selects a single coin, the metric uses the last available value for that coin.

Main time metrics:
- Last Visible Date
- First Visible Date
- Start Price
- End Price
- Price Change %
- Drawdown %

These metrics allow time analysis and performance analysis.

---

## Market Metrics

The main market metrics are:

- Total Market Cap
- Total Volume
- Last Coin Market Cap
- Last Coin Volume
- Last Coin Price
- Category Market Cap

These metrics are used in different pages of the dashboard:
- Market Overview
- Coin Explorer
- Category Comparison

The logic of these metrics is based on aggregation and filter context.

For example:
Last Coin Market Cap calculates the market cap at the last visible date in the current filter context.

This allows the same metric to work for:
- Entire market
- Single coin
- Category
- Selected period

---

## Market Share Metrics

Two important metrics in the project are:

- Coin Market Share %
- Category Market Share %

These metrics calculate the dominance of a coin or a category compared to the total market.

The logic is:

Market Share = Selected Market Cap / Total Market Cap

To calculate the total market cap, the filter on coin or category must be removed in the denominator.  
This is done using REMOVEFILTERS in DAX.

This allows correct calculation of market dominance.

These metrics are used in:
- Treemap visuals
- Category comparison page
- Coin analysis

---

## Performance Metrics

The project also includes performance metrics:

- Price Change %
- Drawdown %

Price Change % measures the price variation between the start date and the end date in the selected period.

Drawdown % measures the percentage drop from the historical maximum price.

These metrics are commonly used in financial analysis and portfolio analysis.

---

## Why These Metrics Are Important

Raw data like price and volume are not enough for analysis.  
Business metrics are necessary to understand the market.

With these metrics it is possible to analyze:

- Market growth over time
- Coin dominance
- Category dominance
- Price performance
- Risk and drawdown
- Market structure
- Volume trends

This transforms raw data into analytical information.

---

## Conclusion

The main focus of this project was not only data visualization, but also:

- Data modeling
- Medallion architecture
- Star schema
- Semantic layer
- Business metrics
- Time-based calculations
- Market share calculations
- Financial performance metrics

This project simulates a real business intelligence and analytics workflow, from raw data to business insights.
