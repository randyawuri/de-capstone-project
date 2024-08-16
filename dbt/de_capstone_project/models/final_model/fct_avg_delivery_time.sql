SELECT
    AVG(delivery_time_days) AS avg_delivery_time_days
FROM
    {{ ref('int_avg_delivery_time') }}
