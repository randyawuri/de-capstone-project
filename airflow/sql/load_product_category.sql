-- load_product_category_name_translation.sql
SELECT 
    * 
FROM 
    product_category_name_translation 
WHERE 
    EXISTS 
        (SELECT 
            1 
         FROM 
            information_schema.tables 
        WHERE 
            table_name = 'product_category_name_translation');
