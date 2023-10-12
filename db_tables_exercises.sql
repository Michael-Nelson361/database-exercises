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
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'employees'; -- Thank you Kelsey!

-- 11. Which table(s) do you think contain a numeric type column?
-- dept_emp, dept_manager, and employees

-- 12. Which table(s) do you think contain a string type column?
-- All tables except salaries

-- 13. Which table(s) do you think contain a date type column?
-- Employees and titles

-- 14. What is the relationship between the employees and the departments tables?
DESCRIBE employees; 
DESCRIBE departments;
DESCRIBE dept_emp;
-- The employees table has the emp_no column, which is also in the dept_emp table.
-- The dept_emp table has the dept_no column, which is also in the departments table.
-- In other words: the two tables are linked through a third table, but have no direct relationship.

-- 15. Show the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
SHOW CREATE TABLE dept_manager;

-- CREATE TABLE `dept_manager` (
--   `emp_no` int NOT NULL,
--   `dept_no` char(4) NOT NULL,
--   `from_date` date NOT NULL,
--   `to_date` date NOT NULL,
--   PRIMARY KEY (`emp_no`,`dept_no`),
--   KEY `dept_no` (`dept_no`),
--   CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
--   CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1

