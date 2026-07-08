# Project Implementation

## Solution overview

This project implements a complete retail analytics pipeline across Azure SQL Database, Azure Data Factory, ADLS Gen2, Azure Databricks and Power BI.

## Azure environment

The solution is deployed in the `rg-retail-de-project` resource group and includes Data Factory, Databricks, ADLS Gen2, Azure SQL, Key Vault and the Databricks Access Connector.

## Ingestion patterns

### Initial load
The initial customer pipeline validated source-to-target connectivity and mapping.

### Metadata-driven load
A Lookup → ForEach → dynamic Copy pattern provides reusable ingestion for multiple source tables.

### Incremental transactions
The transaction pipeline reads the previous watermark, calculates the new maximum watermark, copies only the bounded change window and updates the control table after success.

The implemented sequence is visible in `azure-data-factory/screenshots/incremental-pipeline-design.png`, and the successful activity output is captured in `incremental-pipeline-success.png`.

## Master orchestration

`PL_Master_Retail_ETL` executes the incremental load, invokes the Databricks Medallion workflow, waits for startup and checks the Databricks job status. Both the design canvas and a successful execution are included in the repository.

## Databricks processing

The multi-task job runs:

1. Bronze ingestion
2. Silver transformation and quality checks
3. Gold aggregation

The notebooks are included as real `.ipynb` files.

## Analytics

Four Gold datasets — `daily_sales`, `customer_sales`, `product_sales` and `store_sales` — feed the Power BI executive dashboard.

## Verified end-to-end test

A new transaction with ID `100006` was inserted. The incremental ADF pipeline copied one row, advanced the watermark, triggered Databricks, increased Bronze and Silver counts to 100,006, updated Gold aggregates and made the result available to Power BI.
