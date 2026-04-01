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

-- Create Insert Procedure
CREATE OR ALTER   PROCEDURE [slv].[load_data] AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	
	BEGIN TRY
			SET @start_time = GETDATE();

				TRUNCATE TABLE slv.crypto_prices_clean;

				INSERT INTO slv.crypto_prices_clean
				(
					crypto_date,
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

			SET @end_time = GETDATE();

			PRINT '==================================================';
			PRINT 'Loading Silver Layer Completed';
			PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
			PRINT '==================================================';
	END TRY
	BEGIN CATCH
			PRINT '=========================================================';
			PRINT 'ERROR OCCURRED DURING LOADING SILVER LAYER';
			PRINT 'Error Message :' + ERROR_MESSAGE();
			PRINT 'Error Number :' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'Error State :' + CAST(ERROR_STATE() AS NVARCHAR);
			PRINT 'Error Severity :' + CAST(ERROR_SEVERITY() AS NVARCHAR);
			PRINT 'Error Line :' + CAST(ERROR_LINE() AS NVARCHAR);
			PRINT 'Error Procedure :' + ISNULL(ERROR_PROCEDURE(), '-');
			PRINT '=========================================================';
	END CATCH 		
END

=======================================================
		INDEX
=======================================================

CREATE INDEX idx_crypto_coin_date
ON slv.crypto_prices_clean (coin_name,crypto_date)
