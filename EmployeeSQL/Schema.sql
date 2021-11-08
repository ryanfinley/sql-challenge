--Create tables in the following order:
--Titles
--Employees
--Departments
--Department Manager
--Department Employees
--Salaries

--Create titles table
CREATE TABLE titles
(
	title_id VARCHAR PRIMARY KEY,
	title VARCHAR
);

--preview table
SELECT * FROM titles;

--create employees table
CREATE TABLE employees
(
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

--preview employees table
SELECT * FROM employees;

--create department table
CREATE TABLE departments
(
	dept_no VARCHAR PRIMARY KEY,
	dept_name VARCHAR
);

--preview department table
SELECT * FROM departments;

--create dept_manager table
CREATE TABLE dept_manager
(dept_no VARCHAR,
 emp_no INT,
 FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
 FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
 PRIMARY KEY (dept_no, emp_no)
);

--preview dept_manager table
SELECT * FROM dept_manager;

--CREATE DEPT_EMP TABLE
CREATE TABLE dept_emp
(emp_no INT,
 dept_no VARCHAR,
 FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
 FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
 PRIMARY KEY (emp_no, dept_no)
);

--preview dept_emp table
SELECT * FROM dept_emp;

--create salaries table
CREATE TABLE salaries
(
	emp_no INT PRIMARY KEY,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--preview salaries table
SELECT * FROM salaries;