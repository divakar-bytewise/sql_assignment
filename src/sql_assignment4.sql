use sql_assignment1

--creating email_signup table.
create table email_signup (id int, email_id varchar(35), signup_date date);

--inserting values into email_signup table
insert into email_signup values (1, 'Rajesh@Gmail.com', '2022-02-01'),
(2, 'Rakesh_gmail@rediffmail.com', '2023-01-22'),
(3, 'Hitest@Gmail.com', '2020-09-08'),
(4, 'Salil@Gmmail.com', '2019-07-05'),
(5, 'Himanshu@Yahoo.com', '2023-05-09'),
(6, 'Hitesh@Twitter.com', '2015-01-01'),
(7, 'Rakesh@facebook.com', null);

/*query to find gmail accounts with latest and first signup date and 
difference between both the dates and also write the query to
replace null value with �1970-01-01�*/
select count(*) as count_gmail_acct,min(signup_date) as first_signup_date
,max(signup_date) as latest_signup_date,datediff(day,min(signup_date),
max(signup_date))as date_diff from email_signup where email_id like '%gmail.com';

select id,email_id,  isnull(signup_date, '1970-01-01') as
signup_date from email_signup ;