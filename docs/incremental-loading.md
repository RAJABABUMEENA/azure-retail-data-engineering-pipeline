# Watermark-Based Incremental Loading

The transaction pipeline uses a bounded watermark window:

```sql
last_modified_date > OldWatermark
AND last_modified_date <= NewWatermark
```

## Flow

1. Read `LastWatermarkValue` from `WatermarkControl`.
2. Read `MAX(last_modified_date)` from the source.
3. Copy only rows in the bounded window.
4. On success, update `WatermarkControl` with `NewWatermarkValue`.

## Verified test

- Old watermark: `2026-07-06T15:05:00Z`
- New watermark: `2026-07-07T10:00:00Z`
- Rows read: `1`
- Rows copied: `1`
- Test transaction ID: `100006`

This proves the pipeline avoids a full reload of the transaction table.
