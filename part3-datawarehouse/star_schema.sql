-- ==========================================
-- Part 3.1: Star Schema Design
-- ==========================================

-- 1. Dimension Tables
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL,
    quarter INT NOT NULL
);

CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    brand VARCHAR(50)
);

-- 2. Central Fact Table
CREATE TABLE fact_sales (
    transaction_id INT PRIMARY KEY,
    date_key INT,
    store_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_revenue DECIMAL(12, 2) AS (quantity * unit_price),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- 3. Cleaned Sample Data (10 rows for fact table)
-- Dimension data must be inserted first
INSERT INTO dim_date VALUES (20231101, '2023-11-01', 11, 2023, 4), (20231102, '2023-11-02', 11, 2023, 4);
INSERT INTO dim_store VALUES (10, 'Main Street Store', 'Delhi', 'North'), (20, 'Ocean View', 'Mumbai', 'West');
INSERT INTO dim_product VALUES (101, 'Smartphone', 'Electronics', 'TechCo'), (102, 'Coffee Mug', 'Kitchen', 'HomeStyle');

-- 10 Cleaned Fact Rows
INSERT INTO fact_sales (transaction_id, date_key, store_id, product_id, quantity, unit_price) VALUES
(1, 20231101, 10, 101, 2, 25000.00),
(2, 20231101, 20, 102, 5, 500.00),
(3, 20231101, 10, 102, 1, 500.00),
(4, 20231102, 20, 101, 1, 25000.00),
(5, 20231102, 10, 101, 3, 25000.00),
(6, 20231102, 20, 102, 10, 500.00),
(7, 20231102, 10, 102, 2, 500.00),
(8, 20231102, 20, 101, 1, 25000.00),
(9, 20231101, 10, 101, 1, 25000.00),
(10, 20231102, 20, 102, 4, 500.00);