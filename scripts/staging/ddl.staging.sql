=================================================================================================
DDL Script: Create the staging Tables
  This script create tables in the 'staging' schema, dropping existing tables if they already exist.
  Run this script to re-define the DDL of the 'staging' Tables.
=================================================================================================

-- staging CRM customers table
IF OBJECT_ID('staging.crm_system', 'U') is NOT NULL
    DROP TABLE staging.crm_system
CREATE TABLE staging.crm_customers (
    Customer_ID     FLOAT,
    Email           NVARCHAR(255),
    City            NVARCHAR(100),
    Country         NVARCHAR(100),
    Registration_Date NVARCHAR(50)
);

-- staging orders table
IF OBJECT_ID('staging.orders', 'U') is NOT NULL
    DROP TABLE staging.orders
CREATE TABLE staging.erp_orders (
    Invoice         NVARCHAR(20),
    Customer_ID     FLOAT,
    InvoiceDate     NVARCHAR(50) 
);
GO

-- staging order items 
IF OBJECT_ID('staging.order_items', 'U') is NOT NULL
    DROP TABLE staging.order_items
CREATE TABLE staging.erp_order_items (
    Invoice         NVARCHAR(20),
    StockCode       NVARCHAR(20),
    Description     NVARCHAR(255),
    Quantity        FLOAT,
    Price           FLOAT
);
