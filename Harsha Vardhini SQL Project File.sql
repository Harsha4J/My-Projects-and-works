CREATE DATABASE retail_project;
USE retail_project;
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
city VARCHAR(50),
state VARCHAR(50)
);

CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2)
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
order_item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
sales_amount DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO customers VALUES
(1,'Arun','Chennai','Tamil Nadu'),
(2,'Priya','Coimbatore','Tamil Nadu'),
(3,'Rahul','Bangalore','Karnataka'),
(4,'Sneha','Hyderabad','Telangana'),
(5,'Vikram','Chennai','Tamil Nadu');
INSERT INTO products VALUES
(101,'Laptop','Electronics',50000),
(102,'Mobile','Electronics',20000),
(103,'Shoes','Fashion',3000),
(104,'Watch','Accessories',2500),
(105,'Headphones','Electronics',1500);
INSERT INTO orders VALUES
(1001,1,'2024-01-10'),
(1002,2,'2024-01-15'),
(1003,3,'2024-02-05'),
(1004,4,'2024-02-20'),
(1005,5,'2024-03-01');
INSERT INTO order_items VALUES
(1,1001,101,1,50000),
(2,1002,102,2,40000),
(3,1003,103,3,9000),
(4,1004,104,1,2500),
(5,1005,105,2,3000);
SELECT 
p.product_name,
p.category,
SUM(oi.sales_amount) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name, p.category;
SELECT 
c.customer_name,
SUM(oi.sales_amount) AS total_purchase
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_purchase DESC
LIMIT 5;
SELECT 
MONTH(o.order_date) AS month,
SUM(oi.sales_amount) AS monthly_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY MONTH(o.order_date);
SELECT AVG(order_total) AS average_order_value
FROM
(
SELECT order_id, SUM(sales_amount) AS order_total
FROM order_items
GROUP BY order_id
) AS order_summary;
