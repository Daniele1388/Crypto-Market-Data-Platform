=======================================================
		BRONZE LAYER
=======================================================

--Create DB
CREATE DATABASE Crypto_DB;

--Make DB Single User
USE master

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Crypto_DB')
BEGIN
	ALTER DATABASE Crypto_DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
END;
GO

--Create Schema
USE Crypto_DB

CREATE SCHEMA brz;

CREATE SCHEMA slv;

CREATE SCHEMA gld;

--Create Bronze Table
IF OBJECT_ID ('brz.crypto_prices_raw', 'U') IS NOT NULL
	DROP TABLE brz.crypto_prices_raw;
CREATE TABLE brz.crypto_prices_raw(

	date NVARCHAR(50),
	price NVARCHAR(50),
	total_volume NVARCHAR(50),
	market_cap NVARCHAR(50),
	coin_name NVARCHAR(50)

)
