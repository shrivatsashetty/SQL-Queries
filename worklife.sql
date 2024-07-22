CREATE DATABASE worklifeDB;
USE worklifeDB


-- Create the 'companies' table
CREATE TABLE companies (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

-- Insert data into the 'companies' table
INSERT INTO companies (company_name, city)
VALUES
    ('TCS', 'Mumbai'),
    ('Infosys', 'Bangalore'),
    ('Wipro', 'Bangalore'),
    ('HCL', 'Noida');

-- Create the 'employees' table
CREATE TABLE employees (
    emp_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50) REFERENCES companies (city)
);

-- Insert data into the 'employees' table
INSERT INTO employees (emp_name, street, city)
VALUES
    ('Employee1', 'Street1', 'Mumbai'),
    ('Employee2', 'Street2', 'Bangalore'),
    ('Employee3', 'Street3', 'Mumbai'),
    ('Employee4', 'Street4', 'Noida');

-- Create the 'works' table
CREATE TABLE works (
    emp_name VARCHAR(50),
    company_name VARCHAR(50),
    salary DECIMAL(10, 2),
    PRIMARY KEY (emp_name, company_name),
    FOREIGN KEY (emp_name) REFERENCES employees (emp_name),
    FOREIGN KEY (company_name) REFERENCES companies (company_name)
);

-- Insert data into the 'works' table
INSERT INTO works (emp_name, company_name, salary)
VALUES
    ('Employee1', 'TCS', 12000.00),
    ('Employee2', 'Infosys', 11000.00),
    ('Employee3', 'TCS', 13000.00),
    ('Employee4', 'HCL', 9000.00);

-- DROP DATABASE worklife;

SHOW TABLES;

SELECT * FROM companies;

SELECT * FROM works;

-- Queries
SELECT emp.emp_name, emp.city AS employee_location, comp.company_name, comp.city AS company_location
FROM employees AS emp JOIN works ON emp.emp_name = works.emp_name
JOIN companies AS comp ON works.company_name = comp.company_name
WHERE emp.city = comp.city;

SELECT emp.emp_name, emp.street, works.company_name, works.salary 
FROM employees AS emp
JOIN works ON emp.emp_name = works.emp_name
WHERE works.company_name = "TCS" AND works.salary > 11000;

SELECT AVG(salary) FROM works WHERE company_name = "TCS";

SELECT company_name, AVG(salary) AS avg_salary 
FROM works
GROUP BY company_name
HAVING avg_salary > 1000;

SELECT COUNT (*) AS result_count FROM (SELECT company_name, AVG(salary) AS avg_salary 
FROM works
GROUP BY company_name
HAVING avg_salary > 1000) AS subtable;
