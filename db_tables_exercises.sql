-- 1. Open MySQL Workbench and login to the database server
-- 2. Save your work in a file named db_tables_exercises.sql
-- 3. List all the databases
SHOW DATABASES;

-- 4. Write the SQL code necessary to use the albums_db database
USE albums_db;

-- 5. Show the currently selected database
SELECT database();

-- 6. List all tables in the database
SHOW TABLES;

-- 7. Write the SQL code to switch to the employees database
USE employees;

-- 8. Show the currently selected database
SELECT database();

-- 9. List all tables in the database
SHOW TABLES;

-- 10. Explore the employees table. What different data types are present in this table?
DESCRIBE employees;
-- Different data types present are int, date, varchar, enum
SHOW TABLES;

-- 11. Which table(s) do you think contain a numeric type column?
-- All of them (at least to hold a primary key)

-- 12. Which table(s) do you think contain a string type column?
-- All tables

-- 13. Which table(s) do you think contain a date type column?
-- Employees and titles

-- 14. What is the relationship between the employees and the departments tables?
DESCRIBE employees; 
DESCRIBE departments;
DESCRIBE dept_emp;
-- The employees table has the emp_no column, which is also in the dept_emp table.
-- The dept_emp table has the dept_no column, which is also in the departments table.

-- 15. Show the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
SHOW CREATE TABLE dept_manager;
