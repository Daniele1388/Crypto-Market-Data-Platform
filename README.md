# Crypto BI Project

## Project Overview

This project is an end to end data analytics project about the cryptocurrency market.  
The goal of the project is to build a complete data pipeline, starting from raw CSV files and ending with an interactive Power BI dashboard.

The project includes data ingestion with Python, data transformation in SQL Server using a Medallion Architecture, a star schema data model, business metrics in Power BI and a final dashboard for market analysis.

The dashboard allows the user to analyze the crypto market from different perspectives: market overview, single coin analysis and category comparison.

---

## Architecture

The project follows a Medallion Architecture with three layers:

**Bronze**  
Raw data imported from CSV files without transformations.

**Silver**  
Cleaned and structured data. Data types are fixed, null values are handled and data is prepared for analysis.

**Gold**  
Business level data. In this layer the star schema is created with fact and dimension tables.

The main tables are:

- Fact_crypto_market  
- Dim_coin  
- Dim_date  

Power BI connects to the Gold layer and uses DAX measures to calculate business metrics.

---

## Data Pipeline

The data pipeline works in this way:

1. CSV files contain historical data for each cryptocurrency.  
2. A Python script loads the CSV files into SQL Server Bronze tables.  
3. SQL scripts transform data from Bronze to Silver (cleaning and formatting).  
4. Data is aggregated and modeled in the Gold layer.  
5. A star schema is created for analytics.  
6. Power BI connects to the Gold layer.  
7. DAX measures calculate metrics like market cap, volume, market share and price change.  
8. The dashboard shows the final results.  

This pipeline simulates a real data warehouse workflow.

---

## Data Model

The data model is a star schema.

**Fact table**

- Fact_crypto_market  
  Contains price, volume and market cap.

**Dimension tables**

- Dim_coin  
  Contains coin information and categories.  
- Dim_date  
  Contains date hierarchy (day, month, year).

**Relationships**

- Fact_crypto_market → Dim_coin  
- Fact_crypto_market → Dim_date  

This model allows fast analysis and simple aggregation.

---

## Metrics

The project includes several business metrics calculated with DAX.

**Main metrics**

- Total Market Cap  
- Total Volume  
- Last Coin Market Cap  
- Last Coin Volume  
- Last Coin Price  
- Category Market Cap  
- Price Change %  
- Coin Market Share %  
- Category Market Share %  
- Drawdown %  

These metrics allow analysis of market size, performance and market dominance.

---

## Dashboard

The Power BI dashboard is divided into four pages.

**Coin Directory**  
List of all cryptocurrencies with market cap, volume and market share.

**Market Overview**  
General view of the crypto market with market cap trend, volume trend and top coins.

**Coin Explorer**  
Detailed analysis of a single cryptocurrency with price trend, market cap, volume and drawdown.

**Crypto Category Comparison**  
Comparison between crypto categories with market cap, volume, market share and scatter plot analysis.

The dashboard allows interactive analysis using slicers and filters.

---
## Repository Structure

```
crypto-data-platform/
│
├── README.md
│
├── data/
│   └── raw_csv_sample/
│
├── python/
│   └──data_ingestion.py
│
├── sql/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── powerbi/
│   └── crypto_dashboard.pbix
│
├── architecture/
│   └── architecture_diagram.png
│
└── docs/
    └── project_description.md
```

---

## Technologies Used

The project uses the following technologies:

- Python  
- SQL Server  
- T-SQL  
- Power BI  
- DAX  
- Medallion Architecture  
- Star Schema Data Modeling  
- Data Warehouse concepts  

---

## How to Run the Project

To run this project:

1. Load CSV files into the data folder.
2. Run SQL scripts to create Bronze layer.  
3. Run the Python script to load data into SQL Server Bronze tables.  
4. Run SQL scripts to create Silver and Gold layers.  
5. Create fact and dimension tables.  
6. Open the Power BI file.  
7. Refresh the data model.  
8. Explore the dashboard.  

---

## Future Improvements

Possible future improvements:

- Add automatic data update  
- Add more cryptocurrencies  
- Add volatility metrics  
- Add moving averages  
- Add forecasting models  
- Deploy the project in the cloud  
- Create a web dashboard  
