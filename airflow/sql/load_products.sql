
-- load_products.sql
SELECT 
    * 
FROM 
    products 
WHERE 
    EXISTS 
        (SELECT 
            1 
         FROM 
            information_schema.tables 
        WHERE 
            table_name = 'products');
