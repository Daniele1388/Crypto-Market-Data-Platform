-- Check First 10 Columns
SELECT TOP 10
	*
FROM brz.crypto_prices_raw

-- Count Rows
SELECT 
	COUNT(*) AS total_rows
FROM brz.crypto_prices_raw

-- Check Coin Name
SELECT DISTINCT
	coin_name
FROM brz.crypto_prices_raw
ORDER BY coin_name

-- Check Null
SELECT
	SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS null_date,
	SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price,
	SUM(CASE WHEN total_volume IS NULL THEN 1 ELSE 0 END) AS null_tot_volume,
	SUM(CASE WHEN market_cap IS NULL THEN 1 ELSE 0 END) AS null_market_cap,
	SUM(CASE WHEN coin_name IS NULL THEN 1 ELSE 0 END) AS null_coin_name
FROM brz.crypto_prices_raw