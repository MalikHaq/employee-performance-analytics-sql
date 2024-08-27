# Employee Performance and Retention Analysis System

## Description

This project implements an SQL-based Employee Performance and Retention Analysis System. It's designed to help companies analyze employee performance, track retention rates, and make data-driven decisions about their workforce. The system uses a relational database to store and manage employee data, performance reviews, project assignments, and departmental information.

## Features

- Employee data management
- Performance review tracking
- Project assignment monitoring
- Department-wise analysis
- Retention rate calculation
- Salary trend analysis

## Database Schema

The system uses the following tables:

- `departments`: Stores department information
- `employees`: Contains employee details
- `performance_reviews`: Tracks employee performance reviews
- `projects`: Manages project information
- `employee_projects`: Links employees to their assigned projects

## Key SQL Queries

1. Average performance rating by department
2. Employees without recent performance reviews
3. Department-wise retention rate
4. Top performers not assigned to current projects
5. Average salary increase for improved performance

## Installation

1. Clone this repository:      
``` 
git clone https://github.com/MalikHaq/employee-performance-retention-analysis.git
```

2. Set up your SQL database server (MySQL, PostgreSQL, etc.)
3. Run the SQL scripts in the `database` folder to create the schema and insert sample data

## Usage

1. Connect to your SQL database
2. Run the provided SQL queries to analyze employee data
3. Modify and extend queries as needed for your specific analysis requirements

## Screenshots

![image](https://github.com/user-attachments/assets/37f5ccfc-de77-468a-b205-c47f4582362b)

![image](https://github.com/user-attachments/assets/aad77920-4f3e-477f-9c69-2bce973be04e)

```SQL
SELECT d.department_name, AVG(pr.rating) AS avg_rating
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN performance_reviews pr ON e.employee_id = pr.employee_id
GROUP BY d.department_name
ORDER BY avg_rating DESC;
```

![image](https://github.com/user-attachments/assets/a28f8d3b-21ab-40c7-90eb-00be82f81d5b)


```SQL
SELECT e.first_name, e.last_name, e.hire_date, MAX(pr.review_date) AS last_review_date
FROM employees e
LEFT JOIN performance_reviews pr ON e.employee_id = pr.employee_id
GROUP BY e.employee_id
HAVING MAX(pr.review_date) < DATE_SUB(CURDATE(), INTERVAL 1 YEAR) OR MAX(pr.review_date) IS NULL
ORDER BY last_review_date;
```
![image](https://github.com/user-attachments/assets/1c2cb9ad-70d3-4488-96bf-ea547cd9eea8)


```SQL
SELECT d.department_name,
       COUNT(e.employee_id) AS total_employees,
       SUM(CASE WHEN DATEDIFF(CURDATE(), e.hire_date) > 365 THEN 1 ELSE 0 END) AS retained_employees,
       (SUM(CASE WHEN DATEDIFF(CURDATE(), e.hire_date) > 365 THEN 1 ELSE 0 END) * 100.0 / COUNT(e.employee_id)) AS retention_rate
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY retention_rate DESC;
```
![image](https://github.com/user-attachments/assets/3b4070bc-d3b2-44b3-b00c-81468611722d)


```SQL
SELECT e.first_name, e.last_name, e.email, MAX(pr.rating) AS max_rating
FROM employees e
JOIN performance_reviews pr ON e.employee_id = pr.employee_id
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
LEFT JOIN projects p ON ep.project_id = p.project_id AND (p.end_date IS NULL OR p.end_date >= CURDATE())
GROUP BY e.employee_id
HAVING max_rating >= 4 AND COUNT(p.project_id) = 0
ORDER BY max_rating DESC;
```
![image](https://github.com/user-attachments/assets/bee13345-6ddf-4bb7-8558-0d6cf0e0ec4b)


## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Malik Anwar

## Acknowledgments

- Thanks to all contributors who have helped shape this project
- Inspired by real-world HR challenges in the tech industry
