DROP PROCEDURE IF EXISTS transfer_employee;

DROP TRIGGER IF EXISTS validate_employee_salary;
DROP TRIGGER IF EXISTS validate_employee_salary_update;
DROP TRIGGER IF EXISTS audit_employee_update;
DROP TRIGGER IF EXISTS audit_employee_insert;

DROP TABLE IF EXISTS Employee_Audit;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Project (
project_id INT PRIMARY KEY,
project_name VARCHAR(100),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Employee (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50) NOT NULL,
salary DECIMAL(10,2) NOT NULL,
dept_id INT,
project_id INT,
manager_id INT,
FOREIGN KEY (dept_id) REFERENCES Department(dept_id),
FOREIGN KEY (project_id) REFERENCES Project(project_id),
FOREIGN KEY (manager_id) REFERENCES Employee(emp_id)
);

CREATE TABLE Employee_Audit (
audit_id INT AUTO_INCREMENT PRIMARY KEY,
emp_id INT,
old_dept_id INT,
new_dept_id INT,
old_salary DECIMAL(10,2),
new_salary DECIMAL(10,2),
action_type VARCHAR(30),
action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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

DELIMITER //

CREATE TRIGGER validate_employee_salary
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
IF NEW.salary <= 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Salary must be greater than zero';
END IF;
END//

CREATE TRIGGER validate_employee_salary_update
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
IF NEW.salary <= 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Salary must be greater than zero';
END IF;
END//

CREATE TRIGGER audit_employee_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
INSERT INTO Employee_Audit
(emp_id, old_dept_id, new_dept_id, old_salary, new_salary, action_type)
VALUES
(OLD.emp_id, OLD.dept_id, NEW.dept_id, OLD.salary, NEW.salary, 'UPDATE');
END//

CREATE PROCEDURE transfer_employee(
IN p_emp_id INT,
IN p_new_dept_id INT
)
BEGIN
DECLARE employee_exists INT DEFAULT 0;
DECLARE department_exists INT DEFAULT 0;

SELECT COUNT(*)
INTO employee_exists
FROM Employee
WHERE emp_id = p_emp_id;

IF employee_exists = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Employee does not exist';
END IF;

SELECT COUNT(*)
INTO department_exists
FROM Department
WHERE dept_id = p_new_dept_id;

IF department_exists = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Department does not exist';
END IF;

UPDATE Employee
SET dept_id = p_new_dept_id
WHERE emp_id = p_emp_id;

SELECT 'Employee transferred successfully' AS message;

END//

DELIMITER ;

SELECT emp_id, emp_name, dept_id
FROM Employee
WHERE emp_id = 3;

CALL transfer_employee(3, 4);

SELECT emp_id, emp_name, dept_id
FROM Employee
WHERE emp_id = 3;

SELECT *
FROM Employee_Audit;

SELECT emp_id, emp_name, salary
FROM Employee
WHERE emp_id = 3;

UPDATE Employee
SET salary = 60000
WHERE emp_id = 3;

SELECT *
FROM Employee_Audit;

SELECT *
FROM Employee_Audit
WHERE emp_id = 3;

SELECT emp_id, emp_name, salary
FROM Employee
WHERE emp_id = 3;

SELECT emp_id, emp_name, dept_id
FROM Employee
WHERE emp_id = 999;

SELECT dept_id, dept_name
FROM Department
WHERE dept_id = 999;