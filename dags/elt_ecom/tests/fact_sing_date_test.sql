SELECT *
FROM {{ ref('fct_sales') }}
WHERE  date(order_date) > CURRENT_DATE()
    or date(order_date) < date('1990-01-01')
