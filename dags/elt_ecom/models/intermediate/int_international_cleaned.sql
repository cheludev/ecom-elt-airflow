SELECT
    TRY_TO_DATE("DATE_RAW", 'MM-DD-YY') AS order_date,
    "CUSTOMER" AS client,
    CAST("SKU" AS STRING) AS sku,
    CAST("GROSS_AMT_RAW" AS FLOAT) AS importe_bruto
FROM 
    {{ source('kaggle_raw', 'international_sales_raw') }}
WHERE 
    TRY_TO_DATE("DATE_RAW", 'MM-DD-YYYY') IS NOT NULL

