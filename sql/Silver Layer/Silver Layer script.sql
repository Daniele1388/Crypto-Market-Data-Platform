=======================================================
		SILVER LAYER

=======================================================

-- Create Silver Table
IF OBJECT_ID('slv.crypto_prices_clean', 'U') IS NOT NULL
	DROP TABLE slv.crypto_prices_clean;
CREATE TABLE slv.crypto_prices_clean
(
	crypto_date DATE NOT NULL,	
	price DECIMAL(18,8) NULL,
	total_volume DECIMAL(20,2) NULL,
	market_cap DECIMAL(20,2) NULL,
	coin_name NVARCHAR(50) NOT NULL
);

=====================================================

-- Create Insert Procedure
ALTER   PROCEDURE [slv].[load_data] AS
BEGIN
	TRUNCATE TABLE slv.crypto_prices_clean;
	INSERT INTO slv.crypto_prices_clean
	(
		date,
		price,
		total_volume,
		market_cap,
		coin_name
	)
	SELECT
		TRY_CONVERT(date, r.date) AS crypto_date, 
		TRY_CONVERT(decimal(18,8), r.price) AS price,
		TRY_CONVERT(decimal(20,2), r.total_volume) AS total_volume,
		TRY_CONVERT(decimal(20,2), r.market_cap) AS market_cap,
		LTRIM(RTRIM(coin_name)) AS coin_name
	FROM brz.crypto_prices_raw r;
END

=======================================================
		INDEX

=======================================================

CREATE INDEX idx_crypto_coin_date
ON slv.crypto_prices_clean (coin_name,crypto_date)