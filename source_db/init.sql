-- Create table for customers if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'customers') THEN
        CREATE TABLE customers (
            customer_id VARCHAR(255) PRIMARY KEY,
            customer_unique_id VARCHAR(255),
            customer_zip_code_prefix INTEGER,
            customer_city VARCHAR(255),
            customer_state CHAR(2)
        );
    END IF;
END $$;

-- Create table for geolocation if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'geolocation') THEN
        CREATE TABLE geolocation (
            geolocation_zip_code_prefix INTEGER,
            geolocation_lat NUMERIC,
            geolocation_lng NUMERIC,
            geolocation_city VARCHAR(255),
            geolocation_state CHAR(2)
        );
    END IF;
END $$;

-- Create table for order items if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'order_items') THEN
        CREATE TABLE order_items (
            order_id VARCHAR(255),
            order_item_id INTEGER,
            product_id VARCHAR(255),
            seller_id VARCHAR(255),
            shipping_limit_date TIMESTAMP,
            price NUMERIC,
            freight_value NUMERIC,
            PRIMARY KEY (order_id, order_item_id)
        );
    END IF;
END $$;

-- Create table for order payments if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'order_payments') THEN
        CREATE TABLE order_payments (
            order_id VARCHAR(255),
            payment_sequential INTEGER,
            payment_type VARCHAR(50),
            payment_installments INTEGER,
            payment_value NUMERIC,
            PRIMARY KEY (order_id, payment_sequential)
        );
    END IF;
END $$;

-- Create table for orders if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'orders') THEN
        CREATE TABLE orders (
            order_id VARCHAR(255) PRIMARY KEY,
            customer_id VARCHAR(255),
            order_status VARCHAR(50),
            order_purchase_timestamp TIMESTAMP,
            order_approved_at TIMESTAMP,
            order_delivered_carrier_date TIMESTAMP,
            order_delivered_customer_date TIMESTAMP,
            order_estimated_delivery_date TIMESTAMP
        );
    END IF;
END $$;

-- Create table for products if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'products') THEN
        CREATE TABLE products (
            product_id VARCHAR(255) PRIMARY KEY,
            product_category_name VARCHAR(255),
            product_name_length NUMERIC,
            product_description_length NUMERIC,
            product_photos_qty NUMERIC,
            product_weight_g NUMERIC,
            product_length_cm NUMERIC,
            product_height_cm NUMERIC,
            product_width_cm NUMERIC
        );
    END IF;
END $$;

-- Create table for sellers if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'sellers') THEN
        CREATE TABLE sellers (
            seller_id VARCHAR(255) PRIMARY KEY,
            seller_zip_code_prefix INTEGER,
            seller_city VARCHAR(255),
            seller_state CHAR(2)
        );
    END IF;
END $$;

-- Create table for product category name translation if it doesn't exist
CREATE TABLE product_category_name_translation (
            product_category_name VARCHAR(255) PRIMARY KEY,
            product_category_name_english VARCHAR(255)
        );

DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'order_reviews') THEN
        CREATE TABLE order_reviews (
            review_id VARCHAR(255) PRIMARY KEY,
            order_id VARCHAR(255),
            review_score INTEGER,
            review_comment_title TEXT,
            review_comment_message TEXT,
            review_creation_date TIMESTAMP,
            review_answer_timestamp TIMESTAMP
        );
    END IF;
END $$;

-- Copy data from CSV files into the tables
COPY customers FROM '/docker-entrypoint-initdb.d/olist_customers_dataset.csv' DELIMITER ',' CSV HEADER;
COPY geolocation FROM '/docker-entrypoint-initdb.d/olist_geolocation_dataset.csv' DELIMITER ',' CSV HEADER;
COPY order_items FROM '/docker-entrypoint-initdb.d/olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER;
COPY order_payments FROM '/docker-entrypoint-initdb.d/olist_order_payments_dataset.csv' DELIMITER ',' CSV HEADER;
COPY orders FROM '/docker-entrypoint-initdb.d/olist_orders_dataset.csv' DELIMITER ',' CSV HEADER;
COPY products FROM '/docker-entrypoint-initdb.d/olist_products_dataset.csv' DELIMITER ',' CSV HEADER;
COPY sellers FROM '/docker-entrypoint-initdb.d/olist_sellers_dataset.csv' DELIMITER ',' CSV HEADER;
COPY product_category_name_translation FROM '/docker-entrypoint-initdb.d/product_category_name_translation.csv' DELIMITER ',' CSV HEADER;
COPY order_reviews FROM '/docker-entrypoint-initdb.d/olist_order_reviews_dataset.csv' DELIMITER ',' CSV HEADER;