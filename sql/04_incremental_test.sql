-- Test record used to validate one-row incremental processing.
-- Adjust non-key values to match your deployed source schema if necessary.
INSERT INTO dbo.transactions (
    transaction_id, customer_id, product_id, store_id,
    transaction_date, quantity, unit_price, discount,
    payment_method, last_modified_date
)
VALUES (
    100006, 1, 1, 1,
    '2026-07-07T10:00:00', 2, 1800.00, 100.00,
    'Card', '2026-07-07T10:00:00'
);

SELECT *
FROM dbo.transactions
WHERE transaction_id = 100006;
