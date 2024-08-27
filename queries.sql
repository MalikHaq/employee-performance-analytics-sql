-- Create the database
CREATE DATABASE employee_performance_db;

-- Use the newly created database

USE employee_performance_db;

-- Now create the tables

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL,
    department_id INT,
    salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE performance_reviews (
    review_id INT PRIMARY KEY,
    employee_id INT,
    review_date DATE NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    role VARCHAR(50) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    PRIMARY KEY (employee_id, project_id)
);






-- Insert departments
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Engineering'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Human Resources');

-- Insert employees
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, department_id, salary) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '2020-01-15', 1, 75000),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '2019-05-20', 2, 65000),
(3, 'Mike', 'Johnson', 'mike.johnson@example.com', '2021-03-10', 1, 80000),
(4, 'Emily', 'Brown', 'emily.brown@example.com', '2018-11-01', 3, 70000),
(5, 'David', 'Lee', 'david.lee@example.com', '2022-07-01', 4, 60000);

-- Insert performance reviews
INSERT INTO performance_reviews (review_id, employee_id, review_date, rating, comments) VALUES
(1, 1, '2021-12-15', 4, 'Excellent problem-solving skills'),
(2, 2, '2021-12-20', 3, 'Met sales targets, but could improve client communication'),
(3, 3, '2022-03-10', 5, 'Outstanding performance, exceeded expectations'),
(4, 4, '2021-11-01', 4, 'Great team player, creative marketing ideas'),
(5, 5, '2023-01-15', 3, 'Good HR policies, needs improvement in conflict resolution');

-- Insert projects
INSERT INTO projects (project_id, project_name, start_date, end_date) VALUES
(1, 'Website Redesign', '2022-01-01', '2022-06-30'),
(2, 'Mobile App Development', '2022-03-15', '2022-12-31'),
(3, 'Sales CRM Implementation', '2022-05-01', '2022-08-31'),
(4, 'Employee Engagement Program', '2022-07-01', NULL);

-- Insert employee projects
INSERT INTO employee_projects (employee_id, project_id, role) VALUES
(1, 1, 'Lead Developer'),
(1, 2, 'Backend Developer'),
(2, 3, 'Project Manager'),
(3, 2, 'Frontend Developer'),
(4, 1, 'UI/UX Designer'),
(5, 4, 'Program Coordinator');


SELECT d.department_name, AVG(pr.rating) AS avg_rating
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN performance_reviews pr ON e.employee_id = pr.employee_id
GROUP BY d.department_name
ORDER BY avg_rating DESC;


SELECT e.first_name, e.last_name, e.hire_date, MAX(pr.review_date) AS last_review_date
FROM employees e
LEFT JOIN performance_reviews pr ON e.employee_id = pr.employee_id
GROUP BY e.employee_id
HAVING MAX(pr.review_date) < DATE_SUB(CURDATE(), INTERVAL 1 YEAR) OR MAX(pr.review_date) IS NULL
ORDER BY last_review_date;


SELECT d.department_name,
       COUNT(e.employee_id) AS total_employees,
       SUM(CASE WHEN DATEDIFF(CURDATE(), e.hire_date) > 365 THEN 1 ELSE 0 END) AS retained_employees,
       (SUM(CASE WHEN DATEDIFF(CURDATE(), e.hire_date) > 365 THEN 1 ELSE 0 END) * 100.0 / COUNT(e.employee_id)) AS retention_rate
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY retention_rate DESC;


SELECT e.first_name, e.last_name, e.email, MAX(pr.rating) AS max_rating
FROM employees e
JOIN performance_reviews pr ON e.employee_id = pr.employee_id
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
LEFT JOIN projects p ON ep.project_id = p.project_id AND (p.end_date IS NULL OR p.end_date >= CURDATE())
GROUP BY e.employee_id
HAVING max_rating >= 4 AND COUNT(p.project_id) = 0
ORDER BY max_rating DESC;


WITH employee_ratings AS (
    SELECT employee_id,
           review_date,
           rating,
           LAG(rating) OVER (PARTITION BY employee_id ORDER BY review_date) AS prev_rating
    FROM performance_reviews
)
SELECT AVG((e2.salary - e1.salary) / e1.salary * 100) AS avg_salary_increase_percentage
FROM employee_ratings er
JOIN employees e1 ON er.employee_id = e1.employee_id
JOIN employees e2 ON er.employee_id = e2.employee_id
WHERE er.rating > er.prev_rating
  AND e2.hire_date > e1.hire_date;
















