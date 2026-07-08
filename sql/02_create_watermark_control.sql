CREATE TABLE dbo.WatermarkControl (
    TableName NVARCHAR(128) PRIMARY KEY,
    LastWatermarkValue DATETIME2 NOT NULL
);

INSERT INTO dbo.WatermarkControl (TableName, LastWatermarkValue)
VALUES ('transactions', '2026-07-06T15:05:00');
