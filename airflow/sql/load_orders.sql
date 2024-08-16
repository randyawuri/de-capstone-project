-- load_orders.sql
SELECT 
    * 
FROM 
    orders
WHERE 
    EXISTS 
        (SELECT 
            1 
         FROM 
            information_schema.tables 
        WHERE 
            table_name = 'orders');