SELECT COUNT(*) AS transaction_count
FROM dbo.transactions;

SELECT *
FROM dbo.WatermarkControl
WHERE TableName = 'transactions';

SELECT MAX(last_modified_date) AS new_watermark
FROM dbo.transactions;

-- Logical incremental extraction window:
DECLARE @OldWatermark DATETIME2 = '2026-07-06T15:05:00';
DECLARE @NewWatermark DATETIME2 = '2026-07-07T10:00:00';

SELECT *
FROM dbo.transactions
WHERE last_modified_date > @OldWatermark
  AND last_modified_date <= @NewWatermark;
