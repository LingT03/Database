-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): 
-- Description: SQL for the In-N-Out Store

DROP DATABASE innout;

CREATE DATABASE innout;

\c innout

-- TODO: table create statements
    CREATE TABLE Customers (
        CustomerID SERIAL PRIMARY KEY,
        CustName VARCHAR(50) NOT NULL,
        Gender CHAR(1) NOT NULL,
    );

    CREATE TABLE Items (
        ItemCode SERIAL PRIMARY KEY,
        Description VARCHAR(50) NOT NULL,
        Price DECIMAL(5,2) NOT NULL,
        CategoryID REFERENCES categories(CategoryID),
    );

    CREATE TABLE Categories (
        Description VARCHAR(50) NOT NULL,
        Category VARCHAR(3) NOT NULL,
    );

    CREATE TABLE Sales (
        SaleID SERIAL PRIMARY KEY,
        CustomerID INT REFERENCES customers(CustomerID),
        ItemCode INT REFERENCES items(ItemCode),
        Quantity INT NOT NULL,
        SaleDate DATE NOT NULL,
        SaleTime TIME NOT NULL,
    );

-- TODO: table insert statements
    INSERT INTO Customers VALUES 
    ('Tim', 'M'),
    ('Sally', 'F'),
    ('Bob', 'M'),
    ('Sue', 'F'),
    ('John', 'M'),
    ('Jane', 'F'),
    ('Fred', 'M'),
    ('Mary', 'F'),
    ('Bill', 'M'),
    ('Alice', 'F');

    INSERT INTO Categories VALUES 
    ('Beverage', 'BVR'),
    ('Dairy', 'DRY'),
    ('Produce', 'PRD'),
    ('Forzen', 'FRZ'),
    ('Bread', 'BKY'),
    ('Meat', 'MEA'),
   
    INSERT INTO Items (description, price, ) VALUES 
    ('Cherrios','1.50', 'PRD'),
    ('Pizza', '5.50', 'FRZ'),
    ('Milk', '3.00', 'DRY'),
    ('Bread', '2.50', 'BKY'),
    ('Chicken', '6.00', 'MEA'),
    ('Coke', '1.50', 'BVR'),
    ('Apple', '1.00', 'PRD'),
    ('Ice Cream', '3.50', 'FRZ'),
    ('Eggs', '2.00', 'DRY'),
    ('Bagel', '1.50', 'BKY'),
    ('Steak', '8.00', 'MEA'),
    ('Sprite', '1.50', 'BVR'),
    ('Banana', '0.50', 'PRD'),
    ('Pineapple', '1.50', 'PRD'),
    ('Frozen Pork', '6.00', 'FRZ'),
    ('Cream', '2.50', 'DRY'),
    ('Pancake', '2.00', 'BKY'),
    ('Rabbit', '8.00', 'MEA'),
    ('Soda', '1.50', 'BVR'),
    ('Kiwi', '1.50', 'PRD'),
    ('Lamb', '8.00', 'MEA'),
    ('Mozzarella', '2.50', 'DRY');

    INSERT INTO Sales (Quantity,SaleDate,SaleTime) VALUES
    ('1','2023-01-01','10:23:00'),
    ('2','2023-01-02','08:30:00'),
    ('1','2023-01-03','09:12:30'),
    ('1','2023-02-04','14:32:00'),
    ('2','2023-02-05','23:30:00'),
    ('1','2023-02-06','15:45:30'),
    ('1','2023-03-07','18:20:00'),
    ('2','2023-03-08','07:30:00'),
    ('1','2023-03-09','01:10:30');

-- TODO: SQL queries

-- a) all customer names in alphabetical order
    SELECT CustName FROM Customers ORDER BY CustName;

-- b) number of items (labeled as total_items) in the database 
    SELECT COUNT(*) AS total_items FROM Items;

-- c) number of customers (labeled as number_customers) by gender
    SELECT COUNT(*) FROM Customers WHERE gender = 'M';

-- d) a list of all item codes (labeled as code) and descriptions (labeled as description) followed by their category descriptions (labeled as category) in numerical order of their codes (items that do not have a category should not be displayed)
    SELECT Items.ItemCode, Items.Description, Categories.Description FROM Items INNER JOIN Categories ON Items.CategoryID = Categories.CategoryID ORDER BY Items.ItemCode;

-- e) a list of all item codes (labeled as code) and descriptions (labeled as description) in numerical order of their codes for the items that do not have a category
    SELECT Items.ItemCode, Items.Description FROM Items WHERE Items.CategoryID IS NULL ORDER BY Items.ItemCode;

-- f) a list of the category descriptions (labeled as category) that do not have an item in alphabetical order
    SELECT Categories.Description FROM Categories WHERE Categories.CategoryID NOT IN (SELECT Items.CategoryID FROM Items);

-- g) set a variable named "ID" and assign a valid customer id to it; then show the content of the variable using a select statement
    SET ID = 1;
    SELECT ID;

-- h) a list describing all items purchased by the customer identified by the variable "ID" (you must used the variable), showing, the date of the purchase (labeled as date), the time of the purchase (labeled as time and in hh:mm:ss format), the item's description (labeled as item), the quantity purchased (labeled as qtt), the item price (labeled as price), and the total amount paid (labeled as total_paid).
    SELECT Sales.SaleDate, Sales.SaleTime, Items.Description, Sales.Quantity, Items.Price, Sales.Quantity * Items.Price AS total_paid FROM Sales INNER JOIN Items ON Sales.ItemCode = Items.ItemCode WHERE Sales.CustomerID = ID;

-- i) the total amount of sales per day showing the date and the total amount paid in chronological order
    SELECT Sales.SaleDate, SUM(Sales.Quantity * Items.Price) AS total_paid FROM Sales INNER JOIN Items ON Sales.ItemCode = Items.ItemCode GROUP BY Sales.SaleDate ORDER BY Sales.SaleDate;

-- j) the description of the top item (labeled as item) in sales with the total sales amount (labeled as total_paid)
    SELECT Items.Description, SUM(Sales.Quantity * Items.Price) AS total_paid FROM Sales INNER JOIN Items ON Sales.ItemCode = Items.ItemCode GROUP BY Items.Description ORDER BY total_paid DESC LIMIT 1;

-- k) the descriptions of the top 3 items (labeled as item) in number of times they were purchased, showing that quantity as well (labeled as total)
    SELECT Items.Description, SUM(Sales.Quantity) AS total FROM Sales INNER JOIN Items ON Sales.ItemCode = Items.ItemCode GROUP BY Items.Description ORDER BY total DESC LIMIT 3;

-- l) the name of the customers who never made a purchase 
    SELECT Customers.CustName FROM Customers WHERE Customers.CustomerID NOT IN (SELECT Sales.CustomerID FROM Sales);