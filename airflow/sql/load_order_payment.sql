-- load_order_payments.sql
SELECT 
    * 
FROM 
    order_payments 
WHERE 
    EXISTS 
        (SELECT 
            1 
         FROM 
            information_schema.tables 
        WHERE 
            table_name = 'order_payments');
