=====================================================================================
Stored Procedure: Load Raw Layer (Source -> Raw)
  This procedure load data into the raw schema from external csv files.
  It performs the following actions:
    - Truncate the raw tables before loading data.
    - Uses the 'BULK INSERT' commands to load data from csv files to raw tables.

Parameters:
  None.
  This stored procedure doest not accept any parameters or return any values.

Usage Example:
  EXEC raw.load_raw;
=====================================================================================

-- load the data into the raw tables
-- 1# Load CRM customers
CREATE OR ALTER PROCEDURE raw.load_raw AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '====================================================';
        PRINT 'Loading Raw Layer';
        PRINT '====================================================';

        PRINT '----------------------------------------------------';
        PRINT 'Loading CRM Table';
        PRINT '----------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: raw.crm_customers'
        TRUNCATE TABLE raw.crm_customers;

        PRINT '>> Inserting Data Into: raw.crm_customers'
        BULK INSERT raw.crm_customers
        FROM 'D:\SQLImport\raw_crm_customers_pipe.csv'
        WITH (
            FIRSTROW     = 2,
            FIELDTERMINATOR = '|',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '----------------';

        PRINT '----------------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '----------------------------------------------------';

        -- 2# Load orders 

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: raw.erp_orders '
        TRUNCATE TABLE raw.erp_orders

        PRINT '>> Inserting Data Into: raw.erp_orders'
        BULK INSERT raw.erp_orders
        FROM 'D:\SQLImport\raw_orders_pipe.csv'
        WITH (
            FIRSTROW     = 2,
            FIELDTERMINATOR = '|',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '----------------';

        -- 3# Load order items

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: raw.erp_order_items'
        TRUNCATE TABLE raw.erp_order_items

        PRINT '>> Inserting Data Into: raw.erp_order_items'
        BULK INSERT raw.erp_order_items
        FROM 'D:\SQLImport\raw_order_items_pipe.csv'
        WITH (
            FIRSTROW     = 2,
            FIELDTERMINATOR = '|',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '----------------';

        SET @batch_end_time = GETDATE();
        PRINT '===================================='
        PRINT 'Loading Raw Layer is Completed';
        PRINT '    - Total Load Duration: ' + CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) +' seconds';
        PRINT '===================================='
    END TRY
    BEGIN CATCH
        PRINT '========================================'
        PRINT 'ERROR OCCURED DURING LOADIND RAW LAYER'
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '========================================'
    END CATCH   
END
