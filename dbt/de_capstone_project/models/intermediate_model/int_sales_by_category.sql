WITH sales_data AS (
    SELECT
        oi.product_id,
        oi.order_id,
        oi.price  AS price, 
        p.product_category_name
    FROM
    
        {{ ref('stg_orders') }} o
    JOIN
        {{ ref('stg_order_items') }} oi
    ON
        o.order_id = oi.order_id
    JOIN
        {{ ref('stg_products') }} p
    ON
        oi.product_id = p.product_id
)

SELECT
    product_category_name,
    ROUND(SUM(price),2) AS total_sales
FROM
    sales_data
GROUP BY
    product_category_name
ORDER BY
    total_sales DESC;

