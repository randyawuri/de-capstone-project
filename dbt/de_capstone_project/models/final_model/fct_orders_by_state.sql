SELECT
    customer_state,
    total_orders
FROM
    {{ ref('int_orders_by_state') }}
ORDER BY
    total_orders DESC
