DROP VIEW IF EXISTS Employee_Hierarchy;
DROP VIEW IF EXISTS Department_Salary_Summary;
DROP VIEW IF EXISTS IT_Employees;

DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    project_id INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id),
    FOREIGN KEY (manager_id) REFERENCES Employee(emp_id)
);

INSERT INTO Department VALUES
(1, 'Technology'),
(2, 'Human Resources'),
(3, 'Accounts'),
(4, 'Sales'),
(5, 'Logistics');

INSERT INTO Project VALUES
(201, 'Smart AI Assistant', 1),
(202, 'Company Website', 1),
(203, 'Cloud Migration', 1),
(204, 'Network Protection', 1),
(205, 'Financial Dashboard', 3),
(206, 'Employee Portal', 2),
(207, 'Delivery Tracker', 5),
(208, 'Sales Management', 4);

INSERT INTO Employee VALUES
(1, 'Rahul', 72000, 1, 201, NULL),
(2, 'Sneha', 54000, 1, 202, 1),
(3, 'Aman', 58000, 1, 203, 1),
(4, 'Neha', 45000, 2, 206, NULL),
(5, 'Varun', 63000, 3, 205, NULL),
(6, 'Ishita', 68000, 1, 201, 1),
(7, 'Manav', 52000, 4, 208, NULL),
(8, 'Divya', 47000, 5, 207, NULL),
(9, 'Ritika', 48000, 2, 206, 4),
(10, 'Kunal', 61000, 3, 205, 5),
(11, 'Meera', 46000, 2, 206, 4),
(12, 'Siddharth', 56000, 4, 208, 7),
(13, 'Ananya', 75000, 1, 201, 1),
(14, 'Yuvraj', 65000, 3, 205, 5),
(15, 'Palak', 53000, 4, 208, 7),
(16, 'Raghav', 50000, 5, 207, 8),
(17, 'Tanvi', 57000, 1, 203, 1),
(18, 'Akash', 44000, 2, 206, 4),
(19, 'Nandini', 69000, 1, 204, 1),
(20, 'Pranav', 59000, 4, 208, 7),
(21, 'Sakshi', 51000, 3, 205, 5),
(22, 'Dhruv', 49000, 2, 206, 4),
(23, 'Mitali', 55000, 5, 207, 8),
(24, 'Kabir', 64000, 1, 201, 1),
(25, 'Aarav', 60000, 3, 205, 5),
(26, 'Simar', 47000, 2, 206, 4),
(27, 'Reyansh', 48000, 5, 207, 8),
(28, 'Ayesha', 54000, 4, 208, 7),
(29, 'Nakul', 57000, 3, 205, 5),
(30, 'Myra', 50000, 2, 206, 4);

CREATE OR REPLACE VIEW Department_Salary_Summary AS
SELECT
    d.dept_id,
    d.dept_name,
    COUNT(e.emp_id) AS employee_count,
    SUM(e.salary) AS total_salary,
    AVG(e.salary) AS average_salary
FROM Department d
LEFT JOIN Employee e
    ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;

SELECT * FROM Department_Salary_Summary;

CREATE OR REPLACE VIEW Employee_Hierarchy AS
SELECT
    e.emp_id,
    e.emp_name,
    e.dept_id,
    e.manager_id,
    m.emp_name AS manager_name
FROM Employee e
LEFT JOIN Employee m
    ON e.manager_id = m.emp_id;

SELECT * FROM Employee_Hierarchy;

CREATE OR REPLACE VIEW IT_Employees AS
SELECT
    emp_id,
    emp_name,
    salary,
    dept_id
FROM Employee
WHERE dept_id = 1
WITH CHECK OPTION;

SELECT * FROM IT_Employees;

UPDATE IT_Employees
SET salary = salary + 1500
WHERE emp_id = 2;

SELECT * FROM IT_Employees;

SELECT *
FROM Employee
WHERE emp_id = 2;

WITH RECURSIVE Reporting_Chain AS (
    SELECT
        emp_id,
        emp_name,
        manager_id,
        1 AS hierarchy_level
    FROM Employee
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.emp_id,
        e.emp_name,
        e.manager_id,
        rc.hierarchy_level + 1
    FROM Employee e
    INNER JOIN Reporting_Chain rc
        ON e.manager_id = rc.emp_id
)
SELECT
    emp_id,
    emp_name,
    manager_id,
    hierarchy_level
FROM Reporting_Chain
ORDER BY hierarchy_level, emp_id;