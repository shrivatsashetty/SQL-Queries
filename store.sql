USE shop; 
SHOW TABLES;
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY, 
    customer_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS products(
    product_id INT NOT NULL PRIMARY KEY,
    product_name VARCHAR(200) UNIQUE,
    price INT CHECK (price > 0) 
);

CREATE TABLE IF NOT EXISTS orders(
    order_id INT PRIMARY KEY NOT NULL,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id)
)

INSERT INTO customers VALUES (4, "Brendon");

INSERT INTO products VALUES(1, "Nike Mercurial", 7000), (2, "Puma Thunder", 10000)

-- INSERT INTO products VALUES(1, "Nike Mercurial", -8000) -- Will violate check constraint

INSERT INTO orders VALUES (3,1,3);

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

DROP Table orders;
