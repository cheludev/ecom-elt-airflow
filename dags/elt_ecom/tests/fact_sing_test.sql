SELECT *
FROM {{ ref('fct_sales') }}
WHERE order_date IS NULL
