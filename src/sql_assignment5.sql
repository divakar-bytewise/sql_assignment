--creating a sales_data table.
create table sales_data (product_id int, sale_date date,quantity_sold int);

--inserting value into sales_data table.
insert into sales_data values(1, '2022-01-01', 20),
   		(2, '2022-01-01', 15),
   		(1, '2022-01-02', 10),
    	(2, '2022-01-02', 25),
    	(1, '2022-01-03', 30),
    	(2, '2022-01-03', 18),
    	(1, '2022-01-04', 12),
    	(2, '2022-01-04', 22);

--assigning rank by partition based on product_id and find the latest product_id sold.
select *, rank() over(partition by product_id order by sale_date desc)
as sales_ranks from sales_data;

/*fetching the quantity_sold value from a previous row and compare the quantity_sold.*/
select product_id,sale_date,quantity_sold,
lag(quantity_sold) over (partition by product_id order by sale_date)
as prev_quantity,quantity_sold - lag(quantity_sold) over 
(partition by product_id order by sale_date) as diff_vs_prev
from sales_data;

--partition based on product_id and return the first and last values in ordered set.
select product_id,sale_date,quantity_sold,
first_value(quantity_sold) over (partition by product_id order by sale_date) 
as first_qty, last_value(quantity_sold) over (partition by product_id
order by sale_date rows between unbounded preceding and
unbounded following) as last_qty from sales_data;
