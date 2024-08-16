-- load_sellers.sql
SELECT 
    * 
FROM 
    sellers 
WHERE 
    EXISTS 
        (SELECT 
            1 
         FROM 
            information_schema.tables 
        WHERE 
            table_name = 'sellers');
