Proyecto: Pipeline ELT E-Commerce (Local a Snowflake)
Este proyecto representa mi segunda incursión en la construcción de un flujo ELT (Extract, Load, Transform) de extremo a extremo, enfocándome esta vez en la Ingesta de Datos (E/L) desde una fuente local (archivos .csv de un e-commerce) hasta un modelo analítico en la nube.

La meta era clara: Transformar datos de ventas complejos en una tabla final (fct_sales_performance) lista para responder preguntas de negocio sobre rendimiento y fulfillment.

1. Stack Tecnológico  

Componente	Rol en el Pipeline
Snowflake	Data Warehouse y Motor de Cómputo (La 'L' y el motor de la 'T').
dbt (Data Build Tool)	Capas de Transformación (Staging y Marts).
SnowSQL	Herramienta de línea de comandos para la Ingesta Local (PUT).
Airflow (Conceptual)	Orquestador del flujo completo.

2. El Mayor Desafío: Ingesta Robusta (E/L) 

La parte más complicada del proyecto no fue el modelado, sino la ingesta de los datos locales a Snowflake, un problema común cuando se trabaja con archivos legacy.

Problema del Mapeo de Columnas (El Desfase): El archivo de ventas (amazon_sale_report.csv) tenía 24 columnas, mientras que la tabla RAW en Snowflake (amazon_sales_raw) tenía 25 (la columna extra es LOAD_TIMESTAMP con DEFAULT). Esto causó fallos de carga porque Snowflake intentaba forzar el último texto del CSV en el campo TIMESTAMP.

Solución Posicional: La solución requirió aplicar la best practice de Mapeo Explícito de Columnas en el comando COPY INTO. Listé manualmente las 24 columnas del archivo en la sentencia SQL, dejando libre la columna LOAD_TIMESTAMP para que tomara su valor DEFAULT. Esto resolvió el error de Timestamp is not recognized.

Superando al Shell: Tuve que luchar contra la sintaxis quisquillosa de SnowSQL con el comando PUT, renombrando los archivos localmente para eliminar espacios y evitar errores de parsing del shell en el COPY INTO.

3. Modelado dbt: De Caos a Mart de Ventas 

Una vez que los datos crudos estuvieron en la capa RAW, dbt se encargó de la limpieza y la lógica:

Capa Staging (stg_amazon_sales): Se realizó la limpieza inicial, incluyendo el casting crucial de tipos de datos (ej. VARCHAR → DECIMAL, DATE) y el filtrado de valores nulos o no válidos.

Capa Mart (fct_sales_performance): Creé la tabla analítica final que responde a preguntas de negocio:

Agregaciones: SUM(total_amount), COUNT(DISTINCT order_id).

Dimensiones de Negocio: Segmentación por Categoría, Tipo de Fulfillment (Amazon vs. Merchant) y Clientes B2B vs. Consumidor.
