CREATE database fintech_db;
use fintech_db;
create table users (
user_id INT,
name varchar(50),
email varchar(50)
);
-- know about table schema ---
desc users;

-- CREATE TABLE PROD GRADE--
create table user_prod(
user_id int auto_increment,
name varchar(100) not null,
email varchar(100) unique,
created_at  timestamp default current_timestamp,
primary key(user_id)
);

desc user_prod;
insert into user_prod(name,email) values ("preetam","preetam@gmail.com");
select * from user_prod;
insert into user_prod(user_id,name,email) values (10,"Ankit","Ankit@gmail.com");
select * from user_prod;
insert into user_prod(name,email) values ("amit","amit@gmail.com");
select * from user_prod;

create table orders(
order_id int auto_increment primary key ,
user_id int,
amount decimal(10,2),
order_date timestamp default current_timestamp,
foreign key(user_id) references user_prod(user_id)
);

desc orders;
insert into orders (user_id, amount) values (1,220.50), (10, 490.49);
select * from orders;

-- ALTER COMMAND ----
alter table users
add column phone_no varchar(10);

desc users;
insert into users(user_id,name,email)  values(101,"aman", "aman@gmail.com");
select * from users;
insert into users(user_id,name,email,phone_no)  values(101,"aman", "aman@gmail.com","9987659812");

alter table user_prod
add column phone_num varchar(10) not null ;
desc user_prod;
insert into user_prod(name,email,phone_num) values ("rahul" ,"rahul@gmail.com","9918087654");
select * from user_prod;

-- RANAME TABLE ---
alter table user_prod
rename column phone_num to phone;

alter table user_prod
modify column phone varchar(15) not null;
desc user_prod;


-- DROP COLUMN ---
alter table user_prod
drop column phone;

-- RENAME TABLE--
rename table orders to  orders_prod;
show tables;
desc orders_prod;

-- TRUNCATE --
select * from users;
truncate table users;

-- DROP  --
drop table users;
desc users;

-- DML COMMAND --

use fintech_db;
create table students(
id int ,
name varchar(50),
marks int,
course varchar(50)
);
INSERT INTO students() values (); -- can add null value--
INSERT INTO students (id, name, marks, course) VALUES
(1, 'Amit Sharma', 85, 'Computer Science'),
(2, 'Priya Singh', 92, 'Information Technology'),
(3, 'Rahul Verma', 76, 'Mechanical Engineering'),
(4, 'Sneha Gupta', 88, 'Electronics'),
(5, 'Vikram Patel', 69, 'Civil Engineering'),
(6, 'Neha Kapoor', 95, 'Computer Science'),
(7, 'Arjun Mehta', 81, 'Electrical Engineering'),
(8, 'Kavya Nair', 74, 'Information Technology'),
(9, 'Rohan Das', 90, 'Computer Science'),
(10, 'Ananya Roy', 87, 'Electronics');

select * from students;
-- CLONE TABLE -- 
create table students_copy(id int, name varchar(50) , marks int , course varchar(50));
INSERT INTO students_copy(id,name,marks,course) select id, name, marks, course from students;
select * from students_copy;

create table students_copy1 (name varchar(50),marks int);
INSERT INTO students_copy1(name , marks) select name , marks from students;
select * from students_copy1;

create table students_copy2 (name varchar(50),marks int ,email varchar(50));
insert into  students_copy2 (name , marks, email)  select name, marks , null from students;
select * from students_copy2;

create database euron_db;
use euron_db;
create table customers(
id int primary key,
first_name varchar(50),
country varchar(50),
score int
);
create table orders(
order_id int primary key,
order_date date,
sales int,
customer_id int 
);
show tables;
INSERT INTO customers (id, first_name, country, score)
VALUES
(1, 'John', 'USA', 85),
(2, 'Aarav', 'India', 92),
(3, 'Emma', 'UK', 78),
(4, 'Sophia', 'Canada', 88),
(5, 'Liam', 'Australia', 95),
(6, 'Liam1', 'Australia', 95);
truncate table customers;
INSERT INTO orders (order_id, order_date, sales, customer_id)
VALUES
(101, '2025-01-10', 500, 1),
(102, '2025-01-15', 750, 2),
(103, '2025-02-05', 300, 3),
(104, '2025-02-20', 1200, 4),
(105, '2025-03-01', 950, 5),
(107, '2025-03-11', 879, 7),
(108, '2025-03-13', 980, 8);
truncate table orders;
-- no joins--
select * from customers;
select * from orders;
alter table orders 
add column id int;
-- inner join --

select customers.id,customers.first_name , orders.order_id, orders.sales from customers
join orders 
on customers.id = orders.customer_id;

select c.id,c.first_name , o.order_id, o.sales from customers as c
join orders  as o
on c.id = o.customer_id;

-- LEFT JOIN--
select c.id,c.first_name , o.order_id, o.sales from  customers  as c
left join orders as o
on c.id = o.customer_id;

-- right join --
select c.id ,c.first_name,o.sales,o.order_id 
from customers as c 
right join orders as o
on c.id =  o.customer_id;

-- FULL JOIN -- not supported in my sql 

-- ADVANCE JOINS--

select c.id ,c.first_name,o.sales,o.order_id  
from orders as o
left join customers as c 
on c.id =  o.customer_id
where c.id is null; 
 
select c.id ,c.first_name,o.sales,o.order_id  
from customers as c
left join  orders as o
on c.id =  o.customer_id
where  o.customer_id is null;

-- FULL ANTI JOIN --

select c.id ,c.first_name,o.sales,o.order_id  
from customers as c
left join  orders as o
on c.id =  o.customer_id
where  o.customer_id is null or c.id is null;

-- CROSS JOIN--
select * from customers cross join orders;

select count(*)  from customers cross join orders;

-- multiple table joins --

create database salesdb;
use salesdb;

create table customer(
cust_id int primary key auto_increment,
cust_name varchar(50)not null,
email varchar(50)
);

create table products(
prod_id int primary key auto_increment,
prod_name varchar(50)not null,
price decimal(10,2) NOT NULL
);

create table employees(
emp_id int primary key auto_increment,
emp_name varchar(50)not null,
department varchar(100)
);

create table orders2(
order_id int primary key auto_increment,
cust_id int,
prod_id int,
employee_id int,
quantity int,
sales_amt decimal(10,2),
order_date date,
foreign key (cust_id) references customer(cust_id),
foreign key (prod_id) references products(prod_id),
foreign key (employee_id) references employees(emp_id)
);
 
 INSERT INTO customer (cust_name, email) VALUES
('Alice Johnson', 'alice.johnson@example.com'),
('Bob Smith', 'bob.smith@example.com'),
('Charlie Brown', 'charlie.brown@example.com'),
('David Wilson', 'david.wilson@example.com'),
('Emma Davis', 'emma.davis@example.com');

INSERT INTO products (prod_name, price) VALUES
('Laptop', 65000.00),
('Smartphone', 25000.00),
('Headphones', 1999.99),
('Keyboard', 1499.50),
('Mouse', 799.00);

INSERT INTO employees (emp_name, department) VALUES
('Rahul Sharma', 'Human Resources'),
('Priya Verma', 'Finance'),
('Amit Kumar', 'Information Technology'),
('Sneha Patel', 'Marketing'),
('Vikram Singh', 'Sales');

INSERT INTO orders2 (cust_id, prod_id, employee_id, quantity, sales_amt, order_date) VALUES
(1, 2, 3, 2, 50000.00, '2026-01-10'),
(2, 1, 1, 1, 65000.00, '2026-01-12'),
(3, 5, 4, 3, 2397.00, '2026-01-15'),
(4, 3, 2, 2, 3999.98, '2026-01-18'),
(5, 4, 5, 1, 1499.50, '2026-01-20');

-- Display all orders with customer names.--
SELECT * FROM customer;
SELECT * FROM orders2;
SELECT 
    o.order_id,
    c.cust_name,
    o.order_date
FROM orders2 AS o
INNER JOIN customer AS c
ON o.cust_id = c.cust_id;

-- Display order details with product names.--

-- Show customer name, product name and sales amount.--

select 
	c.cust_name,
    p.prod_name,
    o.sales_amt
    from 
    orders2 AS o
    inner join 
    products AS p 
    on o.prod_id = p.prod_id
    inner join 
    customer as c on
    o.cust_id = c.cust_id;
    
-- Display employee name who handled each order.--

select 
	e.emp_name,
    o.order_id,
    o.order_date
    from orders2 as o
    inner join employees as e
    on e.emp_id = o.employee_id;
    
-- Show complete order details including:
-- Order ID
-- customer name
-- Product Name
-- Employee Name
-- quantity
-- Sales Amount
-- Order Date--

select 
	o.order_id,
    c.cust_name,
    p.prod_name,
    e.emp_name,
    o.quantity,
    o.sales_amt,
    o.order_date
	from orders2 as o
    inner join customer as c
    on o.cust_id = c.cust_id
    inner join products as p 
    on o.prod_id = p.prod_id
    inner join employees as e
    on e.emp_id = o.employee_id;
    
-- LEFT JOIN--
-- . Display all customers and their orders.
select 
	c.cust_name,
    o.order_id,
    o.order_date
    from customer as c
    left join orders2 as o
   on  o.cust_id = c.cust_id;
   
-- Display all products with order details.

select 
	o.order_id,
    o.order_date,
    p.prod_name
    from products as p
    left join orders2 as o
	on p.prod_id = o.prod_id;
    