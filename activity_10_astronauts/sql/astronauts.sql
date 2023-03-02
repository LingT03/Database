-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: Ling Thang
-- Description: The astronauts database

CREATE DATABASE astronauts;

/c astronauts; 

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

copy Astronauts 
  (lastName,firstName,suffix,gender,birth,city,state,country,status,daysInSpace,Flights)
    from /Users/lingthang/CSdatabase/activity_10_astronauts/sql/astronauts.csv with DELIMITER ',' CSV HEADER;

/*
a) the total number of astronauts. 

b) the total number of American astronauts. 

c) the list of nationalities of all astronauts in alphabetical order. 

d) all astronaut names ordered by last name (use the format Last Name, First Name, Suffix to display the names). 

e) the total number of astronauts by gender. 

f) the total number of female astronauts that are still active. 

g) the total number of American female astronauts that are still active. 

h) the list of all American female astronauts that are still active ordered by last name (use the same name format used in d). 

i) the list of Chinese astronauts, displaying only their names and ages (use the same name format used in d). 

j) the total number of astronauts by country. 

k) the total number of American astronauts per state ordered by the totals in
descending order. 

l) the total number of astronauts by statuses (i.e., active or retired). 

m) name and age of all non-American astronauts in alphabetical order (use the same name format used in d). 

n) the average age of all American astronauts that are still active. 

*/