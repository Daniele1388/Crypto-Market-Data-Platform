=======================================================
		GOLD LAYER

=======================================================

-- Create Gold View (Dim and Fact Tables)
CREATE OR ALTER VIEW gld.dim_date AS
WITH unique_date AS(
	SELECT DISTINCT 
		crypto_date
	FROM slv.crypto_prices_clean
)
SELECT
	ROW_NUMBER() OVER(ORDER BY crypto_date) AS date_key,
	crypto_date AS full_date,
	YEAR(crypto_date) AS year_number,
	MONTH(crypto_date) AS month_number,
	DATENAME(MONTH, crypto_date) AS month_name,
	DAY(crypto_date) AS day_number
FROM unique_date
GO;

CREATE OR ALTER VIEW gld.dim_coin AS
WITH unique_coin AS(
	SELECT DISTINCT
		coin_name
	FROM slv.crypto_prices_clean	
)
SELECT
	ROW_NUMBER() OVER(ORDER BY coin_name) AS coin_key,
	coin_name
FROM unique_coin
GO;

CREATE OR ALTER VIEW gld.fact_crypto_market AS
SELECT
	d.date_key,
	c.coin_key,
	cl.price,
	cl.total_volume,
	cl.market_cap
FROM slv.crypto_prices_clean cl
LEFT JOIN gld.dim_date d
ON d.full_date = cl.crypto_date
LEFT JOIN gld.dim_coin c
ON c.coin_name = cl.coin_name
GO;