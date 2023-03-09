-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The employees database

-- TODO: create database employees
    CREATE DATABASE employees;
    -- \c employees
-- TODO: create table departments
    CREATE TABLE departments (
        code VARCHAR(3) PRIMARY KEY,
        description VARCHAR(50)
    );
-- TODO: populate table departments
    INSERT INTO departments VALUES 
    ('HR', 'Human Resources'),
    ('IT', 'Information Technology'),
    ('SL', 'Sales'),
    ('MK', 'Marketing');
-- TODO: create table employees
    CREATE TABLE employees (
        id SERIAL PRIMARY KEY NOT NULL,
        name VARCHAR(50),
        salary INT,
        deptCode VARCHAR(4),
        FOREIGN KEY (deptCode) REFERENCES departments(code)
    );
-- TODO: populate table Employees
    INSERT INTO employees (name, salary, deptCode) VALUES
    ('Sam Mai Tai', 50000, 'HR'),
    ('James Brandi', 55000, 'HR'),
    ('Whisky Strauss', 60000, 'HR'),
    ('Romeo Curacau', 65000, 'IT'),
    ('Jose Caipirinha', 65000, 'IT'),
    ('Tony Gin and Tonic', 80000, 'SL'),
    ('Debby Derby', 85000, 'SL'),
    ('Morbid Mojito', 150000, NULL);

-- TODO: a) list all rows in Departments.
    SELECT * FROM departments;

-- TODO: b) list only the codes in Departments.
    SELECT code FROM departments;

-- TODO: c) list all rows in Employees.
    SELECT * FROM employees;
    
-- TODO: d) list only the names in Employees in alphabetical order.
    SELECT name FROM employees ORDER BY name;

-- TODO: e) list only the names and salaries in Employees, from the highest to the lowest salary.
    SELECT name, salary FROM employees ORDER BY salary DESC;

-- TODO: f) list the cartesian product of Employees and Departments.
    SELECT * FROM employees, departments;

-- TODO: g) do the natural join of Employees and Departments; the result should be exactly the same as the cartesian product; do you know why?
    SELECT id, code, code FROM employees NATURAL JOIN departments;

-- TODO: i) do an equi join of Employees and Departments matching the rows by Employees.deptCode and Departments.code (hint: use JOIN and the ON clause).
    SELECT * FROM employees A, department b
    WHERE A.deptCode = b.code;

-- TODO: j) same as previous query but project name and salary of the employees plus the description of their departments.
    SELECT name, salary, "description"
    FROM employees A
    INNER JOIN departments b
    ON  A.deptCode = B.code;
    
-- TODO: k) same as previous query but only the employees that earn less than 60000.
    SELECT name, salary, "description"
    FROM employees A
    INNER JOIN departments b
    ON  A.deptCode = B.code
    WHERE salary < 60000;

-- TODO: l) same as query ‘i’  but only the employees that earn more than ‘Jose Caipirinha’.
    SELECT name, salary, "description"
    FROM employees A
    INNER JOIN departments b
    ON  A.deptCode = B.code
    WHERE salary > (SELECT salary FROM employees WHERE name = 'Jose Caipirinha');

-- TODO: m) list the left outer join of Employees and Departments (use the ON clause to match by department code); how does the result of this query differs from query ‘i’?
    SELECT * FROM employees A
    LEFT JOIN departments B
    ON A.deptCode = B.code;

-- TODO: n) from query ‘m’, how would you do the left anti-join?
    SELECT * FROM employees A
    LEFT JOIN departments B
    ON A.deptCode = B.code
    WHERE B.code IS NULL;

-- TODO: o) show the number of employees per department.
    SELECT deptCode, COUNT(*) FROM employees
    GROUP BY deptCode;

-- TODO: p) same as query ‘o’ but I want to see the description of each department (not just their codes).
    SELECT * from Employees A 
    FULL JOIN Departments B
    on A.deptCode = B.code;
