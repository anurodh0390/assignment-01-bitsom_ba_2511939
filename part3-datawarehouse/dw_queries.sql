-- ==========================================
-- Part 3.2: Analytical Queries (Data Warehouse)
-- ==========================================

-- Q1: Total sales revenue by product category for each month
-- Logic: Aggregate revenue by joining Product and Date dimensions with the Fact table
SELECT 
    p.category, 
    d.month, 
    SUM(f.total_revenue) AS monthly_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY p.category, d.month;

-- Q2: Top 2 performing stores by total revenue
-- Logic: Sum revenue per store and sort in descending order to find the highest earners
SELECT 
    s.store_name, 
    SUM(f.total_revenue) AS total_store_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_id = s.store_id
GROUP BY s.store_name
ORDER BY total_store_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
-- Logic: Track total sales growth by grouping data sequentially by year and month
SELECT 
    d.year, 
    d.month, 
    SUM(f.total_revenue) AS total_monthly_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month;