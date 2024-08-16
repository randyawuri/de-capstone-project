SELECT 
    distinct * 
FROM 
    {{source('olist_ecommerce_store','order_items')}}