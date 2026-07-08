# Interview Notes

## 60-second project explanation

I built an end-to-end Azure retail data engineering pipeline. Azure SQL is the operational source, and Azure Data Factory handles initial, metadata-driven and watermark-based incremental ingestion. The incremental pipeline reads old and new watermark values, copies only records in the bounded processing window, and updates state after success.

ADF then orchestrates an Azure Databricks multi-task job through the Jobs API. Databricks implements Bronze, Silver and Gold layers using PySpark. Silver performs cleaning and referential-integrity validation, while Gold produces daily, customer, product and store sales aggregates. I tested the pipeline by inserting one new transaction: ADF copied exactly one row, the watermark advanced, Bronze and Silver reached 100,006 transactions, Gold reflected the sale, and Power BI consumed the Gold datasets.

## Questions to prepare

- Why use a watermark instead of a full reload?
- Why use both lower and upper watermark bounds?
- What happens if the pipeline fails before watermark update?
- How would you make the load idempotent?
- Why use metadata-driven ingestion?
- What belongs in Bronze, Silver and Gold?
- Why use Parquet?
- How did ADF trigger and check Databricks?
- How would you replace PAT/account-key authentication in production?
- How would you add SCD Type 2, Delta Lake, monitoring and CI/CD?
