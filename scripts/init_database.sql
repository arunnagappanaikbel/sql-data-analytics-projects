/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called gold
	
WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- Connect to 'postgres' or another safe database first (you cannot drop the one you're connected to)
-- Then run:

DROP DATABASE IF EXISTS "DataWarehouseAnalytics";


-- Create the 'DataWarehouseAnalytics' database

CREATE DATABASE "DataWarehouseAnalytics"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


---------------------------------create gold schema and create the tables----------------------------

CREATE SCHEMA gold;

CREATE TABLE gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number VARCHAR(50),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	country VARCHAR(50),
	marital_status VARCHAR(50),
	gender VARCHAR(50),
	birthdate date,
	create_date date
);


CREATE TABLE gold.dim_products(
	product_key int ,
	product_id int ,
	product_number varchar(50) ,
	product_name varchar(50) ,
	category_id varchar(50) ,
	category varchar(50) ,
	subcategory varchar(50) ,
	maintenance varchar(50) ,
	cost int,
	product_line varchar(50),
	start_date date 
);


CREATE TABLE gold.fact_sales(
	order_number varchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity smallint,
	price int
);


--insert data into the tables

TRUNCATE TABLE gold.dim_customers;

COPY gold.dim_customers
    FROM 'D:\Data Engineering\SQL Projects\sql-data-analytics-project\sql-data-analytics-project\datasets\csv-files\gold.dim_customers.csv'
    WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ','
    );

TRUNCATE TABLE gold.dim_products;

COPY gold.dim_products
    FROM 'D:\Data Engineering\SQL Projects\sql-data-analytics-project\sql-data-analytics-project\datasets\csv-files\gold.dim_products.csv'
    WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ','
    );


TRUNCATE TABLE gold.fact_sales;

 COPY gold.fact_sales
    FROM 'D:\Data Engineering\SQL Projects\sql-data-analytics-project\sql-data-analytics-project\datasets\csv-files\gold.fact_sales.csv'
    WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ','
    );

