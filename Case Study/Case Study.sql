-- DATABASE DESIGN:
CREATE DATABASE [Ecommerce Application];
USE [Ecommerce Application];

-- 1. CUSTOMERS TABLE:
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
name NVARCHAR(170),
email NVARCHAR(170) UNIQUE,
password NVARCHAR(170)
);

-- 2. PRODUCTS TABLE:
CREATE TABLE products (
product_id INT PRIMARY KEY,
name NVARCHAR(200),
price DECIMAL(10, 2),
description TEXT,
stockQuantity INT
);

-- 3. CART TABLE:
CREATE TABLE cart (
cart_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
quantity INT,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 4. ORDERS TABLE:
CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
total_price DECIMAL(10, 2),
shipping_address NVARCHAR(255),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. ORDER_ITEMS TABLE:
CREATE TABLE order_items (
order_item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);
