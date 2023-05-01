-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: Ling Thang
-- Description: Exam 2 Take Home

CREATE DATABASE exam2;

\c exam2

-- QUESTION 1 
    CREATE TABLE Cars(
        Plate_Number VARCHAR(8) PRIMARY KEY,
        Car_type VARCHAR(20) NOT NULL,
        Base_rent INT NOT NULL 
    );

    INSERT INTO Cars VALUES 
    ('XYZ-123', 'Sedan', 40),
    ('ZZW-444', 'SUV', 60),
    ('KKK-001', 'SUV', 60);

    /*
        exam2=# SELECT * FROM cars;
        plate_number | car_type | base_rent 
        --------------+----------+-----------
        XYZ-123      | Sedan    |        40
        ZZW-444      | SUV      |        60
        KKK-001      | SUV      |        60
        (3 rows)
    */

    CREATE TABLE Customers(
        Cust_id INT PRIMARY KEY,
        Cust_name VARCHAR(20) NOT NULL
    );

    INSERT INTO Customers VALUES
    (101, 'Sam'),
    (202,'Jill');

    /*
        exam2=# SELECT * FROM customers;
        cust_id | cust_name 
        ---------+-----------
            101 | Sam
            202 | Jill
        (2 rows)
    */

    Create TABLE Features(
        Feature_id INT PRIMARY KEY,
        Feature_descr VARCHAR(20) NOT NULL,
        Feature_price INT NOT NULL
    );

    INSERT INTO Features VALUES
    (1, 'gps', 10),
    (2, 'full tank', 40),
    (3, 'ezpass', 15),
    (4, 'self-driving', 200);

    /*
        exam2=# SELECT * FROM features;
        feature_id | feature_descr | feature_price 
        ------------+---------------+---------------
                1 | gps           |            10
                2 | full tank     |            40
                3 | ezpass        |            15
                4 | self-driving  |           200
        (4 rows)
    */

    CREATE TABLE Rentals(
        Plate_Number VARCHAR(8),
        Cust_id INT,
        date_rental DATE NOT NULL,
        Feature_id INT,
        FOREIGN KEY (Plate_Number) REFERENCES Cars(Plate_Number),
        FOREIGN KEY (Cust_id) REFERENCES Customers(Cust_id),
        FOREIGN KEY (Feature_id) REFERENCES Features(Feature_id)
    );

    INSERT INTO Rentals (Plate_Number, Cust_id, date_rental, Feature_id) VALUES
       ('XYZ-123', 101, '2023-01-01', 1),
       ('XYZ-123', 101, '2023-01-01', 2),
       ('XYZ-123', 101, '2023-01-01', 3),
       ('ZZW-444', 202, '2023-01-02', 1),
       ('KKK-001', 101, '2023-03-05', 1),
       ('KKK-001', 101, '2023-02-05', 2),
       ('KKK-001', 101, '2023-02-05', 4);

    /*
        exam2=# SELECT * FROM rentals;
        plate_number | cust_id | date_rental | feature_id 
        --------------+---------+-------------+------------
        XYZ-123      |     101 | 2023-01-01  |          1
        XYZ-123      |     101 | 2023-01-01  |          2
        XYZ-123      |     101 | 2023-01-01  |          3
        ZZW-444      |     202 | 2023-01-02  |          1
        KKK-001      |     101 | 2023-03-05  |          1
        KKK-001      |     101 | 2023-02-05  |          2
        KKK-001      |     101 | 2023-02-05  |          4
        (7 rows)
    */

-- QUESTION 2
    CREATE TABLE Employees (
        ssn INT PRIMARY KEY,
        name TEXT NOT NULL,
        sal DECIMAL (10,2) NOT NULL,
        sup INT,
        FOREIGN KEY (sup) REFERENCES Employees(ssn)
    );

    INSERT INTO Employees VALUES 
    (123456, 'Joe', 65.00, NULL),
    (456789, 'Marta', 75.00, NULL);

    -- Create trigger function doit 
        CREATE FUNCTION doit() RETURNS trigger 
        LANGUAGE plpgsql
        AS $$
            DECLARE sup_sal DECIMAL (10,2);
            BEGIN
                sup_sal:= (SELECT sal FROM Employees WHERE ssn = NEW.sup);
                IF NEW.sup IS NOT NULL AND NEW.sal > sup_sal THEN 
                    NEW.sal = sup_sal;
                END IF;
                RETURN NEW;
            END;
        $$;
    -- Create tirgger trigger_doit
        CREATE TRIGGER trigger_doit
        BEFORE INSERT OR UPDATE ON Employees
        FOR EACH ROW
        EXECUTE PROCEDURE doit();

    /* Query 

    INSERT INTO Employees VALUES (678901, 'Paul', 90, 456789);
    
        SELECT * FROM employees;
        
        ssn   | name  |  sal  |  sup   
        --------+-------+-------+--------
        123456 | Joe   | 65.00 |       
        456789 | Marta | 75.00 |       
        678901 | Paul  | 75.00 | 456789

    */

-- QUESTION 3
    -- Create and populate table Visitors
    CREATE TABLE Visitors (
        id SERIAL PRIMARY KEY,
        date_time TIMESTAMP NOT NULL,
        floor INT NOT NULL,
        left_building BOOLEAN
    );

INSERT INTO Visitors (date_time, floor, left_building) VALUES
    ('2023-04-01 10:00:00', 5, false),
    ('2023-04-01 10:15:00', 3, true),
    ('2023-04-01 10:15:00', 3, true),
    ('2023-04-01 11:15:00', 2, false),
    ('2023-04-01 13:15:00', 3, true),
    ('2023-04-02 07:15:00', 6, true),
    ('2023-04-02 09:15:00', 1, false);


    -- SQL Statements 

    -- A)
        SELECT COUNT(id) AS Visitors FROM Visitors;
        /* 
        visitors 
        ----------
                7
        (1 row) 
        */

    -- B)
        SELECT DATE(date_time) AS day, COUNT(ID) AS Visitors
        FROM Visitors
        GROUP BY 1
        ORDER BY 1;
        /* 
            day     | visitors 
        ------------+----------
         2023-04-01 |        5
         2023-04-02 |        2
        (2 rows)
        */

    -- C)
        SELECT COUNT(left_building) AS Visitors_still_in_building
        FROM Visitors
        WHERE left_building = 'false' AND 
        DATE(date_time) = '2023-04-02';
        /* 
        visitors_still_in_building 
        ----------------------------
                    1
        (1 row)
        */

-- QUESTION 4
    -- Create and populate tables Specialties
    CREATE TABLE Specialties (
      Specialty INT PRIMARY KEY,
      descr VARCHAR(50)
    );

    INSERT INTO Specialties VALUES
    (101, 'revivification'),
    (202, 'time travelling'),
    (303, 'head Transplantation');

    -- Create and populate table MadScientists
    CREATE TABLE MadScientists (
      id SERIAL PRIMARY KEY,
      name VARCHAR(50) NOT NULL,
      specialty INT,
      FOREIGN KEY (specialty) REFERENCES Specialties(Specialty)
    );

    INSERT INTO MadScientists VALUES
    (1, 'Victor Frankenstein', 101),
    (2, 'Emmett Brown', 202),
    (3, 'The Brain', NULL);

    -- A) display the names of the mad scientists and their specialties
        SELECT A.name, B.descr FROM MadScientists A
        LEFT JOIN Specialties B ON A.specialty = B.Specialty
        ORDER BY A.name;
        /*
                name         |      descr      
        ---------------------+-----------------
        Emmett Brown         | time travelling
        The Brain            | 
        Victor Frankenstein  | revivification
        (3 rows)
        */

    -- B) display the names of the mad scientists who do not have a specialty
        SELECT A.name, B.specialty FROM MadScientists A
        LEFT JOIN Specialties B ON A.specialty = B.Specialty
        WHERE B.specialty IS NULL;
        /*
        name       | specialty 
        -----------+-----------
        The Brain  |          
        (1 row)
        */

    -- C) Perform a FULL OUTER JOIN on the two tables by connecting them by the specialty attribute. 
        SELECT A.name, B.descr FROM MadScientists A
        FULL OUTER JOIN Specialties B ON A.specialty = B.Specialty
        ORDER BY A.name;
        /*
                name         |        descr         
        ---------------------+----------------------
        Emmett Brown         | time travelling
        The Brain            | 
        Victor Frankenstein  | revivification
                             | head Transplantation
        (4 rows)
        */