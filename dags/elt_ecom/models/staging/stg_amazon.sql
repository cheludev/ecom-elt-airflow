
SELECT
    "ORDER_ID",
    TO_DATE("ORDER_DATE_RAW", 'MM-DD-YY') as order_date,
    CASE 
        WHEN LOWER("STATUS") LIKE 'shipped%' THEN 'shipped'
        WHEN LOWER("STATUS") LIKE 'pending%' THEN 'pending'
        WHEN LOWER("STATUS") = 'shipping' THEN 'pending'
        WHEN LOWER("STATUS") = 'canceled%' THEN 'canceled'
    END AS status_grouped,
    "FULFILMENT" as client,
    "SKU" as sku,
    "AMOUNT_RAW" as importe_bruto
FROM
    {{ source('kaggle_raw', 'amazon_sales_raw') }}
