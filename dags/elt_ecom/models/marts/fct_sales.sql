SELECT
    order_date,
    client,
    sku,
    importe_bruto
FROM {{ ref('int_amazon_cleaned') }}

UNION ALL

SELECT
    order_date,
    client,
    sku,
    importe_bruto
FROM {{ ref('int_international_cleaned') }}