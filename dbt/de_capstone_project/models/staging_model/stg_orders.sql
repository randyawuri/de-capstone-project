SELECT 
    distinct o.*
FROM 
    {{source('olist_ecommerce_store','orders')}} o
