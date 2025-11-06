SELECT 
    "INDEX_COL" as id,  
    TO_DATE("DATE_RAW", 'MM-DD-YY') as order_date, 
    "CUSTOMER" as client,
    "SKU",
    "PCS_RAW" as num_piezas,
    "RATE_RAW" as precio_unidad,
    "GROSS_AMT_RAW" as importe_bruto, 
    "LOAD_TIMESTAMP"
FROM 
    {{ source('kaggle_raw', 'international_sales_raw') }}
