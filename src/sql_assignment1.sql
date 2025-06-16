--database for the assignment1.
create database sql_assignment1; 

--making use of assignment1.
use sql_assignment1;

--creating gold_members_user table.
create table gold_members_user(userid int primary key,username varchar(30) not null,
signup_date date);

--creating users table.
create table users(u_id int primary key,u_name varchar(30) not null,sign_date date);

--creating products table.
create table products(product_id int primary key,product_name varchar(30),
price int);

--creating sales table.
create table sales(userid int,username varchar(30) not null,
created_date date,product_id int,foreign key (product_id) references products(product_id));

--inserting values into gold_members_user table.
insert into gold_members_user values (1,'John','09-22-2017'), (2,'David','04-21-2017'),(3,'Vijay','04-28-2017');

--inserting values into users table.
insert into users values (1,'John simeon','09-02-2014'), (2,'David','01-15-2015'),(3,'Vijay','04-28-2017'),
(4,'Adam','04-11-2014');

--inserting values into sales table.
insert into sales values
(1,'John simeon','04-19-2017',2), (2,'David','12-18-2019',1), (3,'Vijay','07-20-2020',3), 
(1,'John simeon','10-23-2019',2), (1,'John simeon','03-19-2018',3), (2,'David','12-20-2016',2), 
(1,'John simeon','11-09-2016',1), (1,'John simeon','05-20-2016',3), (3,'Vijay','09-24-2017',1), 
(1,'John simeon','03-11-2017',2), (1,'John simeon','03-11-2016',1), (2,'David','11-10-2016',1), 
(2,'David','12-07-2017',2);

--inserting values into products table.
insert into products values 
(1,'Mobile',980), (2,'Ipad',870), (3,'Laptop',330);

--all the tables in the same database
select * from sys.tables;

--
select * from gold_members_user;
select * from users;
select * from sales;
select * from products;

/*to count the total number of records we make use of 'count', and union 
all gives all the duplicates from all the table the alias from one line
of query is inherited b other queries.*/
select 'gold_members_user' as table_name, count(*) as total_records 
from gold_membership_users union all
select 'users', count(*) from users union all
select 'sales', count(*) from sales union all
select 'products', count(*) from products;

--the total amount each customer spent on ecommerce company.
select s.username,sum(p.price_value) as total_ammount_spent from sales s
inner join products p  on s.product_id=p.product_id group by s.username;

--distinct dates of each customer visited the website.
select distinct username,created_date as visit_date from sales order by created_date;

--the first product purchased by each customer using 3 tables(users, sales, product).
select u.u_name,s.created_date,p.product_name from(select *, row_number() 
over(partition by userid order by created_date ) as row_num from sales)s 
inner join products p on s.product_id=p.product_id
inner join users u on s.userid=u.u_id where s.row_num=1;

--the most purchased item of each customer and how many times the customer has purchased it.
select s.username,count(*) as count_item,p.product_name from sales s
inner join products p on s.product_id=p.product_id
group by s.username,p.product_name order by max(p.product_name), count_item desc;

--the customer who is not the gold_member_user.
select u.u_id,u.u_name from users u where not exists 
(select * from gold_membership_users gm where u.u_id=gm.userid); 

--the amount spent by each customer when he was the gold_member user.
select gm.userid,gm.username,sum(p.price_value) as total_amount_spent from gold_membership_users gm
inner join sales s on gm.userid=s.userid 
inner join products p on s.product_id=p.product_id group by gm.userid, gm.username ;

--the Customers names whose name starts with A.
select * from users where u_name like 'A%';

---the distinct customer id of each customer
select distinct u_id,u_name from users ;

--the column name from product table as price_value from price
exec sp_rename 'products.price' , 'price_value' , 'column'  ;
select * from products;

--the column value product_name – Ipad to Iphone from product table
update products set product_name='Iphone' where product_name='Ipad';

--the table name of gold_member_users to gold_membership_users.
exec sp_rename 'gold_members_user', 'gold_membership_users';
select * from gold_membership_users;

--new column  as status in the table gold_membership_users.
alter table gold_membership_users add status varchar(5); 

/*the status values should be 2 Yes and No if the user is
gold member, then status should be Yes else No.*/
update gold_membership_users set status=
case
when userid in (select userid from gold_membership_users) then 'yes'
else 'no'
end;

/*Delete the users_ids 1,2 from users table and
roll back the changes once both the rows are deleted 
one by one mention the result when performed roll back*/
begin transaction
delete from gold_membership_users where userid=1;
select * from gold_membership_users;
delete from gold_membership_users where userid=2;
select * from gold_membership_users;
rollback;
select * from gold_membership_users;

--Insert one more record as same (3,'Laptop',330) as product table
insert into products values (4,'Laptop',330);
insert into products values (5,'Laptop',330);

--query to find the duplicates in product table.
select product_name,count(product_name) as total_count from products 
group by product_name having count(*)>1;

