-- load_customer.sql
SELECT 
    * 
FROM 
    customers
WHERE 
    EXISTS 
        (SELECT 
            1 
         FROM 
            information_schema.tables 
        WHERE 
            table_name ='customers');
