-- Create a file named temporary_tables.sql to do your work for this exercise.
show databases;
use ursula_2325;

-- 1. Using the example from the lesson, create a temporary table called employees_with_departments 
-- 		that contains first_name, last_name, and dept_name for employees currently with that department. 
-- 		Be absolutely sure to create this table on your own database. 
-- 		If you see "Access denied for user ...", it means that the query 
-- 		was attempting to write a new table to a database that you can only read.
# Run a selection to test we gather relevant data
select first_name,last_name,dept_name
from employees.employees
join employees.dept_emp
	using(emp_no)
join employees.departments
	using(dept_no)
;

# Now enclose in a table creation
create temporary table employees_with_departments
	(
    select first_name,last_name,dept_name
	from employees.employees
	join employees.dept_emp
		using(emp_no)
	join employees.departments
		using(dept_no)
    )
;


# Test the creation
select * from employees_with_departments;

-- 	a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
describe employees_with_departments;

alter table employees_with_departments
add full_name varchar(30);

# Make sure that the column was made
select * from employees_with_departments;

-- 	b. Update the table so that the full_name column contains the correct data.
update employees_with_departments set full_name = concat(first_name,' ',last_name);

-- 	c. Remove the first_name and last_name columns from the table.
alter table employees_with_departments drop column first_name, drop column last_name;

-- 	d. What is another way you could have ended up with this same table?

# I could have done the concatenation in the selection process when I selected
# 	from the employees database.


-- 2. Create a temporary table based on the payment table from the sakila database.
-- 		Write the SQL necessary to transform the amount column such that it is stored as an integer
--    	 representing the number of cents of the payment. 
--    	 For example, 1.99 should become 199.
# Let's see what we're working with.
select *
from sakila.payment
;
create temporary table sakila_payments
	(
    select *
	from sakila.payment
    )
;
# Verify creation
select *
from sakila_payments
;

# Now let's update the values
describe sakila_payments;

# There's probably a simpler way of doing this but let's go!
alter table sakila_payments modify amount decimal(10,2); -- First change the type to allow modification
update sakila_payments set amount = amount * 100; -- Now turn it all into cents
alter table sakila_payments modify amount int; -- Finally make it an integer value


-- 3. Go back to the employees database. 
-- 		Find out how the current average pay in each department compares to the overall current pay for everyone at the company. 
-- 		For this comparison, you will calculate the z-score for each salary. 
-- 		In terms of salary, what is the best department right now to work for? The worst?
# Let's see what we're working with
select 
	dept_no
    ,e_s.emp_no
    ,salary
    ,dept_name
from employees.salaries e_s
join employees.dept_emp as e_de
	on e_s.emp_no = e_de.emp_no
    and e_de.to_date > now()
    and e_s.to_date > now()
join employees.departments as e_d
	using(dept_no)
;

# Now let's import this data to work with it a little better
create temporary table salary_data 
	(
	select 
		dept_no
		,e_s.emp_no
		,salary
		,dept_name
        ,avg_sal
	from employees.salaries e_s
	join employees.dept_emp as e_de
		on e_s.emp_no = e_de.emp_no
		and e_de.to_date > now()
		and e_s.to_date > now()
	join employees.departments as e_d
		using(dept_no)
	
    # Join the average salaries onto departments
    # so that we have it all condensed and don't have to bother with adding a column with this
	join 
    (
    select 
		d.dept_name,
		AVG(s.salary) avg_sal
	from employees.salaries s
	join employees.dept_emp de
		on s.emp_no=de.emp_no
        and de.to_date > now()
        and s.to_date > now()
	join employees.departments d
		on d.dept_no=de.dept_no
	group by d.dept_name
    ) as sal_avg_dept
		using(dept_name)
	)
; -- select * from salary_data; -- for verifying the script

# Add the company average to the table
alter table salary_data add co_avg float;
update salary_data set co_avg = 
	(
	select avg(salary) from employees.salaries where to_date > now()
	);

# Now add the standard deviation to the table
alter table salary_data add std_dev float;
update salary_data set std_dev = 
	(
	select std(salary) from employees.salaries where to_date > now()
	);

# Add the zscore
alter table salary_data add zscore float;
update salary_data set zscore = (avg_sal - co_avg) / std_dev;



# Now limit selection parameters
# This will also showcase the comparison between the employee's salary and the department average
select 
	concat(first_name,' ',last_name) as 'name'
    ,salary
    ,round(avg_sal,2) as dept_avg
    ,dept_name
from salary_data
join employees.employees
	using(emp_no) -- Add the employees table just to replace the number with a name
;

# So based on the following selections:
# Sales pays the best, while Human Resources pays the worst.

select zscore,dept_name
from salary_data
group by dept_name,zscore
order by zscore desc
;

-- BONUS Determine the overall historic average department average salary, the historic overall average, 
-- 	and the historic z-scores for salary. 
--     Do the z-scores for current department average salaries (from exercise 3) tell a similar 
--     or a different story than the historic department salary z-scores?

# Statements to drop a table if necessary
drop table employees_with_departments;
drop table sakila_payments;
drop table salary_data;
