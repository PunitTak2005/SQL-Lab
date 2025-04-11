-- 🌐 Create a new database for our e-commerce system
CREATE DATABASE ecomDB;

-- 🧭 Set the context to use the newly created database
USE ecomDB;

-- 🧑‍💼 Table to store customer details (our precious buyers)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY, -- Unique ID for each customer
    first_name VARCHAR(50),      -- Customer's first name
    last_name VARCHAR(50),       -- Customer's last name
    email VARCHAR(100),          -- Contact email
    address VARCHAR(255),        -- Shipping address
    phone VARCHAR(20)            -- Contact phone number
);

-- 📦 Table to store product information (things we sell!)
CREATE TABLE Products (
    product_id INT PRIMARY KEY,        -- Unique product ID
    product_name VARCHAR(100),         -- Name of the product
    price DECIMAL(10, 2),              -- Price in dollars with cents
    stock_quantity INT,                -- Inventory count
    category VARCHAR(50)               -- Category like Electronics, Fitness, etc.
);

-- 📃 Table to store orders made by customers
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,                     -- Unique ID for the order
    customer_id INT,                              -- Link to customer who placed the order
    order_date DATE,                              -- When the order was placed
    total_amount DECIMAL(10, 2),                  -- Total value of the order
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE 
    -- ⛓️ Ensures orders are tied to valid customers; deletes orders if customer is removed
);

-- ✍️ Insert sample customer data – 20 loyal citizens of ecomDB
INSERT INTO Customers VALUES
(1, 'John', 'Doe', 'john.doe@gmail.com', '123 Maple St, NY', '1234567890'),
(2, 'Jane', 'Smith', 'jane.smith@yahoo.com', '456 Oak St, CA', '2345678901'),
(3, 'Alice', 'Brown', 'alice.brown@hotmail.com', '789 Pine St, TX', '3456789012'),
-- (…continues up to 20 customers for full marketplace diversity)
(20, 'Sam', 'Allen', 'sam.allen@gmail.com', '718 Poplar St, VA', '1213141516');

-- 🛒 Insert sample order data – each order linked to a customer
INSERT INTO Orders VALUES
(1, 1, '2024-01-15', 1250.00),
(2, 2, '2024-01-20', 85.00),
(3, 3, '2024-02-05', 60.00),
-- (…up to 20 orders showing the growing success of our store!)
(20, 20, '2024-03-25', 240.00);

-- 🏷️ Insert sample products – from tech gadgets to furniture dreams
INSERT INTO Products VALUES
(1, 'Laptop Pro 15"', 1200.00, 10, 'Electronics'),
(2, 'Wireless Mouse', 25.99, 100, 'Electronics'),
(3, 'Bluetooth Speaker', 45.50, 30, 'Electronics'),
(4, 'Yoga Mat', 20.00, 50, 'Fitness'),
-- (…a total of 20 products covering multiple life needs)
(20, 'Headphones', 50.00, 55, 'Electronics');



-- Retrieve all customer records
SELECT * FROM Customers;

-- Get customer details with a specific email
SELECT * FROM Customers WHERE email = 'john.doe@gmail.com';

-- Fetch product names and prices from the Products table
SELECT product_name, price FROM Products;

-- Get all electronic category products
SELECT * FROM Products WHERE category = 'Electronics';

-- Reduce stock by 5 units for the product with ID 1
UPDATE Products SET stock_quantity = stock_quantity - 5 WHERE product_id = 1;

-- View the updated product list after stock deduction
SELECT * from Products;

-- Disable safe updates mode (use with caution)
set sql_safe_updates = 0;

-- Delete the customer with customer_id = 3
DELETE FROM Customers 
WHERE customer_id = 3;

-- Join Customers and Orders to display customer names and their order details
SELECT c.first_name, c.last_name, o.order_id, o.order_date, o.total_amount 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id;

-- Calculate total sales per product (quantity × price), grouped by product
SELECT p.product_name, SUM(od.quantity * p.price) AS total_sales 
FROM Products p 
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_name;

-- Create OrderDetails table with foreign keys referencing Orders and Products
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert various order details (sample data)
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (1, 1, 2);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (1, 2, 1);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (2, 3, 3);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (2, 1, 1);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (3, 4, 2);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (3, 2, 4);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (4, 5, 1);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (5, 6, 5);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (6, 7, 2);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (6, 3, 3);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (7, 4, 1);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (7, 8, 2);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (8, 9, 4);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (9, 10, 1);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (10, 1, 2);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (11, 5, 2);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (12, 6, 3);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (13, 7, 1);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (14, 8, 2);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES (15, 9, 3);

-- Get the product(s) with the maximum price
SELECT * FROM Products 
WHERE price = (SELECT MAX(price) FROM Products);

-- Fetch customers who placed orders over ₹500 (premium customers maybe?)
SELECT DISTINCT c.first_name, c.last_name 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
WHERE o.total_amount > 500;

-- Count the number of orders placed by each customer
SELECT c.first_name, c.last_name, COUNT(o.order_id) AS number_of_orders 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id;

-- Find products with low stock (less than 30 units)
SELECT * FROM Products 
WHERE stock_quantity < 30;

-- Calculate the average value of all orders
SELECT AVG(total_amount) AS average_order_value 
FROM Orders;

-- Get product sales (quantity sold) from the last 1 month
SELECT p.product_name, SUM(od.quantity) AS quantity_sold 
FROM Products p 
JOIN OrderDetails od ON p.product_id = od.product_id 
JOIN Orders o ON od.order_id = o.order_id 
WHERE o.order_date BETWEEN CURDATE() - INTERVAL 1 MONTH AND CURDATE() 
GROUP BY p.product_name;

-- Update the order date for order with ID 1
UPDATE Orders SET order_date = '2025-04-10' WHERE order_id = 1;

-- Create a view to display order summary (joining multiple tables)
CREATE VIEW OrderDetailsView AS
SELECT o.order_id, c.first_name, c.last_name, p.product_name, od.quantity, (od.quantity * p.price) AS total_amount 
FROM Orders o 
JOIN Customers c ON o.customer_id = c.customer_id 
JOIN OrderDetails od ON o.order_id = od.order_id 
JOIN Products p ON od.product_id = p.product_id;


-- View all records from the OrderDetailsView (a joined view combining customers, orders, and products)
SELECT * FROM OrderDetailsView;

-- Get customers who haven't placed any orders
SELECT * FROM Customers 
WHERE customer_id NOT IN (SELECT customer_id FROM Orders);

-- Add a new customer (Riya Sharma) to the Customers table
INSERT INTO Customers (customer_id, first_name, last_name, email, address, phone)
VALUES (21, 'Riya', 'Sharma', 'riya.sharma@example.com', '20 Green Lane', '9123456789');

-- Get total sales grouped by product category
SELECT category, SUM(od.quantity * p.price) AS total_sales 
FROM Products p 
JOIN OrderDetails od ON p.product_id = od.product_id 
GROUP BY category;

-- Calculate average order value for each customer
SELECT c.first_name, c.last_name, AVG(o.total_amount) AS average_order_value 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id;

-- Get the highest order value across all orders
SELECT MAX(total_amount) AS max_order_value 
FROM Orders;

-- List all unique product categories
SELECT DISTINCT category 
FROM Products;

-- List all customers who have placed at least one order
SELECT DISTINCT c.first_name, c.last_name 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id;

-- Get customers who bought products in 'Electronics' or 'Furniture' categories
SELECT DISTINCT c.first_name, c.last_name 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
JOIN OrderDetails od ON o.order_id = od.order_id 
JOIN Products p ON od.product_id = p.product_id 
WHERE p.category IN ('Electronics', 'Furniture');

-- View products that are either out of stock or priced below 100
SELECT * FROM Products 
WHERE stock_quantity = 0 OR price < 100;

-- Get customers who placed high-value orders before 2025
SELECT DISTINCT c.first_name, c.last_name 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
WHERE o.order_date < '2025-01-01' AND o.total_amount > 200;

-- Find all customers with Gmail addresses
SELECT * FROM Customers 
WHERE email LIKE '%gmail.com';

-- Fetch products with 'Pro' in their names
SELECT * FROM Products 
WHERE product_name LIKE '%Pro%';

-- Get products priced between 50 and 200 (inclusive)
SELECT * FROM Products 
WHERE price BETWEEN 50 AND 200;

-- Retrieve all orders placed in the year 2024
SELECT * FROM Orders 
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Select products with specific prices (useful for targeted price filtering)
SELECT * FROM Products 
WHERE price IN (20, 50, 100, 150, 200);

-- Get customers who ordered specific products (product IDs 1, 2, 3)
SELECT DISTINCT c.first_name, c.last_name 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
JOIN OrderDetails od ON o.order_id = od.order_id 
WHERE od.product_id IN (1, 2, 3);

-- Full details of who ordered what, when, and how much
SELECT c.first_name, c.last_name, o.order_id, o.order_date, p.product_name, od.quantity 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
JOIN OrderDetails od ON o.order_id = od.order_id 
JOIN Products p ON od.product_id = p.product_id;

-- Get product purchases made by customer with ID 5
SELECT p.product_name, o.order_date, o.total_amount 
FROM Products p 
JOIN OrderDetails od ON p.product_id = od.product_id 
JOIN Orders o ON od.order_id = o.order_id 
WHERE o.customer_id = 5;

-- List products ordered more than once, along with their order count
SELECT p.product_name, COUNT(od.order_id) AS order_count 
FROM Products p 
JOIN OrderDetails od ON p.product_id = od.product_id 
GROUP BY p.product_name 
HAVING COUNT(od.order_id) > 1;

-- Customers whose total purchases exceed ₹500
SELECT c.first_name, c.last_name 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id 
HAVING SUM(o.total_amount) > 500;

-- Check if product with ID 1 exists in OrderDetails
SELECT 1 
FROM Products p 
WHERE p.product_id = 1 
AND EXISTS (SELECT 1 FROM OrderDetails od WHERE od.product_id = p.product_id);

-- Customers who have ordered product with ID 2
SELECT DISTINCT c.first_name, c.last_name 
FROM Customers c 
WHERE EXISTS ( 
    SELECT 1 
    FROM Orders o 
    JOIN OrderDetails od ON o.order_id = od.order_id 
    WHERE o.customer_id = c.customer_id AND od.product_id = 2
);
