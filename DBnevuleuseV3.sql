/*DROP TABLE  Customer_payments CASCADE;
DROP TABLE  Customers CASCADE;
DROP TABLE  Sales CASCADE;
DROP TABLE  Order_payements CASCADE;
DROP TABLE  Orders CASCADE;
DROP TABLE  Suppliers CASCADE;
DROP TABLE  OrderLines CASCADE;
DROP TABLE  RawMaterials CASCADE;
DROP TABLE  RawMaterialResources CASCADE;
DROP TABLE  Raw_steps CASCADE;
DROP TABLE  Steps CASCADE;
DROP TABLE  Production_steps CASCADE;
DROP TABLE  Production_lines CASCADE;
DROP TABLE  Beers CASCADE;
DROP TABLE  Batchs CASCADE;
DROP TABLE  Sold_products CASCADE; */
-- SALES --


CREATE TABLE Customers
(
customer_id int NOT NULL,
firstName VARCHAR (20),
lastName VARCHAR (20),
adresse VARCHAR (20),
city VARCHAR (20),
email VARCHAR (20),
phone VARCHAR (20),
PRIMARY KEY (customer_id)
);

CREATE TABLE Sales
(
sale_id int NOT NULL,
quantity int,
sale_unit VARCHAR (20),
sale_date VARCHAR (20),
employee_id VARCHAR (20),
customer_id int NOT NULL,
PRIMARY KEY (sale_id),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Customer_payments
(
customer_payment_id int NOT NULL,
payment_date DATE,
amount int,
currency VARCHAR (20),
sale_id int NOT NULL, 
PRIMARY KEY (customer_payment_id),
FOREIGN KEY (sale_id) REFERENCES Sales(sale_id)
);

CREATE TABLE Beers
(
beer_id int NOT NULL UNIQUE,
batch_id int NOT NULL UNIQUE,
quantity VARCHAR (20),
beer_name  VARCHAR (20),
PRIMARY KEY (beer_id,batch_id)
);              

CREATE TABLE Sold_products
(
sale_id int NOT NULL,
payment_date DATE,
amount int,
currency VARCHAR (20),
beer_id int NOT NULL,
batch_id int NOT NULL,
price DECIMAL(5,2),
FOREIGN KEY (sale_id) REFERENCES Sales(sale_id),
FOREIGN KEY (beer_id) REFERENCES Beers(beer_id),
FOREIGN KEY (batch_id) REFERENCES Beers(batch_id),
PRIMARY KEY (sale_id,beer_id,batch_id)
);

CREATE TABLE Production_lines
(
production_line_id int NOT NULL,
liters integer,
PRIMARY KEY (production_line_id)
);

CREATE TABLE batchs
(
batch_id int NOT NULL,
production_line_id int NOT NULL,
start_date DATE,
end_date DATE,
expiration DATE, -- on pourrait mettre le nb de jour avnat la perenption
PRIMARY KEY (batch_id),
FOREIGN KEY (production_line_id) REFERENCES Production_lines(production_line_id)
);

CREATE TABLE Steps
(
step_id int NOT NULL,
duration integer,
equiment VARCHAR (20),
wast VARCHAR (20),
prob1 VARCHAR (20),
prob2 VARCHAR (20),
employee1 VARCHAR (20),
employee2 VARCHAR (20),
PRIMARY KEY (step_id)
);

CREATE TABLE Production_steps
(
production_line_id int NOT NULL,
step_id int NOT NULL,
PRIMARY KEY (production_line_id,step_id),
FOREIGN KEY (production_line_id) REFERENCES Production_lines(production_line_id),
FOREIGN KEY (step_id) REFERENCES Steps(step_id)

);

CREATE TABLE RawMaterials
(
rawMaterial_id int NOT NULL,
quantity VARCHAR (20),
raw_unit VARCHAR (20),
expirationDate DATE,
status VARCHAR (20),
unit VARCHAR (20),
PRIMARY KEY (rawMaterial_id)
);

CREATE TABLE Orders
(
order_id int NOT NULL,
order_date DATE,
delivery_date DATE,
quantity int,
status VARCHAR (20),
order_unit VARCHAR (20),
employee_1 VARCHAR (20),
PRIMARY KEY (order_id)

);

CREATE TABLE Suppliers
(
supplier_id int NOT NULL,
compagnyName VARCHAR (20),
firstName VARCHAR (20),
lastName VARCHAR (20),
adresse VARCHAR (20),
city VARCHAR (20),
email VARCHAR (20),
phone VARCHAR (20),
PRIMARY KEY (supplier_id)
);

CREATE TABLE Order_payments
(
order_payment_id int NOT NULL,
payment_date DATE,
amount int,
currency VARCHAR (20),
order_id int NOT NULL,
supplier_id int NOT NULL,
PRIMARY KEY (order_payment_id),
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

CREATE TABLE OrderLines
(
order_id int NOT NULL,
rawMaterial_id int NOT NULL,
price int,
quantity int,
PRIMARY KEY (order_id),
FOREIGN KEY (rawMaterial_id) REFERENCES RawMaterials(rawMaterial_id),
FOREIGN KEY (order_id) REFERENCES Orders(order_id)

);


CREATE TABLE RawMaterialResources
(
rawMaterialResource_id int NOT NULL,
rawMaterial_id int NOT NULL,
quantity VARCHAR (20),
unit VARCHAR (20),
PRIMARY KEY (rawMaterialResource_id),
FOREIGN KEY (rawMaterial_id) REFERENCES RawMaterials(rawMaterial_id)
);


CREATE TABLE Raw_steps
(
rawMaterialResource_id int NOT NULL,
step_id int NOT NULL,
PRIMARY KEY (rawMaterialResource_id,step_id),
FOREIGN KEY (rawMaterialResource_id) REFERENCES rawMaterialResources(rawMaterialResource_id),
FOREIGN KEY (step_id) REFERENCES steps(step_id)
);


