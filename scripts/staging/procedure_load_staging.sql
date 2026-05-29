============================================================================================================
Stored procedure: Load Staging Layer (Raw -> Staging)
============================================================================================================
Purpose:
  This Procedure performs the ETL (Extract, Transform, Load) process to populate the 'staging' schema tables
  from the 'raw' schema.
Actions Performed:
  - Truncate Staging tables
  - Inserts transformed and cleansed data from Raw into Staging tables.

Parameters:
  None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC Staging.load_staging;
============================================================================================================


