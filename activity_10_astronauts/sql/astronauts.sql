-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: Ling Thang
-- Description: The astronauts database

CREATE DATABASE astronauts;

/c astronauts; 

CREATE TABLE astronauts (
    id INT PRIMARY KEY,
    lastname VARCHAR(50),
    firstname VARCHAR(50),
    suffix VARCHAR(50),
    gender VARCHAR(50),
    birth Date,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    status VARCHAR(50),
    daysInSpace INT,
    Flights INT,
);