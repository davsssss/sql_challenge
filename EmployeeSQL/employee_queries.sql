-- List the employee number, last name, first name, sex, 
-- and salary of each employee
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary

FROM employees AS emp 
	JOIN salaries as sal 
	ON emp.emp_no = sal.emp_no;

-- List the first name, last name, and hire date for 
-- the employees who were hired in 1986
SELECT emp.first_name, emp.last_name, emp.hire_date

FROM employees AS emp
WHERE EXTRACT(YEAR FROM emp.hire_date) = 1986;

-- List the manager of each department along with their 
-- department number, department name, employee number, last name, and first name
SELECT dm.dept_no, d.dept_name, emp.emp_no, emp.last_name, emp.first_name

FROM dept_manager AS dm
	JOIN employees AS emp
	ON emp.emp_no = dm.emp_no
		JOIN departments AS d
		ON dm.dept_no = d.dept_no;

-- List the department number for each employee along with that employee’s 
-- employee number, last name, first name, and department name
SELECT d.dept_no, emp.emp_no, emp.last_name, emp.first_name, d.dept_name 

FROM departments AS d
	JOIN dept_emp AS de
	ON d.dept_no = de.dept_no 
		JOIN employees AS emp
		ON de.emp_no = emp.emp_no;
				
-- List first name, last name, and sex of each employee whose first name 
-- is Hercules and whose last name begins with the letter B
SELECT emp.first_name, emp.last_name, emp.sex

FROM employees AS emp
	WHERE first_name = 'Hercules' 	
	AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their 
-- employee number, last name, and first name
SELECT emp.emp_no, emp.last_name, emp.first_name
FROM employees AS emp
WHERE emp.emp_no IN
	(SELECT de.emp_no 
	 FROM dept_emp AS de
	 WHERE de.dept_no = 
		(SELECT d.dept_no
		 FROM departments AS d
		 WHERE d.dept_name = 'Sales'));

-- List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name
SELECT de.emp_no, emp.last_name, emp.first_name, d.dept_name 

FROM employees AS emp
	JOIN dept_emp AS de
	ON emp.emp_no = de.emp_no 
		JOIN departments AS d
		ON de.dept_no = d.dept_no 
			WHERE d.dept_name = 'Sales' 
			OR d.dept_name = 'Development';

-- List the frequency counts, in descending order, of all the 
-- employee last names (that is, how many employees share each last name)
SELECT emp.last_name, COUNT(emp.last_name) AS last_name_count
FROM employees AS emp
GROUP BY emp.last_name
ORDER BY last_name DESC;