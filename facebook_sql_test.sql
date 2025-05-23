-- TABLE SETUP

DROP TABLE IF EXISTS ads;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    signup_date DATE,
    country VARCHAR(50)
);

CREATE TABLE events (
    event_id INT PRIMARY KEY,
    user_id INT,
    event_type VARCHAR(50),
    event_timestamp DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE ads (
    ad_id INT PRIMARY KEY,
    user_id INT,
    ad_revenue DECIMAL(10,2),
    clicked BOOLEAN,
    impression_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- SAMPLE DATA

INSERT INTO users VALUES
(1, 'Alice', '2023-01-01', 'USA'),
(2, 'Bob', '2023-01-05', 'Canada'),
(3, 'Charlie', '2023-02-10', 'UK'),
(4, 'Diana', '2023-03-15', 'USA');

INSERT INTO events VALUES
(101, 1, 'login', '2024-06-01 08:00:00'),
(102, 1, 'like', '2024-06-01 09:00:00'),
(103, 2, 'login', '2024-06-01 10:00:00'),
(104, 3, 'comment', '2024-06-02 12:00:00'),
(105, 4, 'login', '2024-06-03 14:00:00');

INSERT INTO ads VALUES
(201, 1, 3.50, TRUE, '2024-06-01 08:30:00'),
(202, 2, 2.00, FALSE, '2024-06-01 10:15:00'),
(203, 3, 5.25, TRUE, '2024-06-02 12:30:00'),
(204, 1, 4.75, FALSE, '2024-06-03 09:45:00');

-- FINAL SELECT STATEMENT

SELECT 
    u.user_id,
    u.name,
    u.country,
    ROUND(SUM(a.ad_revenue), 2) AS total_ad_revenue
FROM users u
LEFT JOIN ads a ON u.user_id = a.user_id
GROUP BY u.user_id, u.name, u.country
ORDER BY total_ad_revenue DESC;