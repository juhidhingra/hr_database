#hr_database_joins 


#display the first and last name, department, city, and state province for each employee

SELECT employees.first_name, employees.last_name, departments.department_name, locations.city, locations.state_province
FROM employees
JOIN departments
ON employees.department_id = departments.department_id
JOIN locations
ON departments.location_id = locations.location_id;


#display the first name, last name, salary, and job grade for all employees

SELECT employees.first_name, employees.last_name, employees.salary, job_grades.grade_level
FROM employees
JOIN job_grades
ON employees.salary BETWEEN job_grades.lowest_sal AND highest_sal;


#display the first name, last name, department number and department name, for all employees for departments 80 or 40

SELECT employees.first_name, employees.last_name, departments.department_id, departments.department_name
FROM employees
JOIN departments
ON employees.department_id = departments.
WHERE employees.department_id IN(40, 80);


#display those employees who contain a letter z to their first name and also display their last name, department, city, and state province

SELECT employees.first_name, employees.last_name, departments.department_name, locations.city, locations.state_province
FROM employees
JOIN departments
ON employees.department_id = departments.department_id
JOIN locations
ON departments.location_id = locations.location_id
WHERE employees.first_name LIKE '%z%'; 


#display all departments including those where does not have any employee

SELECT employees.first_name, employees.last_name, departments.department_id, departments.department_name, departments.location_id
FROM employees
RIGHT OUTER JOIN departments
ON departments.department_id = employees.department_id;


# display the department name, city, and state province for each department

SELECT departments.department_name, locations.city, locations.state_province
FROM departments
JOIN locations
ON departments.location_id = locations.location_id; 


#display the first name, last name, department number and name, for all employees who have or have not any department

SELECT employees.first_name, employees.last_name, departments.department_id, departments.department_name
FROM employees
LEFT OUTER JOIN departments
ON employees.department_id = departments.department_id; 


#display the job title, department name, full name (first and last name ) of employee, and starting date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 1997

SELECT jobs.job_title, departments.department_name, employees.first_name, employees.last_name, job_history.start_date
FROM employees
JOIN departments
ON employees.department_id = departments.department_id
JOIN jobs
ON jobs.job_id = employees.job_id
JOIN job_history
ON jobs.job_id = job_history.job_id
WHERE job_history.start_date >= '1993-01-01' AND job_history.start_date <= '1997-08-31';



#display job title, full name (first and last name ) of employee, and the difference between maximum salary for the job and salary of the employee

SELECT jobs.job_title, employees.first_name, employees.last_name, jobs.max_salary - employees.salary AS salary_difference
FROM employees
JOIN jobs
ON jobs.job_id = employees.job_id;


#display the name of the department, average salary and number of employees working in that department who got commission

SELECT departments.department_name, AVG(employees.salary), COUNT(employees.commission_pct)
FROM employees
JOIN departments
ON departments.department_id = employees.department_id
GROUP BY departments.department_name; 


#display the full name (first and last name ) of employee, and job title of those employees who is working in the department which ID is 80

SELECT employees.first_name, employees.last_name, jobs.job_title, employees.department_id
FROM employees
JOIN jobs
ON jobs.job_id = employees.job_id
WHERE employees.department_id = 80;

#display the name of the country, city, and the departments which are running there

SELECT countries.country_name, locations.city, departments.department_name
FROM countries
JOIN locations
ON countries.country_id = locations.country_id
JOIN departments 
ON departments.location_id = locations.location_id;


#display department name and the full name (first and last name) of the manager

SELECT department_name, first_name || ' ' || last_name AS manager_name
FROM departments
JOIN employees
ON employees.employee_id = departments.manager_id; 


#display job title and average salary of employees

SELECT jobs.job_title, AVG(employees.salary)
FROM jobs
JOIN employees USING(job_id)
GROUP BY jobs.job_title; 


#display the details of jobs which was done by any of the employees who is presently earning a salary on and above 12000

SELECT job_history.*
FROM job_history
JOIN employees
USING(employee_id)
WHERE employees.salary >= 12000; 


#display the country name, city, and number of those departments where atleast 2 employees are working

SELECT countries.country_name, locations.city, COUNT(departments.department_id)
FROM countries
JOIN locations
USING (country_id)
JOIN departments 
USING (location_id)
WHERE departments.department_id IN 
		(SELECT department_id
			FROM employees
			GROUP BY department_id
			HAVING COUNT(department_id) >= 2)
GROUP BY countries.country_name, locations.city;


# display the department name, full name (first and last name) of manager, and their city

SELECT departments.department_name, first_name || ' ' || last_name AS manager_name, locations.city
FROM departments 
JOIN locations
USING(location_id)
JOIN employees
ON employees.employee_id = departments.manager_id; 


#display the employee ID, job name, number of days worked in for all those jobs in department 80

SELECT job_history.employee_id, jobs.job_title, job_history.end_date - job_history.start_date AS DAYS
FROM job_history
JOIN jobs
USING (job_id)
WHERE department_id = 80;


#display the full name (first and last name), and salary of those employees who working in any department located in London

SELECT employees.first_name || ' ' || employees.last_name AS employee_name, employees.salary, departments.department_name, locations.city
FROM employees
JOIN departments
USING(department_id)
JOIN locations
USING(location_id)
WHERE locations.city = 'London';


#display full name(first and last name), job title, starting and ending date of last jobs for those employees who worked without a commission percentage

SELECT employees.first_name || ' ' || employees.last_name AS employee_name, jobs.job_title, job_history.start_date, job_history.end_date 
FROM employees
JOIN jobs 
USING(job_id)
JOIN job_history
ON employees.employee_id = job_history.employee_id
WHERE employees.commission_pct IS NULL;


#display the department name and number of employees in each of the department

SELECT departments.department_name, COUNT(employees.employee_id)
FROM departments
JOIN employees
USING(department_id)
GROUP BY departments.department_id;


#display the full name (firt and last name ) of employee with ID and name of the country presently where (s)he is working

SELECT employees.employee_id, employees.first_name || ' ' || employees.last_name AS employee_name, countries.country_name
FROM employees
JOIN departments
USING(department_id)
JOIN locations
USING(location_id)
JOIN countries
USING(country_id);
