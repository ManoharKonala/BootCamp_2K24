-- Create database
create database zomato;

use zomato;

-- Products - pid, pname, price, stock, location (Mumbai or Delhi)
create table products
(
    pid int(3) primary key,
    pname varchar(50) not null,
    price int(10) not null,
    stock int(5),
    location varchar(30) check(location in ('Mumbai','Delhi'))
);

-- Customer - cid, cname, age, addr
create table customer
(
    cid int(3) primary key,
    cname varchar(30) not null,
    age int(3),
    addr varchar(50)
);

-- Orders - oid, cid, pid, amt
create table orders
(
    oid int(3) primary key,
    cid int(3),
    pid int(3),
    amt int(10) not null,
    foreign key(cid) references customer(cid),
    foreign key(pid) references products(pid)
);

-- Payment - pay_id, oid, amount, mode (upi, credit, debit), status
create table payment
(
    pay_id int(3) primary key,
    oid int(3),
    amount int(10) not null,
    mode varchar(30) check(mode in('upi','credit','debit')),
    status varchar(30),
    foreign key(oid) references orders(oid)
);

-- Inserting values into products table
insert into products values(1,'HP Laptop',50000,15,'Mumbai');
insert into products values(2,'Realme Mobile',20000,30,'Delhi');
insert into products values(3,'Boat earpods',3000,50,'Delhi');
insert into products values(4,'Levono Laptop',40000,15,'Mumbai');
insert into products values(5,'Charger',1000,0,'Mumbai');
insert into products values(6, 'Mac Book', 78000, 6, 'Delhi');
insert into products values(7, 'JBL speaker', 6000, 2, 'Delhi');

-- Inserting values into customer table
insert into customer values(101,'Ravi',30,'Mumbai');
insert into customer values(102,'Rahul',25,'Delhi');
insert into customer values(103,'Simran',32,'Mumbai');
insert into customer values(104,'Purvesh',28,'Delhi');
insert into customer values(105,'Sanjana',22,'Mumbai');

-- Inserting values into orders table
insert into orders values(10001,102,3,2700);
insert into orders values(10002,104,2,18000);
insert into orders values(10003,105,5,900);
insert into orders values(10004,101,1,46000);

-- Inserting values into payments table
insert into payment values(1,10001,2700,'upi','completed');
insert into payment values(2,10002,18000,'credit','completed');
insert into payment values(3,10003,900,'debit','in process');

-- TCL (Transaction control language) Commands
/*
TCL commands are used to manage transactions, maintain ACID properties, and control the flow of data modifications.
TCL commands ensure the consistency and durability of data in a database.
For example, if an operation fails during a transaction, the transaction is rolled back.
When a transaction is committed, its changes are permanent, even if the system fails or restarts.
TCL commands also ensure that all operations within a transaction are executed as a single unit.
*/

-- commit
/*
Commit: Saves a transaction to the database
*/
commit;

-- rollback
/*
Rollback: Undoes a transaction or change that hasn't been saved to the database
*/
rollback;

-- savepoint
/*
Savepoint: Temporarily saves a transaction for later rollback 
*/
savepoint a;
-- here it will store that as a
-- after we can call that by rollback to a
rollback to a;

-- any operation performed on table using dml
-- insert,delete,update every command is transaction 

/*
In mysql it is having auto commit so is doesnot make anysense transaction commands in mysql
for this we have to use command start transaction
*/

-- Triggers 

-- Trigger is a statement that a system executes automatically when there is any modification to the database
-- Triggers are used to specify certain integrity constraints and referential constraints that cannot be specified using the constraint mechanism of SQL

-- Triggers are 6 types 
/*
1)after insert -- activated after data is inserted into the table.
2)after update -- activated after data in the table is modified. 
3)after delete -- activated after data is deleted/removed from the table. 
4)before insert -- activated before data is inserted into the table. 
5)before update -- activated before data in the table is modified.
6)before delete --  activated before data is deleted/removed from the table. 
*/

-- Delimiters are necessary when creating stored procedures or triggers
-- Delimiters are used in MySQL to avoid conflicts with semicolons within SQL statements

-- "SQL Trigger for Logging Product Insertions"
-- after insert
DELIMITER //
CREATE TRIGGER products_after_insert
AFTER INSERT ON products
FOR EACH ROW
BEGIN
  INSERT INTO product_log (pid, pname, price, stock, location, inserted_at)
  VALUES (NEW.pid, NEW.pname, NEW.price, NEW.stock, NEW.location, NOW());
END //
DELIMITER ;

-- create an SQL trigger to automatically update product stock levels after each new order is inserted into the 'orders' table?
DELIMITER //
CREATE TRIGGER orders_after_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  UPDATE products
  SET stock = stock - NEW.amt
  WHERE pid = NEW.pid;
END //
DELIMITER ;

-- after update 

-- SQL trigger to log changes made to product information whenever an update occurs in the 'products' table?
DELIMITER //
CREATE TRIGGER products_after_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
  IF OLD.pid <> NEW.pid OR OLD.pname <> NEW.pname OR OLD.price <> NEW.price OR OLD.stock <> NEW.stock OR OLD.location <> NEW.location THEN
    INSERT INTO product_log (pid, pname, price, stock, location, updated_at)
    VALUES (OLD.pid, OLD.pname, OLD.price, OLD.stock, OLD.location, NOW());
  END IF;
END //
DELIMITER ;

-- after delete 

-- SQL trigger to prevent the deletion of a product from the 'products' table if there are existing orders referencing that product in the 'orders' table?
DELIMITER //
CREATE TRIGGER products_after_delete
AFTER DELETE ON products
FOR EACH ROW
BEGIN
  -- Log information about deleted product (optional)
  -- INSERT INTO product_log (pid, pname, price, stock, location, deleted_at)
  -- VALUES (OLD.pid, OLD.pname, OLD.price, OLD.stock, OLD.location, NOW());

  -- Check if there are existing orders referencing the deleted product
  DECLARE has_orders INT DEFAULT 0;

  SELECT COUNT(*) INTO has_orders
  FROM orders
  WHERE pid = OLD.pid;

  IF has_orders > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete product with existing orders. Update or delete orders first.';
  END IF;
END //
DELIMITER ;

-- before insert

-- Trigger for Automatic Payment Status on Payment Insert
DELIMITER //

CREATE TRIGGER set_default_payment_status
BEFORE INSERT ON payment
FOR EACH ROW
BEGIN
  IF NEW.status IS NULL THEN
    SET NEW.status = 'Pending';
  END IF;
END //

DELIMITER ;

/*
While SQL Workbench and many database management tools don't natively support BEFORE UPDATE and BEFORE DELETE triggers
*/

-- Uses of triggers
/*
Enforcing Data Integrity and Business Rules:

Data Validation: Triggers can validate data before it's inserted or updated, ensuring it adheres to specific rules. 
For example, a trigger can prevent negative product stock values or enforce a minimum age requirement for customer entries.

Maintaining Referential Integrity: Triggers can automatically maintain relationships between tables. 
When a record is deleted from a parent table (e.g., customers), a trigger can cascade the deletion to related child records (e.g., orders) or prevent deletion if dependent records exist.

Enforcing Business Logic: Triggers can implement complex business rules that might not be easily achievable with standard SQL statements. 
For instance, a trigger could automatically calculate discounts based on order amount or apply loyalty point adjustments upon successful purchases.

Security: Triggers can enforce data access restrictions or security checks on specific events within the database.

Performance Impact: Triggers can introduce overhead to data manipulation operations. Analyze their impact on performance and optimize them if necessary.

Trigger Order: When using multiple triggers, their execution order can be important. Define the order in which triggers fire to ensure desired results.
*/

-- Advanced triggers 
-- Advanced triggers can be used to implement row-level security restrictions. For example, a trigger can filter data displayed to a user based on their role:
/*
DELIMITER //
CREATE TRIGGER filter_products_by_role
BEFORE SELECT ON products
FOR EACH ROW
BEGIN
  DECLARE user_role VARCHAR(50);

  -- Get user role from session variable or another source
  SET user_role = 'user';  -- Replace with logic to get actual role

  IF user_role = 'admin' THEN
    SET FOUND = 1;  -- Allow admin to see all products
  ELSEIF user_role = 'user' AND NEW.location = 'Mumbai' THEN
    SET FOUND = 1;  -- Allow users to see only Mumbai products
  ELSE
    SET FOUND = 0;  -- Block other roles from seeing data
  END IF;
END //
DELIMITER ;
*/

-- Set current transaction isolation level
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Example trigger for auditing
DELIMITER //
CREATE TRIGGER audit_product_updates
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
  INSERT INTO audit_log (table_name, operation, timestamp)
  VALUES ('products', 'UPDATE', NOW());
END //
DELIMITER ;

--Create a new view: If the view doesn't already exist, it defines a new virtual table based on a specified query.
--Replace an existing view: If a view with the same name already exists, it replaces its definition with the new query provided in the statement.

-- 1.example creates or replaces a view named active_customers_mumbai that shows customer ID, name, and address for customers older than 25 who live in addresses containing "Mumbai"

CREATE OR REPLACE VIEW active_customers_mumbai AS
SELECT c.cid, c.cname, c.addr
FROM customer c
WHERE c.age > 25 AND c.addr LIKE '%Mumbai%';

-- 2. View for Customers and their Orders

create view CustomerOrders as
select c.cid, c.cname, o.oid, o.amt, p.pname
from customer c
join orders o on c.cid = o.cid
join products p on o.pid = p.pid;
	
-- 3.View for Total Orders by Location

create view TotalOrdersByLocation as
select p.location, p.pname, count(o.oid) as total_orders
from products p
join orders o on p.pid = o.pid
group by p.location, p.pname;

-- 4.View for Payment Status

create view OrderPaymentStatus as
select o.oid, o.amt, p.mode, p.status
from orders o
join payment p on o.oid = p.oid;
	
-- drop veiw removes a view from the database.
DROP VIEW active_customers_mumbai;
-- Drop TotalOrdersByLocation View
drop view TotalOrdersByLocation;