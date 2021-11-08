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

SELECT * FROM dept_emp;

CREATE TABLE salaries
(
	emp_no INT PRIMARY KEY,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM salaries;

-- 1) List the following details of each employee: employee number, last name, first name, sex, and salary.
--SELECT * FROM employees;
--SELECT * FROM salaries;
SELECT employees.emp_no, last_name, first_name, sex, salary
FROM employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no;

-- 2) List first name, last name, and hire date for employees who were hired in 1986.
--SELECT * FROM employees;
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3) List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM departments;
SELECT departments.dept_no, 
departments.dept_name, 
employees.emp_no AS "Manager Employee Number", 
last_name, 
first_name
FROM employees
INNER JOIN dept_manager 
ON dept_manager.emp_no = employees.emp_no
INNER JOIN departments
ON departments.dept_no = dept_manager.dept_no
WHERE emp_title_id = 'm0001';

-- 4) List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM departments;
SELECT employees.emp_no, last_name, first_name, dept_name AS "Department"
FROM employees
INNER JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no;

-- 5) List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
--SELECT * FROM employees;
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- 6) List all employees in the Sales department, including their employee number, last name, first name, and department name.
--SELECT * FROM employees;
--SELECT * FROM departments;
--SELECT * FROM dept_emp;
SELECT employees.emp_no, last_name, first_name, dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name IN ('Sales');

-- 7) List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
--SELECT * FROM employees;
--SELECT * FROM departments;
--SELECT * FROM dept_emp;
SELECT employees.emp_no, first_name, last_name, dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_no IN ('d007','d005');

-- 8) In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
--SELECT * FROM employees;
SELECT last_name, COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Count" DESC;
