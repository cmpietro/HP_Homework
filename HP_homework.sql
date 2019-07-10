--Homework HP --
--DATA ENGINEERING -- 
--LESSON LEARNED:  1. KISS  2. PAY ATTENTION TO THE ORDER OF THE COLUMNS! 
-- CREATE tables to hold employee data
-- CREATE table department2
--DROP Table department2

CREATE Table department2
(
	dept_no  VARCHAR (10) NOT NULL,
	--dept_ID serial (Removed)
	dept_name  VARCHAR (50),
	--PRIMARY KEY (dept_ID)
	PRIMARY KEY (dept_no)
);

-- Review table structure
SELECT *
from department2;

--IMPORT Data into table

-- Review table data
SELECT *
from department2;

--Create table employees; drop in case of issues
--DROP Table employees; 
CREATE Table employees (
	--emp_ID serial,
	emp_no INT NOT NULL,
	birth_date DATE  NOT NULL,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	gender CHAR (1) NOT NULL,
	hire_date DATE NOT NULL,
	--PRIMARY KEY (emp_ID)
	PRIMARY KEY (emp_no)
);

-- View Table --
SELECT *
from employees;

--IMPORT Data into table

-- View Table data --
SELECT *
from employees;

-- Create table dept_emp 
--DROP table dept_emp;
CREATE Table dept_emp(
	--deptemp_ID serial,
	emp_no INT NOT NULL,
	dept_no VARCHAR (10) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	--PRIMARY KEY (deptemp_ID)
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES department2(dept_no)
);

--Check table output --
SELECT *
from dept_emp;

--IMPORT Data into table
--Check table data --
SELECT *
from dept_emp;


--Create dept_manager
--DROP Table dept_manager;
CREATE Table dept_manager(
	dept_no VARCHAR (10) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES department2(dept_no)
	
);

--Check table --
SELECT *
from dept_manager;

--IMPORT data into table
--Check table data --
SELECT *
from dept_manager;


-- CREATE table for salaries
--DROP Table salaries;
CREATE Table salaries
(	emp_no INT NOT NULL,
	salary INTEGER NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--Check table output
SELECT *
from salaries;

--IMPORT data into table
--Check table data
SELECT *
from salaries;

--CREATE table for titles
--DROP Table titles;
CREATE Table titles
(	emp_no INT NOT NULL,
	title VARCHAR (25) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


--Check tablel output
SELECT *
from titles;

--IMPORT data into table
--Check table data
SELECT *
from titles;

-- LIST the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT emp_no, first_name, last_name, gender
FROM employees
WHERE emp_no IN
(
	SELECT salary, emp_no
	FROM salaries
);

--ASK 1--
--List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
JOIN salaries 
ON employees.emp_no = salaries.emp_no;

--ASK 2--
--List employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

--ASK 3--
--List the manager of each department with the following information: department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.
SELECT department2.dept_no, department2.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
FROM department2
JOIN dept_manager
ON department2.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

--ASK 4--
--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, department2.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN department2
ON dept_emp.dept_no = department2.dept_no;

--ASK 5--
--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE last_name like 'B%'
AND first_name = 'Hercules'
ORDER BY last_name;

--ASK 6--
--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, department2.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN department2
ON dept_emp.dept_no = department2.dept_no
WHERE department2.dept_name = 'Sales';

--ASK 7--
--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, department2.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN department2
ON dept_emp.dept_no = department2.dept_no
WHERE department2.dept_name = 'Sales' 
OR department2.dept_name = 'Development';

--ASK 8--
--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;


