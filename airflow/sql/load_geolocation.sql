-- load_geolocation.sql
SELECT 
    * 
FROM 
    geolocation 
WHERE 
    EXISTS 
        (SELECT 
            1 
         FROM 
            information_schema.tables 
        WHERE 
            table_name = 'geolocation');
