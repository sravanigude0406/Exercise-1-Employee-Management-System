-- Create the departments table if it does not exist
CREATE TABLE IF NOT EXISTS departments (
    department_id INTEGER PRIMARY KEY,
    department_name TEXT
);

-- Insert data into departments table if it does not already exist
INSERT OR IGNORE INTO departments (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Engineering'),
(4, 'Sales'),
(5, 'Marketing');

-- Create the employees table if it does not exist
CREATE TABLE IF NOT EXISTS employees (
    employee_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    department_id INTEGER,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Insert data into employees table if it does not already exist
INSERT OR IGNORE INTO employees (employee_id, first_name, last_name, department_id, hire_date) VALUES
(1, 'John', 'Doe', 3, '2023-01-15'),
(2, 'Jane', 'Smith', 2, '2022-11-20'),
(3, 'Emily', 'Johnson', 1, '2023-05-30'),
(4, 'Michael', 'Brown', 4, '2021-07-10'),
(5, 'Linda', 'Davis', 3, '2020-03-22'),
(6, 'Chris', 'Wilson', 5, '2021-12-01'),
(7, 'Patricia', 'Taylor', 1, '2022-03-15'),
(8, 'Robert', 'Anderson', 2, '2020-05-25'),
(9, 'Jennifer', 'Thomas', 3, '2019-08-19'),
(10, 'Daniel', 'Jackson', 4, '2023-02-10'),
(11, 'Laura', 'Harris', 5, '2021-11-05'),
(12, 'James', 'Martin', 1, '2020-07-15'),
(13, 'David', 'Thompson', 2, '2022-01-30'),
(14, 'Sarah', 'Garcia', 3, '2021-09-20'),
(15, 'Karen', 'Martinez', 4, '2023-04-25'),
(16, 'Nancy', 'Rodriguez', 5, '2020-02-28'),
(17, 'Charles', 'Lewis', 1, '2021-06-13'),
(18, 'Thomas', 'Lee', 2, '2022-08-03'),
(19, 'Barbara', 'Walker', 3, '2021-01-21'),
(20, 'Steven', 'Hall', 4, '2023-03-17'),
(21, 'Michelle', 'Clark', 3, DATE('now', '-2 months')),  -- Hired within last year
(22, 'Alexander', 'Wright', 4, DATE('now', '-1 months')),  -- Hired within last year
(23, 'Sophia', 'King', 2, DATE('now', '-7 months')),  -- Hired within last year
(24, 'William', 'Scott', 1, DATE('now', '-9 months')),  -- Hired within last year
(25, 'Olivia', 'Green', 5, DATE('now', '-10 months')),  -- Hired within last year
(26, 'Daniel', 'Adams', 3, DATE('now', '-11 months')),  -- Hired within last year
(27, 'Mia', 'Baker', 4, DATE('now', '-11 months')),  -- Hired within last year
(28, 'Ethan', 'Gonzalez', 1, DATE('now', '-12 months'));  -- Hired within last year

-- Create the salaries table if it does not exist
CREATE TABLE IF NOT EXISTS salaries (
    employee_id INTEGER,
    salary DECIMAL(10, 2),
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (employee_id, from_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Insert data into salaries table if it does not already exist
INSERT OR IGNORE INTO salaries (employee_id, salary, from_date, to_date) VALUES
(1, 80000.00, '2023-01-15', '9999-01-01'),
(2, 95000.00, '2022-11-20', '9999-01-01'),
(3, 60000.00, '2023-05-30', '9999-01-01'),
(4, 70000.00, '2021-07-10', '9999-01-01'),
(5, 120000.00, '2020-03-22', '9999-01-01'),
(6, 55000.00, '2021-12-01', '9999-01-01'),
(7, 62000.00, '2022-03-15', '9999-01-01'),
(8, 87000.00, '2020-05-25', '9999-01-01'),
(9, 115000.00, '2019-08-19', '9999-01-01'),
(10, 72000.00, '2023-02-10', '9999-01-01'),
(11, 58000.00, '2021-11-05', '9999-01-01'),
(12, 63000.00, '2020-07-15', '9999-01-01'),
(13, 91000.00, '2022-01-30', '9999-01-01'),
(14, 75000.00, '2021-09-20', '9999-01-01'),
(15, 68000.00, '2023-04-25', '9999-01-01'),
(16, 54000.00, '2020-02-28', '9999-01-01'),
(17, 66000.00, '2021-06-13', '9999-01-01'),
(18, 92000.00, '2022-08-03', '9999-01-01'),
(19, 74000.00, '2021-01-21', '9999-01-01'),
(20, 79000.00, '2023-03-17', '9999-01-01'),
(21, 88000.00, '2023-06-10', '9999-01-01'),
(22, 86000.00, '2023-03-05', '9999-01-01'),
(23, 94000.00, '2023-01-12', '9999-01-01'),
(24, 91000.00, '2022-12-20', '9999-01-01'),
(25, 98000.00, '2022-11-15', '9999-01-01'),
(26, 72000.00, '2022-10-25', '9999-01-01'),
(27, 84000.00, '2022-09-30', '9999-01-01'),
(28, 89000.00, '2022-08-05', '9999-01-01');

-- Query: Employees hired in the last year
SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE hire_date >= DATE('now', '-1 year');


-- Query 2: Total salary expenditure for each department
SELECT d.department_id, d.department_name, SUM(s.salary) AS total_salary_expenditure
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.to_date = '9999-01-01'
GROUP BY d.department_id, d.department_name;

-- Query 3: Top 5 highest-paid employees with department names
SELECT e.employee_id, e.first_name, e.last_name, d.department_name, s.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 5;
