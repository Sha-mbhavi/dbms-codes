CREATE TABLE Employee_Data (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    city VARCHAR(50),
    experience INT,
    joining_date DATE
);
INSERT INTO Employee_Data
SELECT
    n,
    CONCAT('Employee_', n),
    CASE MOD(n, 5)
        WHEN 0 THEN 'IT'
        WHEN 1 THEN 'HR'
        WHEN 2 THEN 'Sales'
        WHEN 3 THEN 'Finance'
        ELSE 'Marketing'
    END,
    20000 + MOD(n * 137, 80000),
    CASE MOD(n, 5)
        WHEN 0 THEN 'Delhi'
        WHEN 1 THEN 'Mumbai'
        WHEN 2 THEN 'Lucknow'
        WHEN 3 THEN 'Chennai'
        ELSE 'Pune'
    END,
    MOD(n, 20) + 1,
    DATE_ADD('2015-01-01', INTERVAL MOD(n, 3650) DAY)
FROM (
    SELECT
        a.n + b.n * 10 + c.n * 100 + d.n * 1000 + 1 AS n
    FROM
        (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
    CROSS JOIN
        (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
    CROSS JOIN
        (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c
    CROSS JOIN
        (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) d
) numbers
WHERE n <= 10000;
SELECT COUNT(*) AS Total_Records
FROM Employee_Data;
SELECT *
FROM Employee_Data
WHERE department = 'IT';
EXPLAIN
SELECT *
FROM Employee_Data
WHERE department = 'IT';
SELECT *
FROM Employee_Data
WHERE salary > 70000;
EXPLAIN
SELECT *
FROM Employee_Data
WHERE salary > 70000;
SELECT *
FROM Employee_Data
WHERE city = 'Delhi'
AND experience > 10;
EXPLAIN
SELECT *
FROM Employee_Data
WHERE city = 'Delhi'
AND experience > 10;
SELECT department, AVG(salary) AS Average_Salary
FROM Employee_Data
GROUP BY department;
EXPLAIN
SELECT department, AVG(salary) AS Average_Salary
FROM Employee_Data
GROUP BY department;
SELECT *
FROM Employee_Data
WHERE YEAR(joining_date) = 2020;
EXPLAIN
SELECT *
FROM Employee_Data
WHERE YEAR(joining_date) = 2020;
CREATE INDEX idx_department
ON Employee_Data(department);

CREATE INDEX idx_salary
ON Employee_Data(salary);

CREATE INDEX idx_city_experience
ON Employee_Data(city, experience);

CREATE INDEX idx_joining_date
ON Employee_Data(joining_date);

SELECT *
FROM Employee_Data
WHERE department = 'IT';

EXPLAIN
SELECT *
FROM Employee_Data
WHERE department = 'IT';

SELECT *
FROM Employee_Data
WHERE salary > 70000;

EXPLAIN
SELECT *
FROM Employee_Data
WHERE salary > 70000;

SELECT *
FROM Employee_Data
WHERE city = 'Delhi'
AND experience > 10;

EXPLAIN
SELECT *
FROM Employee_Data
WHERE city = 'Delhi'
AND experience > 10;

SELECT department, AVG(salary) AS Average_Salary
FROM Employee_Data
GROUP BY department;

EXPLAIN
SELECT department, AVG(salary) AS Average_Salary
FROM Employee_Data
GROUP BY department;

SELECT *
FROM Employee_Data
WHERE joining_date >= '2020-01-01'
AND joining_date < '2021-01-01';

EXPLAIN
SELECT *
FROM Employee_Data
WHERE joining_date >= '2020-01-01'
AND joining_date < '2021-01-01';

SELECT *
FROM Employee_Data
WHERE YEAR(joining_date) = 2020;

SELECT *
FROM Employee_Data
WHERE joining_date >= '2020-01-01'
AND joining_date < '2021-01-01';

SHOW INDEX FROM Employee_Data;

SELECT COUNT(*) AS Total_Records
FROM Employee_Data;