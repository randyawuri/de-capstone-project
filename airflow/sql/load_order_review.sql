SELECT 
    * 
FROM 
    order_reviews
WHERE 
    EXISTS 
        (SELECT 
            1 
         FROM 
            information_schema.tables 
        WHERE 
            table_name = 'order_reviews');