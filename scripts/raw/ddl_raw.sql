=================================================================================================
DDL Script: Create the Raw Tables
  This script create tables in the 'Raw' schema, dropping existing tables if they already exist.
  Run this script to re-define the DDL of the 'Raw' Tables.
=================================================================================================

-- Raw CRM customers table
IF OBJECT_ID('raw.crm_system', 'U') is NOT NULL
    DROP TABLE raw.crm_system
CREATE TABLE raw.crm_customers (
    Customer_ID     FLOAT,
    Email           NVARCHAR(255),
    City            NVARCHAR(100),
    Country         NVARCHAR(100),
    Registration_Date NVARCHAR(50)
);

-- Raw orders table
IF OBJECT_ID('raw.orders', 'U') is NOT NULL
    DROP TABLE raw.orders
CREATE TABLE raw.erp_orders (
    Invoice         NVARCHAR(20),
    Customer_ID     FLOAT,
    InvoiceDate     NVARCHAR(50) 
);
GO

-- Raw order items 
IF OBJECT_ID('raw.order_items', 'U') is NOT NULL
    DROP TABLE raw.order_items
CREATE TABLE raw.erp_order_items (
    Invoice         NVARCHAR(20),
    StockCode       NVARCHAR(20),
    Description     NVARCHAR(255),
    Quantity        FLOAT,
    Price           FLOAT
);
