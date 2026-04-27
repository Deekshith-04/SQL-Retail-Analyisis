CREATE DATABASE retail_db;
USE retail_db;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
SHOW TABLES;
INSERT INTO Customers VALUES
(1, 'Ravi Kumar', 'Hyderabad', '2023-01-10'),
(2, 'Anjali Sharma', 'Delhi', '2023-02-15'),
(3, 'Rahul Verma', 'Mumbai', '2023-03-20');

INSERT INTO Products VALUES
(1, 'Laptop', 'Electronics', 50000),
(2, 'Phone', 'Electronics', 20000),
(3, 'Shoes', 'Fashion', 3000);

INSERT INTO Orders VALUES
(1, 1, '2023-04-01'),
(2, 2, '2023-04-03');

INSERT INTO Order_Items VALUES
(1, 1, 1, 1),
(2, 1, 3, 2),
(3, 2, 2, 1);

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Order_Items;

SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id;

SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

SELECT p.category, SUM(p.price * oi.quantity) AS revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.category;

SELECT c.name, COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name;