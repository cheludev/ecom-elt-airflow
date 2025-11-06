SELECT
    TRY_TO_DATE("ORDER_DATE_RAW", 'MM-DD-YY') AS order_date,
    "FULFILMENT" AS client,
    CAST("SKU" AS STRING) AS sku,
    CAST("AMOUNT_RAW" AS FLOAT) AS importe_bruto
FROM 
    {{ source('kaggle_raw', 'amazon_sales_raw') }}
WHERE 
    LOWER("STATUS") LIKE 'shipped%'

