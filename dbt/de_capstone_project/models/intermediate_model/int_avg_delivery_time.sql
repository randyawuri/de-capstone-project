WITH delivery_times AS (
    SELECT
        o.order_id,
        TIMESTAMP_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, HOUR) AS delivery_time_hours
    FROM
        {{ ref('stg_orders') }} o
    WHERE
        o.order_delivered_customer_date IS NOT NULL
)

SELECT
    order_id,
    delivery_time_hours
FROM
    delivery_times;