CREATE DATABASE IF NOT EXISTS musicDB;

USE musicDB;

-- Create the 'musicians' table
CREATE TABLE musicians (
    ssn INT PRIMARY KEY,
    name VARCHAR(50),
    dob DATE,
    phone VARCHAR(20)
);

-- Insert data into the 'musicians' table
INSERT INTO musicians (ssn, name, dob, phone)
VALUES
    (1, 'Vickram', '1990-05-15', '123-456-7890'),
    (2, 'John', '1985-03-20', '987-654-3210'),
    (3, 'Lisa', '1995-08-10', '555-123-7890'),
    (4, 'Alice', '1988-12-05', '777-888-9999');

-- Create the 'albums' table
CREATE TABLE albums (
    album_id INT PRIMARY KEY,
    album_name VARCHAR(100),
    no_of_songs INT,
    musician_ssn INT,
    FOREIGN KEY (musician_ssn) REFERENCES musicians(ssn)
);

-- Insert data into the 'albums' table
INSERT INTO albums (album_id, album_name, no_of_songs, musician_ssn)
VALUES
    (101, 'Album1', 12, 1),
    (102, 'Album2', 10, 1),
    (103, 'Album3', 15, 2),
    (104, 'Album4', 8, 2),
    (105, 'Album5', 9, 3),
    (106, 'Album6', 11, 3),
    (107, 'Album7', 13, 4),
    (108, 'Album8', 7, 4),
    (109, 'Album9', 14, 1),
    (110, 'Album10', 16, 2);

-- Queries
USE musicDB;

SELECT ssn FROM musicians WHERE name = "Vickram";

SHOW TABLES;

SELECT a.album_name, m.name 
FROM albums a,
-- JOIN musicians AS m
-- ON m.ssn = a.musician_ssn
musicians m 
WHERE m.ssn = a.musician_ssn AND m.name = "Vickram";

SELECT a.musician_ssn, m.name, COUNT (a.musician_ssn) AS album_count
FROM albums AS a
JOIN musicians AS m
ON m.ssn = a.musician_ssn
GROUP BY a.musician_ssn
-- HAVING album_count = 
;

SELECT COUNT (a.musician_ssn) AS album_count
FROM albums AS a
JOIN musicians AS m
ON m.ssn = a.musician_ssn
GROUP BY a.musician_ssn
-- HAVING album_count = 
;

SELECT  musician_ssn, name, dob, phone,
MAX(album_count) as album_count
FROM(SELECT a.musician_ssn, m.name, m.dob, m.phone, 
COUNT(a.musician_ssn) AS album_count
FROM albums AS a
JOIN musicians AS m
ON m.ssn = a.musician_ssn
GROUP BY a.musician_ssn) AS count
GROUP BY musician_ssn
LIMIT 1 ;

SELECT musician_ssn,  COUNT(musician_ssn) AS album_count
FROM albums
GROUP BY musician_ssn;


SELECT a.musician_ssn, m.name, m.dob, m.phone, 
COUNT(a.musician_ssn) AS album_count
FROM albums AS a
JOIN musicians AS m
ON m.ssn = a.musician_ssn
GROUP BY a.musician_ssn
HAVING album_count = 
(SELECT MAX(album_count)
FROM(SELECT a.musician_ssn, m.name, m.dob, m.phone, 
    COUNT(a.musician_ssn) AS album_count
    FROM albums AS a
    JOIN musicians AS m
    ON m.ssn = a.musician_ssn
    GROUP BY a.musician_ssn) AS sub);

SELECT MAX(album_count)
FROM(SELECT a.musician_ssn, m.name, m.dob, m.phone, 
    COUNT(a.musician_ssn) AS album_count
    FROM albums AS a
    JOIN musicians AS m
    ON m.ssn = a.musician_ssn
    GROUP BY a.musician_ssn) AS sub;

SELECT MAX(album_count) 
FROM (SELECT COUNT(album_id) AS album_count FROM albums GROUP BY musician_ssn)AS subquery

SELECT m.name AS musician_name , COUNT(a.album_id) AS number_of_albums
FROM musicians m
LEFT JOIN albums a ON m.ssn = a.musician_ssn
GROUP BY m.name;

SELECT m.name AS musician_name, COUNT(a.album_id) AS number_of_albums
FROM musicians m
LEFT JOIN albums a ON m.ssn = a.musician_ssn
GROUP BY m.name
HAVING COUNT(a.album_id) = (SELECT MAX(album_count) 
FROM (SELECT COUNT(album_id) AS album_count FROM albums GROUP BY musician_ssn) AS subquery);