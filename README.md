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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Malik Anwar

## Acknowledgments

- Thanks to all contributors who have helped shape this project
- Inspired by real-world HR challenges in the tech industry
