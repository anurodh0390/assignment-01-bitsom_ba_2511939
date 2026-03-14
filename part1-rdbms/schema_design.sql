-- ==========================================
-- Part 1.2: Schema Design (3NF)
-- ==========================================

-- 1. Customers Table: Stores personal details of customers
CREATE TABLE Customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);

-- 2. Products Table: Stores product information and pricing
CREATE TABLE Products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

-- 3. SalesReps Table: Stores details of sales representatives and their offices
CREATE TABLE SalesReps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL,
    office_address TEXT NOT NULL
);

-- 4. Orders Table: Stores general transaction info linking customers and sales reps
CREATE TABLE Orders (
    order_id VARCHAR(10) PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id VARCHAR(10),
    sales_rep_id VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES SalesReps(sales_rep_id)
);

-- 5. OrderDetails Table: Stores specific products and quantities for each order
CREATE TABLE OrderDetails (
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- ==========================================
-- Data Insertion (5 rows per table)
-- ==========================================

-- Populating Customers
INSERT INTO Customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001', 'Rohan Mehta', 'rohan@gmail.com', 'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com', 'Delhi'),
('C003', 'Amit Verma', 'amit@gmail.com', 'Bangalore'),
('C004', 'Sneha Iyer', 'sneha@gmail.com', 'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai');

-- Populating Products
INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
('P001', 'Laptop', 'Electronics', 55000),
('P002', 'Mouse', 'Electronics', 800),
('P003', 'Desk Chair', 'Furniture', 8500),
('P004', 'Notebook', 'Stationery', 120),
('P005', 'Headphones', 'Electronics', 3200);

-- Populating Sales Representatives
INSERT INTO SalesReps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point'),
('SR02', 'Anita Desai', 'anita@corp.com', 'Delhi Office, Connaught Place'),
('SR03', 'Ravi Kumar', 'ravi@corp.com', 'South Zone, MG Road'),
('SR04', 'Sara Khan', 'sara@corp.com', 'East Zone, Kolkata'),
('SR05', 'Rahul Dev', 'rahul@corp.com', 'North Zone, Chandigarh');

-- Populating Orders (Linking to Customers C001-C005)
INSERT INTO Orders (order_id, order_date, customer_id, sales_rep_id) VALUES
('ORD1001', '2023-11-02', 'C002', 'SR02'),
('ORD1002', '2023-08-06', 'C001', 'SR01'),
('ORD1003', '2023-02-14', 'C003', 'SR01'),
('ORD1004', '2023-01-17', 'C002', 'SR02'),
('ORD1005', '2023-11-10', 'C005', 'SR02');

-- Populating Order Details (Linking to Products P001-P005)
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
('ORD1001', 'P004', 4),
('ORD1002', 'P001', 1),
('ORD1003', 'P002', 3),
('ORD1004', 'P005', 1),
('ORD1005', 'P003', 1);