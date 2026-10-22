CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(50),
    balance DECIMAL(10,2)
);
INSERT INTO Accounts VALUES
(101, 'Aman', 5000.00),
(102, 'Riya', 3000.00),
(103, 'Rahul', 7000.00);
SELECT * FROM Accounts;
START TRANSACTION;
UPDATE Accounts
SET balance = balance - 1000
WHERE account_id = 101;
UPDATE Accounts
SET balance = balance + 1000
WHERE account_id = 102;
COMMIT;
SELECT * FROM Accounts;
START TRANSACTION;
UPDATE Accounts
SET balance = balance - 500
WHERE account_id = 101;
ROLLBACK;
SELECT * FROM Accounts;
START TRANSACTION;
UPDATE Accounts
SET balance = balance - 500
WHERE account_id = 101;
SAVEPOINT transfer_point;
UPDATE Accounts
SET balance = balance + 500
WHERE account_id = 102;
ROLLBACK TO SAVEPOINT transfer_point;
COMMIT;
SELECT * FROM Accounts;
START TRANSACTION;
UPDATE Accounts
SET balance = balance - 200
WHERE account_id = 101;
SAVEPOINT sp1;
UPDATE Accounts
SET balance = balance + 200
WHERE account_id = 102;
SAVEPOINT sp2;
UPDATE Accounts
SET balance = balance - 100
WHERE account_id = 103;
ROLLBACK TO SAVEPOINT sp2;
COMMIT;
SELECT * FROM Accounts;
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT * FROM Accounts;
COMMIT;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT * FROM Accounts;
COMMIT;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
SELECT * FROM Accounts;
COMMIT;
SELECT * FROM Accounts;