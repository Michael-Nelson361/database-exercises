-- Create a file named join_exercises.sql to do your work in.
show databases;

-- Join Example Database
-- 1. Use the join_example_db. 
-- 	Select all the records from both the users and roles tables.
use join_example_db;
select database();
show tables;
select *
from roles;
select *
from users;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- 	Before you run each query, guess the expected number of results.
select *
from users
inner join roles
on users.role_id = roles.id
; -- Shows only 4 rows
select *
from users
left join roles
on users.role_id = roles.id
; -- Shows all users; null results for role_id, id, and name for jane and mike
select *
from users
right join roles
on users.role_id = roles.id
; -- Shows all roles; From users there is are null values for id, name, email, and role_id because there is no one with role_id 4

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- 	Use count and the appropriate join type to get a list of roles along with the number of users that have the role. 
-- 	Hint: You will also need to use group by in the query.
select roles.name, count(*)
from roles
inner join users
on roles.id = users.role_id
group by roles.name
;

-- Employees Database
-- 1. Use the employees database.
use employees;
-- 2. Using the example in the Associative Table Joins section as a guide, 
-- 		write a query that shows each department along with the name of the current manager for that department.
select
	dept_name as 'Department Name'
	,concat(first_name, ' ',last_name) as 'Department Manager'
from employees as e
inner join dept_manager as dm
	using(emp_no)
    -- on e.emp_no = dm.emp_no
inner join departments as d
	using(dept_no)
where to_date > curdate()
order by dept_name
;

-- 3. Find the name of all departments currently managed by women.
select 
	dept_name as 'Department Name'
	,concat(first_name, ' ',last_name) as 'Department Manager'
    ,gender as 'Gender'
from employees as e
inner join dept_manager as dm
	using(emp_no)
inner join departments as d
	using(dept_no)
where to_date > curdate()
	and gender = 'F'
order by dept_name
;

-- 4. Find the current titles of employees currently working in the Customer Service department.
select title as 'Title', count(*) as 'Count'
from titles as t
inner join dept_emp as de
	using(emp_no)
inner join departments as d
	using(dept_no)
where t.to_date > curdate()
	and de.to_date > curdate()
    and d.dept_name = 'Customer Service'
group by title
order by title
;

-- 5. Find the current salary of all current managers.
select 
	dept_name as 'Department Name'
    ,concat(first_name,' ',last_name) as 'Name'
    ,salary as 'Salary'
from salaries as s
inner join dept_manager as dm
	using(emp_no)
inner join employees as e
	using(emp_no)
inner join departments as d
	using(dept_no)
where s.to_date > curdate()
	and dm.to_date > curdate()
order by dept_name
;

-- 6. Find the number of current employees in each department.
select dept_no, dept_name, count(*) as num_employees
from employees as e
inner join dept_emp as de
	using(emp_no)
inner join departments as d
	using(dept_no)
where to_date > curdate()
group by dept_no
order by dept_no
;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
select dept_name, avg(salary) as average_salary
from departments as d
inner join dept_emp as de
	using(dept_no)
inner join salaries as s
	using(emp_no)
where s.to_date > curdate()
	and de.to_date > curdate()
group by dept_name
order by average_salary desc
limit 1
;

-- 8. Who is the highest paid employee in the Marketing department?
select first_name,last_name
from employees as e
inner join salaries as s
	using(emp_no)
inner join dept_emp as de
	using(emp_no)
inner join departments as d
	using(dept_no)
where dept_name = 'Marketing'
	and s.to_date > curdate()
order by salary desc
limit 1
;

-- 9. Which current department manager has the highest salary?
select first_name, last_name, salary, dept_name
from employees as e
inner join dept_manager as dm
	using(emp_no)
inner join salaries as s
	using(emp_no)
inner join departments as d
	using(dept_no)
where dm.to_date > curdate()
	and s.to_date > curdate()
order by salary desc
limit 1
;

-- 10. Determine the average salary for each department. Use all salary information and round your results.
select dept_name, round(avg(salary)) as average_salary
from salaries
inner join employees
	using(emp_no)
inner join dept_emp
	using(emp_no)
inner join departments
	using(dept_no)
group by dept_name
order by average_salary desc
;

-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.
select 
	concat(e.first_name,' ',e.last_name) as 'Employee Name'
    ,dept_name as 'Department Name'
    ,concat(e2.first_name,' ',e2.last_name) as 'Manager Name'
from employees as e
inner join dept_emp as de
	using(emp_no)
inner join departments as d
	using(dept_no)
inner join dept_manager as dm
	using(dept_no)
inner join employees as e2
	on dm.emp_no = e2.emp_no
where de.to_date > curdate()
	and dm.to_date > curdate()
order by dept_name
limit 50
;
