-- ==========================================
-- Part 1.3: SQL Queries
-- ==========================================

-- Q1: List all customers from Mumbai along with their total order value
-- Logic: Join Customers, Orders, OrderDetails, and Products to calculate the sum of (Quantity * Price)
SELECT 
    c.customer_name, 
    SUM(od.quantity * p.unit_price) AS total_order_value
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_name;

-- Q2: Find the top 3 products by total quantity sold
-- Logic: Sum the quantity for each product and sort in descending order
SELECT 
    p.product_name, 
    SUM(od.quantity) AS total_quantity_sold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 3;

-- Q3: List all sales representatives and the number of unique customers they have handled
-- Logic: Use COUNT(DISTINCT) to ensure each customer is only counted once per representative
SELECT 
    s.sales_rep_name, 
    COUNT(DISTINCT o.customer_id) AS unique_customers_handled
FROM SalesReps s
LEFT JOIN Orders o ON s.sales_rep_id = o.sales_rep_id
GROUP BY s.sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
-- Logic: Use HAVING clause to filter aggregated total order value
SELECT 
    od.order_id, 
    SUM(od.quantity * p.unit_price) AS total_value
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY od.order_id
HAVING total_value > 10000
ORDER BY total_value DESC;

-- Q5: Identify any products that have never been ordered
-- Logic: Use LEFT JOIN and filter for NULL values in the OrderDetails table
SELECT 
    p.product_name
FROM Products p
LEFT JOIN OrderDetails od ON p.product_id = od.product_id
WHERE od.product_id IS NULL;