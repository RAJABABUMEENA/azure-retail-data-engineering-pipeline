# Data Quality and Validation

The Silver layer performs cleaning and validation before data reaches analytics.

Verified checks included:

- invalid `customer_id` references: `0`
- invalid `product_id` references: `0`
- invalid `store_id` references: `0`
- Bronze transaction count after incremental test: `100,006`
- Silver transaction count after incremental test: `100,006`

The repository also includes `transactions_dq_test.csv`, a small dataset intended for data-quality testing.
