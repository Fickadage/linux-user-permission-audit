CREATE DATABASE security_monitor;
USE security_monitor;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE login_attempts (
    attempt_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    ip_address VARCHAR(45),
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    success BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (username, email) VALUES
('alice', 'alice@example.com'),
('ben', 'ben@example.com'),
('Gbenga', 'gbenga@example.com');

INSERT INTO login_attempts (user_id, ip_address, success) VALUES
(1, '192.168.1.10', TRUE),
(1, '192.168.1.10', FALSE),
(1, '192.168.1.10', FALSE),
(2, '10.0.0.5', TRUE),
(2, '10.0.0.5', FALSE),
(3, '203.0.113.45', FALSE),
(3, '203.0.113.45', FALSE),
(3, '203.0.113.45', FALSE);

SELECT u.username, l.ip_address, l.login_time
FROM login_attempts l
JOIN users u ON l.user_id = u.user_id
WHERE l.success = FALSE;

SELECT u.username, COUNT(*) AS failed_attempts
FROM login_attempts l
JOIN users u ON l.user_id = u.user_id
WHERE l.success = FALSE
GROUP BY u.username
HAVING COUNT(*) >= 3;

SELECT ip_address, COUNT(*) AS failed_attempts
FROM login_attempts
WHERE success = FALSE
GROUP BY ip_address
HAVING COUNT(*) >= 3;

SELECT u.username, COUNT(*) AS successful_logins
FROM login_attempts l
JOIN users u ON l.user_id = u.user_id
WHERE l.success = TRUE
GROUP BY u.username;

SELECT success, COUNT(*) AS total_attempts
FROM login_attempts
GROUP BY success;
