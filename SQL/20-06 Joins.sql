CREATE DATABASE zomato;

-- Using the Zomato database
USE zomato;

-- Creating table for Restaurants
CREATE TABLE restaurants (
    rid INT PRIMARY KEY,
    rname VARCHAR(50) NOT NULL,
    location VARCHAR(30) CHECK(location IN ('Mumbai', 'Delhi')),
    rating DECIMAL(2, 1) CHECK(rating BETWEEN 1 AND 5)
);

-- Creating table for Customers
CREATE TABLE customers (
    cid INT PRIMARY KEY,
    cname VARCHAR(30) NOT NULL,
    age INT,
    address VARCHAR(50)
);

-- Creating table for Orders
CREATE TABLE orders (
    oid INT PRIMARY KEY,
    cid INT,
    rid INT,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cid) REFERENCES customers(cid),
    FOREIGN KEY (rid) REFERENCES restaurants(rid)
);

-- Creating table for Payments
CREATE TABLE payments (
    pay_id INT PRIMARY KEY,
    oid INT,
    amount DECIMAL(10, 2) NOT NULL,
    mode VARCHAR(30) CHECK(mode IN('UPI', 'Credit', 'Debit')),
    status VARCHAR(30),
    FOREIGN KEY (oid) REFERENCES orders(oid)
);

-- Creating table for Employees
CREATE TABLE employees (
    eid INT PRIMARY KEY,
    ename VARCHAR(40) NOT NULL,
    phone_no VARCHAR(10) NOT NULL,
    department VARCHAR(40) NOT NULL,
    manager_id INT
);


INSERT INTO restaurants VALUES (1, 'Pizza Hut', 'Mumbai', 4.5);
INSERT INTO restaurants VALUES (2, 'Burger King', 'Delhi', 4.2);
INSERT INTO restaurants VALUES (3, 'Domino\'s', 'Delhi', 3.8);
INSERT INTO restaurants VALUES (4, 'KFC', 'Mumbai', 4.0);
INSERT INTO restaurants VALUES (5, 'Subway', 'Mumbai', 3.5);

INSERT INTO customers VALUES (101, 'Ravi', 30, 'Address1');
INSERT INTO customers VALUES (102, 'Rahul', 25, 'Address2');
INSERT INTO customers VALUES (103, 'Simran', 32, 'Address3');
INSERT INTO customers VALUES (104, 'Purvesh', 28, 'Address4');
INSERT INTO customers VALUES (105, 'Sanjana', 22, 'Address5');

INSERT INTO orders VALUES (1001, 102, 3, 500.00);
INSERT INTO orders VALUES (1002, 104, 2, 1000.00);
INSERT INTO orders VALUES (1003, 105, 5, 300.00);
INSERT INTO orders VALUES (1004, 101, 1, 1200.00);

INSERT INTO payments VALUES (1, 1001, 500.00, 'UPI', 'Completed');
INSERT INTO payments VALUES (2, 1002, 1000.00, 'Credit', 'Completed');
INSERT INTO payments VALUES (3, 1003, 300.00, 'Debit', 'In Process');

INSERT INTO employees VALUES (401, 'Rohan', '364832549', 'Analysis', 404);
INSERT INTO employees VALUES (402, 'Rahul', '782654123', 'Delivery', 406);
INSERT INTO employees VALUES (403, 'Shyam', '856471235', 'Delivery', 402);
INSERT INTO employees VALUES (404, 'Neha', '724863287', 'Sales', 402);
INSERT INTO employees VALUES (405, 'Sanjana', '125478954', 'HR', 404);
INSERT INTO employees VALUES (406, 'Sanjay', '956478535', 'Tech', NULL);

SELECT * FROM restaurants;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM employees;

--  Inner Join: 
-- This join returns only the rows where there is a match between orders, customers, and restaurants.

-- Get the names of customers and restaurants they ordered from
SELECT customers.cid, cname, restaurants.rid, rname, orders.oid 
FROM orders
INNER JOIN restaurants ON orders.rid = restaurants.rid
INNER JOIN customers ON orders.cid = customers.cid;

--  Left Join: 
-- This join returns all rows from the restaurants table, and the matched rows from the orders table. If no match, NULL values are returned for orders.

-- Get all restaurants and their orders (if any)
SELECT restaurants.rid, rname, amount, orders.oid 
FROM restaurants
LEFT JOIN orders ON orders.rid = restaurants.rid;

--  Right Join: 
-- This join returns all rows from the orders table, and the matched rows from the payments table. If no match, NULL values are returned for payments.

-- Get all orders and their payment details (if any)
SELECT * FROM payments 
RIGHT JOIN orders ON orders.oid = payments.oid;

--  Full Join:  (MySQL doesn't support FULL OUTER JOIN directly)
-- This join combines the results of both LEFT and RIGHT joins to return all rows from both tables.

--Get all orders and restaurant details
SELECT orders.oid, restaurants.rid, rname, amount, rating 
FROM orders
LEFT JOIN restaurants ON orders.rid = restaurants.rid
UNION
SELECT orders.oid, restaurants.rid, rname, amount, rating 
FROM orders
RIGHT JOIN restaurants ON orders.rid = restaurants.rid;

--  Self Join: 
-- This join matches rows in the employees table with other rows in the same table to pair employees with their managers.

--Get employees and their managers
SELECT e1.ename AS Employee, e2.ename AS Manager 
FROM employees e1
INNER JOIN employees e2 ON e1.manager_id = e2.eid;

--  Cross Join: 
-- This join returns the Cartesian product of customers and orders tables, then filters where the amount is greater than 500.

--Get all customer and order combinations where the amount is greater than 500
SELECT customers.cid, cname, orders.oid, amount 
FROM customers
CROSS JOIN orders 
WHERE amount > 500;