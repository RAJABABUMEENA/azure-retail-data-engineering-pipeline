CREATE OR ALTER PROCEDURE dbo.usp_UpdateWatermark
    @TableName NVARCHAR(128),
    @NewWatermarkValue DATETIME2
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.WatermarkControl
    SET LastWatermarkValue = @NewWatermarkValue
    WHERE TableName = @TableName;
END;
