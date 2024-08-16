-- load_order_items.sql
SELECT 
    * 
FROM 
    order_items
WHERE 
    EXISTS 
        (SELECT 
            1 
         FROM 
            information_schema.tables 
        WHERE 
            table_name = 'order_items');
