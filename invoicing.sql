USE sql_invoicing;

SELECT * FROM invoices;

SELECT * FROM payment_methods;


SHOW TABLES;

SELECT MAX(invoice_total) FROM invoices;

SELECT number FROM invoices
WHERE invoice_total  > ALL(SELECT MAX(payment_total) FROM invoices);

-- create a customer TABLE
CREATE TABLE customers(cid INTEGER PRIMARY KEY, first_name VARCHAR(25), pincode INTEGER, dob DATE);