-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: Ling Thang 
-- Description: SQL for the audit database

DROP DATABASE audit;

CREATE DATABASE audit;

\c audit

CREATE TABLE Employees (
    id INT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL
); 

CREATE TABLE EmployeesAudit (
    seq SERIAL PRIMARY KEY, 
    date DATE NOT NULL, 
    descr VARCHAR(200) NOT NULL
);

--- CREATE FUNCTION employee_audit_after_insert() RETURNS TRIGGER
CREATE FUNCTION employee_audit_after_insert() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert a new record into the EmployeesAudit table with the current date and the description of the new employee
    INSERT INTO EmployeesAudit (date, descr) VALUES (now(), '(' || NEW.id || ', ' || NEW.name || ')');
    RETURN NEW;
    -- Return the new record
END;
$$;

-- CREATE TRIGGER employee_audit
CREATE TRIGGER employee_audit 
-- execute the employee_audit_after_insert function after an insert
AFTER INSERT ON Employees 
FOR EACH ROW
EXECUTE PROCEDURE employee_audit_after_insert();
-- For each row within the Employees table, execute the employee_audit_after_insert function


-- use the following insert statements to test your trigger
INSERT INTO Employees VALUES (101, 'Samuel Adams'); 
INSERT INTO Employees VALUES (202, 'Adolph Coors');
INSERT INTO Employees VALUES (303, 'Arthur Guinness');

/*

audit=# select * from employees;
 id  |      name       
-----+-----------------
 101 | Samuel Adams
 202 | Adolph Coors
 303 | Arthur Guinness
(3 rows)

audit=# select * from employeesaudit;
 seq |    date    |         descr          
-----+------------+------------------------
   1 | 2023-04-11 | (101, Samuel Adams)
   2 | 2023-04-11 | (202, Adolph Coors)
   3 | 2023-04-11 | (303, Arthur Guinness)
(3 rows)

*/