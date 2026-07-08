# Azure Retail Data Engineering Pipeline

End-to-end Azure data engineering project implementing initial ingestion, metadata-driven pipelines, watermark-based incremental loading, ADF orchestration, Databricks medallion processing, data-quality validation and Power BI analytics.

![Architecture](architecture/retail-data-engineering-architecture.png)

## Architecture

**Retail source data → Azure SQL Database → Azure Data Factory → ADLS Gen2 → Azure Databricks Bronze/Silver/Gold → Power BI**

An editable Mermaid flow is available in [`architecture/data-flow-diagram.md`](architecture/data-flow-diagram.md).

## What This Project Implements

- Initial Azure SQL ingestion with ADF
- Metadata-driven multi-table ingestion
- Watermark-based incremental processing
- Stored-procedure watermark state updates
- ADF master orchestration
- Databricks Jobs API integration
- Multi-task Bronze → Silver → Gold workflow
- PySpark transformations and validation
- ADLS Gen2 medallion storage
- Gold analytics datasets
- Power BI executive dashboard
- Real one-row end-to-end incremental test

## Source Data

| File | Purpose |
|---|---|
| `customers.csv` | Customer master data |
| `products.csv` | Product master data |
| `stores.csv` | Store master data |
| `transactions.csv` | Main retail transactions |
| `transactions_dq_test.csv` | Data-quality test records |

The project uses approximately 5,000 customers, 500 products, 50 stores and 100,005 initial transactions.

## Azure Data Factory

### Initial Load
The first pipeline validated connectivity, mapping and source-to-target movement.

![Initial Load](screenshots/03-initial-load.png)

### Metadata-Driven Ingestion
A reusable Lookup → ForEach → dynamic Copy pattern avoids duplicated pipelines.

![Metadata Pipeline](azure-data-factory/screenshots/metadata-driven-pipeline.png)

### Incremental Load
The transaction pipeline uses:

```sql
last_modified_date > OldWatermark
AND last_modified_date <= NewWatermark
```

The real test advanced the watermark from `2026-07-06T15:05:00Z` to `2026-07-07T10:00:00Z` and copied exactly one new transaction.

### Master Orchestration
ADF executes ingestion, triggers the Databricks medallion job, waits for startup and checks job status.

## Databricks Medallion Architecture

The included notebooks are the actual project notebooks:

1. `01_Bronze_Layer.ipynb`
2. `02_Silver_Layer.ipynb`
3. `03_Gold_Layer.ipynb`

![Databricks Job](databricks/screenshots/databricks-job.png)

### Bronze
Raw/minimally transformed ingestion. Verified transaction count after incremental test: **100,006**.

### Silver
Cleaning, standardization and referential-integrity checks. Verified invalid customer, product and store references: **0**. Verified transaction count: **100,006**.

### Gold
Analytics-ready outputs:

- `daily_sales`
- `customer_sales`
- `product_sales`
- `store_sales`

The new incremental transaction was reflected in Gold with 1 transaction, quantity 2, total sales 3,600, discount 100 and net sales 3,500.

## Power BI

![Retail Dashboard](power-bi/screenshots/retail-dashboard.png)

The dashboard includes:

- Total Revenue: **13.79bn**
- Total Net Sales: **13.02bn**
- Total Transactions: **100K**
- Total Customers: **5K**
- Sales trend
- Product performance
- Store performance
- Customer analysis
- Category slicer

## Repository Structure

```text
azure-retail-data-engineering-pipeline/
├── README.md
├── LICENSE
├── .gitignore
├── MISSING_ASSETS.md
├── architecture/
├── azure-data-factory/
│   ├── pipelines/
│   ├── datasets/
│   └── screenshots/
├── databricks/
│   ├── notebooks/
│   └── screenshots/
├── data/source/
├── sql/
├── power-bi/
├── screenshots/
└── docs/
```

## End-to-End Validation

1. Initial transaction count: **100,005**
2. Inserted transaction `100006`
3. ADF read exactly **1 row**
4. ADF copied exactly **1 row**
5. Watermark updated successfully
6. Databricks job ran Bronze → Silver → Gold
7. Bronze count: **100,006**
8. Silver count: **100,006**
9. Gold aggregates reflected the new transaction
10. Power BI consumed the Gold layer

## Security

Do not commit:

- Databricks PATs
- storage account keys
- SAS tokens
- passwords
- private connection strings

For production, use Managed Identity and Azure Key Vault.

## Documentation

- [Project implementation](docs/project-implementation.md)
- [Incremental loading](docs/incremental-loading.md)
- [Data quality](docs/data-quality.md)
- [Interview notes](docs/interview-notes.md)
- [Missing genuine exports](MISSING_ASSETS.md)

## Author

**Sneh Gupta**  
Data Engineering | Azure | PySpark | SQL
