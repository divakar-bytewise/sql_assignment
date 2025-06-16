use sql_assignment1;

--creating the product_details table.
create table product_details(sell_date date, products varchar(20));

--inserting values into product_details table.
insert into product_details values ('2020-05-30', 'Headphones'),
('2020-06-01','Pencil'),
('2020-06-02','Mask'),
('2020-05-30','Basketball'),
('2020-06-01','Book'),
('2020-06-02', ' Mask '),
('2020-05-30','T-Shirt');

--found number of different products sold on each date & their names.
select sell_date, count(products) as num_sold,string_agg(products,',') 
as product_list  from product_details group by sell_date;