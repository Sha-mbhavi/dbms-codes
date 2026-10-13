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
    FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

INSERT INTO Department VALUES
(1, 'Engineering'),
(2, 'HR'),
(3, 'Accounts'),
(4, 'Sales'),
(5, 'Logistics');

INSERT INTO Project VALUES
(201, 'AI Assistant', 1),
(202, 'Web Portal', 1),
(203, 'Cloud Service', 1),
(204, 'Security System', 1),
(205, 'Budget Analysis', 3),
(206, 'Sales Dashboard', 4),
(207, 'Stock Management', 5),
(208, 'Employee Portal', 2);

INSERT INTO Employee VALUES
(1, 'Devansh', 72000, 1, 201, NULL),
(2, 'Mira', 54000, 1, 202, 1),
(3, 'Ibrahim', 61000, 1, 203, 1),
(4, 'Sanya', 46000, 2, 208, NULL),
(5, 'Neil', 63000, 3, 205, NULL),
(6, 'Tanishka', 81000, 1, 201, 1),
(7, 'Ritvik', 57000, 4, 206, NULL),
(8, 'Ayesha', 44000, 5, 207, NULL),
(9, 'Manav', 49000, 2, 208, 4),
(10, 'Zoya', 67000, 3, 205, 5),
(11, 'Parth', 47000, 2, 208, 4),
(12, 'Nandini', 52000, 4, 206, 7),
(13, 'Kunal', 76000, 1, 201, 1),
(14, 'Lavanya', 65000, 3, 205, 5),
(15, 'Rehan', 59000, 4, 206, 7),
(16, 'Ishaan', 51000, 5, 207, 8),
(17, 'Tia', 56000, 1, 203, 1),
(18, 'Om', 48000, 2, 208, 4),
(19, 'Rhea', 74000, 1, 202, 1),
(20, 'Arush', 62000, 4, 206, 7),
(21, 'Samar', 58000, 3, 205, 5),
(22, 'Kiara', 50000, 2, 208, 4),
(23, 'Yuvan', 55000, 5, 207, 8),
(24, 'Aarohi', 69000, 1, 201, 1),
(25, 'Farhan', 64000, 3, 205, 5),
(26, 'Anika', 53000, 2, 208, 4),
(27, 'Raghav', 47000, 5, 207, 8),
(28, 'Simran', 60000, 4, 206, 7),
(29, 'Vihaan', 59000, 3, 205, 5),
(30, 'Pallavi', 51000, 2, 208, 4);

SELECT e.emp_id, e.emp_name, d.dept_name
FROM Employee e
INNER JOIN Department d
ON e.dept_id = d.dept_id;

SELECT e.emp_id, e.emp_name, d.dept_name
FROM Employee e
LEFT JOIN Department d
ON e.dept_id = d.dept_id;

SELECT e.emp_id, e.emp_name, m.emp_name AS manager_name
FROM Employee e
LEFT JOIN Employee m
ON e.manager_id = m.emp_id;

SELECT e.emp_id, e.emp_name, d.dept_name, p.project_name
FROM Employee e
INNER JOIN Department d
ON e.dept_id = d.dept_id
INNER JOIN Project p
ON e.project_id = p.project_id;

SELECT e.emp_id, e.emp_name, e.salary, e.dept_id
FROM Employee e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM Employee e2
    WHERE e2.dept_id = e.dept_id
);

SELECT d.dept_id, d.dept_name
FROM Department d
WHERE EXISTS (
    SELECT 1
    FROM Employee e
    WHERE e.dept_id = d.dept_id
);

SELECT d.dept_id, d.dept_name
FROM Department d
WHERE NOT EXISTS (
    SELECT 1
    FROM Employee e
    WHERE e.dept_id = d.dept_id
);

SELECT e.emp_id, e.emp_name
FROM Employee e
WHERE e.dept_id IN (
    SELECT dept_id
    FROM Employee
    WHERE salary > 70000
);

SELECT e.emp_id, e.emp_name
FROM Employee e
WHERE e.salary > 70000
AND e.dept_id IN (
    SELECT dept_id
    FROM Employee
    WHERE salary > 70000
);

SELECT e.emp_id, e.emp_name
FROM Employee e
WHERE e.dept_id IN (
    SELECT dept_id
    FROM Employee
    WHERE salary > 70000
)
AND NOT EXISTS (
    SELECT 1
    FROM Employee e2
    WHERE e2.emp_id = e.emp_id
    AND e2.salary > 75000
);

EXPLAIN
SELECT e.emp_id, e.emp_name, d.dept_name
FROM Employee e
INNER JOIN Department d
ON e.dept_id = d.dept_id;

EXPLAIN
SELECT e.emp_id, e.emp_name
FROM Employee e
WHERE e.dept_id IN (
    SELECT dept_id
    FROM Employee
    WHERE salary > 70000
);