-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: Ling Thang
-- Description: The astronauts database

CREATE DATABASE astronauts;

/c astronauts

CREATE TABLE astronauts (
    id SERIAL PRIMARY KEY,
    lastname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    suffix VARCHAR(5),
    gender VARCHAR(50) NOT NULL,
    birth Date NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    status VARCHAR(50),
    daysInSpace INT NOT NULL,
    Flights INT NOT NULL,
);

\copy astronauts 
  (lastName, firstName, suffix, gender, birth, city, state, country, status, daysInSpace, Flights)
    from /var/lib/postgresql/data/astronauts.csv DELIMITER ',' HEADER;


-- a) the total number of astronauts. 
    SELECT COUNT(*) FROM astronauts;
-- b) the total number of American astronauts. 
    Select COUNT(*) FROM astronauts WHERE country = 'USA';
-- c) the list of nationalities of all astronauts in alphabetical order. 
    SELECT DISTINCT country FROM astronauts ORDER BY country; -- or you can use 1 instead of country because 1 is also the only column in the table
-- d) all astronaut names ordered by last name (use the format Last Name, First Name, Suffix to display the names). 
    SELECT CONCAT(lastName, ',', firstName, ',', suffix) FROM astronauts ORDER BY lastName;
-- e) the total number of astronauts by gender. 
    SELECT COUNT(*) AS total FROM astronauts GROUP BY gender;
-- f) the total number of female astronauts that are still active. 
    SELECT COUNT(*) AS total from astronauts 
    WHERE gender = 'F' AND status = 'Active';
-- g) the total number of American female astronauts that are still active. 
    SELECT COUNT(*) AS total from astronauts 
    WHERE gender = 'F' AND status = 'Active' AND country = 'USA';
-- h) the list of all American female astronauts that are still active ordered by last name (use the same name format used in d). 
    SELECT CONCAT (lastName, ' ,' , firstName) AS name FROM astronauts
    WHERE status = 'Active';
-- i) the list of Chinese astronauts, displaying only their names and ages (use the same name format used in d). 
    SELECT CONCAT (lastName, ' ,' , firstName) AS name, DATE_PART('year', AGE(birth)) AS age FROM astronauts
    WHERE country = 'China' ORDER BY lastName; 
        -- TIMESTAMPDIFF(YEAR, birth, CURDATE()) takes the difference between the current date and the birth date and returns the age in years
        -- or DATE_PART('year', AGE(birth)) returns the age in years
-- j) the total number of astronauts by country. 
    SELECT COUNT(*) AS total, country FROM astronauts GROUP BY country;
-- k) the total number of American astronauts per state ordered by the totals in descending order. 
    SELECT COUNT(*) AS total, state FROM astronauts WHERE country = 'USA' GROUP BY state ORDER BY total DESC;
-- l) the total number of astronauts by statuses (i.e., active or retired). 
    SELECT COUNT(*) AS total, status FROM astronauts GROUP BY status;
-- m) name and age of all non-American astronauts in alphabetical order (use the same name format used in d). 
    SELECT CONCAT (lastName, ' ,' , firstName) AS name, DATE_PART('year', AGE(birth)) AS age FROM astronauts
    WHERE country != 'USA' ORDER BY 1;
-- n) the average age of all American astronauts that are still active. 
    SELECT AVG(DATE_PART('year', AGE(birth))) AS Average_Age FROM astronauts
    WHERE country = 'USA' AND status = 'Active';
