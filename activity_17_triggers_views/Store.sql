CREATE DATABASE Store;

CREATE TABLE Orders (
    number INT Primary Key,
    date DATE NOT NULL,
);

INSERT INTO Orders VALUES 
(101, '2023-01-01'),
(102, '2023-02-03'),
(103, '2023-03-02');


CREATE TABLE Items (
    order_number INT NOT NULL,
    product_id INT NOT NULL,
    qtt INT NOT NULL,
    PRIMARY KEY (order_number, product_id),
    FOREIGN KEY (order_number) REFERENCES Orders(number),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

INSERT INTO Items VALUES 
(101, 1, 2),
(101, 2, 1),
(102, 1, 1),
(102, 2, 2),
(103, 1, 3),
(103, 2, 1);

CREATE TABLE Products (
    id Serial Primary Key,
    descr VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
);

INSERT INTO Products VALUES 
('Ninja Sword', 250.00),
('Dummy', 50.00),
('Fake Blood', 5.00),
('Rubber Ducky', 1.00),
('Bathtub Soap', 3.00)
('Brazilian Coffee', 5.00)
('Running Shoes', 50.00);