WITH orders_by_state AS (
    SELECT
        c.customer_state,
        COUNT(o.order_id) AS total_orders
    FROM
        {{ ref('stg_orders') }} o
    JOIN
         {{ ref('stg_order_items') }} oi
    ON
        o.order_id = oi.order_id
    JOIN
        {{ ref('stg_customers') }} c
    ON
        o.customer_id = c.customer_id
    GROUP BY
        c.customer_state
)

SELECT
    customer_state,
    total_orders
FROM
    orders_by_state
ORDER BY
    total_orders DESC;

