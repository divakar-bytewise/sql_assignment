use sql_assignment1;

--creating dept_tbl table.
create table dept_tbl(id_deptname varchar(25),emp_name varchar(20),salary int);

--inserting values into dept_tbl.
insert into dept_tbl values ('1111-MATH', 'RAHUL', 10000),
('1111-MATH', 'RAKESH', 20000),
('2222-SCIENCE', 'AKASH', 10000),
('222-SCIENCE', 'ANDREW', 10000),
('22-CHEM', 'ANKIT', 25000),
('3333-CHEM', 'SONIKA', 12000),
('4444-BIO', 'HITESH', 2300),
('44-BIO', 'AKSHAY', 10000);

/*fetching the total salary from each department and 
by using deptname we have group it using 'right'.*/
select right(id_deptname, len(id_deptname) - charindex('-', id_deptname)) as dept_name
,sum(salary) as total_salary from dept_tbl group by 
right(id_deptname, len(id_deptname) - charindex('-', id_deptname));