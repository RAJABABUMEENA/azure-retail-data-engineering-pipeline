# Project Implementation

## 1. Source and ingestion
Retail CSV files were loaded into Azure SQL Database. Azure Data Factory was used for an initial customer load, a reusable metadata-driven multi-table load, and a watermark-based incremental transaction load.

## 2. Incremental design
A `WatermarkControl` table stores the last successfully processed `last_modified_date`. Each run reads the old watermark, finds the new maximum watermark, copies rows inside the bounded window, and updates the control table only after successful movement.

## 3. Orchestration
`PL_Master_Retail_ETL` executes ingestion and then triggers the Databricks multi-task job through the Databricks Jobs API. The job executes Bronze, Silver and Gold tasks in dependency order.

## 4. Medallion processing
Bronze preserves source data, Silver cleans and validates it, and Gold creates `daily_sales`, `customer_sales`, `product_sales`, and `store_sales`.

## 5. End-to-end test
A single new transaction (`100006`) was inserted. ADF copied exactly one row, the watermark advanced, Bronze and Silver reached 100,006 transactions, and Gold reflected the new sale.

## 6. Analytics
Power BI reads the Gold datasets and presents executive KPIs, sales trends, product performance, store performance, customer analysis and category filtering.
