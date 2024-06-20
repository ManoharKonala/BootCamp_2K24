-- Anomalies in Database

--Update Anomaly: Occurs when updating data in one place requires updating multiple rows to maintain consistency. Significance: It leads to data inconsistency if not all rows are updated correctly.

--Deletion Anomaly: Occurs when deleting a row inadvertently removes additional, essential data. Significance: It causes unintentional loss of important data that might still be needed.

--Insertion Anomaly: Occurs when adding new data requires unnecessary data to be filled in. Significance: It prevents the addition of new records if mandatory data fields are missing, leading to incomplete data entry.

-- Update Anomaly
-- Imagine updating a restaurant rating from 4.5 to 4.7:
UPDATE restaurants 
SET rating = 4.7 
WHERE rid = 1;
-- Issue: If the rating is stored in multiple places (like in orders or reviews table), failing to update all instances leads to inconsistency.

--Deletion Anomaly
--Deleting a customer:

DELETE FROM customers 
WHERE cid = 101;
--Issue: If the customer placed orders, those orders will reference a non-existent customer, leading to inconsistency.

--Insertion Anomaly
--Inserting an order for a new customer not in the customers table:

INSERT INTO orders (oid, cid, rid, total_amt) 
VALUES (10005, 106, 3, 700);
--Issue: The insertion fails if CustomerID 106 doesn't exist in the customers table.

--Candidate Keys
--Candidate keys uniquely identify each record in a table. In the restaurants table, rid is a candidate key.

SELECT rid, rname, location, rating 
FROM restaurants;
Primary Key
--A primary key is a unique identifier for a record in a table. It cannot be null.

/*
Rules for Primary Key:

Uniqueness: Each value must be unique.
Null values: Cannot contain null values.
Only one primary key per table.
Creating a Primary Key
*/

CREATE TABLE products (
    pid INT(3) PRIMARY KEY,
    pname VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT(5),
    location VARCHAR(30) CHECK(location IN ('Mumbai', 'Delhi'))
);

--Adding Primary Key to Existing Table

ALTER TABLE products 
ADD PRIMARY KEY (pid);

--Deleting Primary Key

ALTER TABLE products 
DROP PRIMARY KEY;

--Foreign Key
--A foreign key connects the data in one table to another table, ensuring data integrity and establishing relationships.

--Creating a Foreign Key


CREATE TABLE orders (
    oid INT(3) PRIMARY KEY,
    cid INT(3),
    rid INT(3),
    total_amt DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cid) REFERENCES customers(cid),
    FOREIGN KEY (rid) REFERENCES restaurants(rid)
);

--Adding Foreign Key to Existing Table


ALTER TABLE orders 
ADD FOREIGN KEY (rid) REFERENCES restaurants(rid);

--Removing Foreign Key

ALTER TABLE orders 
DROP FOREIGN KEY fk_orders_rid;

--Normalization
--Normalization minimizes redundancy and improves data integrity.

--First Normal Form (1NF)
--1NF ensures single-valued attributes and no repeating groups.

--Example (Violating 1NF):


-- Order_ID  Customer_Name     Items         Price
-- 1001      John Smith        Shirt,HAT     $50

--Solution:


-- Order_ID  Customer_Name     Items    Price
-- 1001      John Smith        Shirt    $25
-- 1001      John Smith        Hat      $25


--Second Normal Form (2NF)
--2NF ensures no partial dependency of any column on the primary key.

--Example (Violating 2NF):

-- OrderID  CustomerID  ProductID  Amount  ProductColor
-- 10001    102         3          2700    Blue

--Solution:

-- Orders table:
-- OrderID  CustomerID  ProductID  Amount

-- Order_Items table:
-- OrderItemID  OrderID  ProductID  ProductColor

--Third Normal Form (3NF)
--3NF ensures no transitive dependency.

--Example (Violating 3NF):


-- OrderID  CustomerID  ProductID  Amount  CustomerCity
-- 10001    102         3          2700    Delhi

Solution:

-- Orders table:
-- OrderID  CustomerID  ProductID  Amount

-- Customer table:
-- CustomerID  CustomerName  CustomerCity


--Boyce-Codd Normal Form (BCNF)
--BCNF eliminates anomalies from non-trivial functional dependencies.

--Example:

-- Functional dependencies in orders table:
-- oid → {cid, pid, amt}
-- {cid, pid} → {oid, amt}

-- Decomposition:
-- Table 1: order_info(oid, amt)
-- Table 2: order_details(oid, cid, pid)





