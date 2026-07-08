# ADF Datasets and Linked Services

The project uses parameterized Azure Data Factory datasets and linked services for:

- Azure SQL source/landing connectivity
- ADLS Gen2 landing-zone access
- Dynamic table processing in the metadata-driven pipeline

Before publishing a public export, remove or parameterize:

- passwords
- account keys
- SAS tokens
- access tokens
- connection strings
- tenant/subscription-specific secrets

Store secrets in Azure Key Vault or use Managed Identity for a production implementation.
