CREATE TABLE Railway_Booking (
    booking_id INT PRIMARY KEY,
    passenger_name VARCHAR(100),
    train_id INT,
    train_name VARCHAR(100),
    source_station VARCHAR(50),
    destination_station VARCHAR(50),
    journey_date DATE,
    seat_number INT,
    class_type VARCHAR(20),
    ticket_price DECIMAL(10,2),
    booking_status VARCHAR(20)
);
INSERT INTO Railway_Booking
SELECT
    n,
    CONCAT('Passenger_', n),
    100 + MOD(n, 50),
    CONCAT('Train_', MOD(n, 50)),
    CASE MOD(n, 5)
        WHEN 0 THEN 'Delhi'
        WHEN 1 THEN 'Mumbai'
        WHEN 2 THEN 'Chennai'
        WHEN 3 THEN 'Kolkata'
        ELSE 'Lucknow'
    END,
    CASE MOD(n, 5)
        WHEN 0 THEN 'Mumbai'
        WHEN 1 THEN 'Chennai'
        WHEN 2 THEN 'Kolkata'
        WHEN 3 THEN 'Lucknow'
        ELSE 'Delhi'
    END,
    DATE_ADD('2026-01-01', INTERVAL MOD(n, 365) DAY),
    MOD(n, 100) + 1,
    CASE MOD(n, 3)
        WHEN 0 THEN 'Sleeper'
        WHEN 1 THEN 'AC3'
        ELSE 'AC2'
    END,
    500 + MOD(n, 2000),
    CASE MOD(n, 4)
        WHEN 0 THEN 'Cancelled'
        ELSE 'Confirmed'
    END
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
        (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) d
) numbers
WHERE n <= 5000;
SELECT COUNT(*) AS Total_Records
FROM Railway_Booking;
SELECT *
FROM Railway_Booking
WHERE train_id = 110;
EXPLAIN
SELECT *
FROM Railway_Booking
WHERE train_id = 110;
CREATE INDEX idx_train_id
ON Railway_Booking(train_id);
SELECT *
FROM Railway_Booking
WHERE train_id = 110;
EXPLAIN
SELECT *
FROM Railway_Booking
WHERE train_id = 110;
CREATE INDEX idx_route_date
ON Railway_Booking(source_station, destination_station, journey_date);
SELECT *
FROM Railway_Booking
WHERE source_station = 'Delhi'
  AND destination_station = 'Mumbai'
  AND journey_date = '2026-02-15';
EXPLAIN
SELECT *
FROM Railway_Booking
WHERE source_station = 'Delhi'
  AND destination_station = 'Mumbai'
  AND journey_date = '2026-02-15';

CREATE INDEX idx_booking_status
ON Railway_Booking(booking_status);

SELECT *
FROM Railway_Booking
WHERE booking_status = 'Confirmed';

EXPLAIN
SELECT *
FROM Railway_Booking
WHERE booking_status = 'Confirmed';

SELECT
    train_id,
    COUNT(*) AS Total_Bookings
FROM Railway_Booking
GROUP BY train_id;

EXPLAIN
SELECT
    train_id,
    COUNT(*) AS Total_Bookings
FROM Railway_Booking
GROUP BY train_id;

SHOW INDEX FROM Railway_Booking;