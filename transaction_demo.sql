-- Active: 1697686848847@@127.0.0.1@3306@sql_hr

-- SHOW TABLES;
-- DESC employees;
SHOW DATABASES;

USE sql_hr;

SELECT employee_id, salary FROM employees;
-- transaction
BEGIN;
UPDATE employees
SET salary = 80000 WHERE employee_id = 33391; 
ROLLBACK;
SELECT employee_id, first_name, salary FROM employees WHERE employee_id = 33391;

SHOW DATABASES;
