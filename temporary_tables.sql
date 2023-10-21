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
	where to_date > now()
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

# Create the department averages
create temporary table dept_avg (
select 
	dept_no
    ,avg(salary) as dept_avg
from employees.salaries as e_s
join employees.dept_emp as e_de
	on e_s.emp_no = e_de.emp_no
    and e_s.to_date > now()
    and e_de.to_date > now()
group by dept_no
);

# Get the standard deviation values and the overall company average
create temporary table std_avg (
select 
	avg(salary) as co_avg
    ,std(salary) as co_std
from employees.salaries as e_s
where to_date > now()
);

# Combine the two above tables
create temporary table salary_data (
select *
from dept_avg
join std_avg
);


# Add the zscore
alter table salary_data add zscore float;
update salary_data set zscore = (dept_avg - co_avg) / co_std;

# Show the best to worst departments based on zscore
# Sales is in the lead, with HR being dead last!
# Side note: all the departments that deal with finances all have positive zscores.
select 
	dept_name
    ,zscore
from salary_data
join employees.departments
	using(dept_no)
order by zscore desc
;

# To show the comparison of employee salary against department average salary
select 
	concat(first_name, ' ', last_name) as full_name
    ,dept_name as department
    ,salary
    ,dept_avg
from salary_data as sd
join employees.dept_emp as e_de
	using(dept_no)
join employees.employees as e_e
	using(emp_no)
join employees.departments as e_d
	using(dept_no)
join employees.salaries as e_s
	using(emp_no)
where e_de.to_date > now()
	and e_s.to_date > now()
order by full_name
;

-- BONUS Determine the overall historic average department average salary, the historic overall average, 
-- 	and the historic z-scores for salary. 
--     Do the z-scores for current department average salaries (from exercise 3) tell a similar 
--     or a different story than the historic department salary z-scores?

# Let's take everything we did earlier and re-do it without adding date limitations
create temporary table hist_dept_avg (
select 
	dept_no
    ,avg(salary) as dept_avg
from employees.salaries as e_s
join employees.dept_emp as e_de
	on e_s.emp_no = e_de.emp_no
group by dept_no
);

create temporary table hist_std_avg (
select 
	avg(salary) as co_avg
    ,std(salary) as co_std
from employees.salaries as e_s
);

create temporary table hist_salary_data (
select *
from hist_dept_avg
join hist_std_avg
);

alter table hist_salary_data add zscore float;
update hist_salary_data set zscore = (dept_avg - co_avg) / co_std;

# Let's see the results and it looks like the historical data shows the same trend.
# Sales is on top, human resources on bottom.
select 
	dept_name
    ,zscore
from hist_salary_data
join employees.departments
	using(dept_no)
order by zscore desc
;


# Statements to drop a table if necessary
drop table employees_with_departments;
drop table sakila_payments;
drop table dept_avg;
drop table std_avg;
drop table salary_data;
drop table hist_dept_avg;
drop table hist_std_avg;
drop table hist_salary_data;
