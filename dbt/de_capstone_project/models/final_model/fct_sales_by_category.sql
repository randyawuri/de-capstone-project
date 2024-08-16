SELECT
    product_category_name,
    total_sales
FROM
    {{ ref('int_sales_by_category') }}
ORDER BY
    total_sales DESC
