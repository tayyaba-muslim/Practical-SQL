
CREATE DATABASE PRACTICAL;

USE PRACTICAL;

--Create a table named Customers with columns: CustomerID, FirstName, LastName, Email, and PhoneNumber.
CREATE TABLE CUSTOMERS (
CustomerID int not null unique identity,
FirstName varchar(255),
LastName varchar(255),
Email varchar(255),
PhoneNumber varchar(255)
);

--Insert sample data in Customers tables.
insert into CUSTOMERS (FirstName , LastName , Email , PhoneNumber) values('Sawera' , 'Ansari' , 'sawera@gmail.com' , '09999999999'),
('Shahzain' , 'Ali' , 'shah@gmail.com' , '08888888888'),
('Ahmed' , 'Raza' , 'raza@gmail.com' , '07777777777'),
('Midhat' , 'Fatima' , 'mid@gmail.com' , '06666666666'),
('Maha' , 'Noor' , 'maha@gmail.com' , '05555555555'),
('Ayra' , 'Khan' , 'ayra@gmail.com' , '04444444444'),
('Mirha' , 'Hashmi' , 'mirha@gmail.com' , '03333333333'),
('Shibra' , 'Alyan' , 'shib@gmail.com' , '02222222222'),
('Rooh' , 'Sunny' , 'rooh@gmail.com' , '01111111111');

SELECT * FROM CUSTOMERS;

--Create a table named Orders with columns: OrderID, CustomerID, OrderDate, and TotalAmount.
CREATE TABLE ORDERS(
OrderID int not null unique identity,
CustomerID int,
OrderDate date,
TotalAmount int
foreign key (CustomerID) references CUSTOMERS(CustomerID)
);

--Insert sample data in Orders tables.
insert into ORDERS (CustomerID, OrderDate, TotalAmount) values
(8,'2024-1-11',4000),
(2,'2024-2-10',5000),
(3,'2024-2-6',6000),
(4,'2024-2-17',7000),
(5,'2024-1-4',8000),
(6,'2024-3-7',9000),
(7,'2024-2-9',8000),
(8,'2024-2-12',5000),
(9,'2024-1-12',3000),
(7,'2024-1-19',7000),
(1,'2024-3-15',9000);

SELECT * FROM ORDERS;

--Create a table named OrderDetails with columns: OrderDetailID, OrderID, ProductID, Quantity, and UnitPrice.
CREATE TABLE ORDERDETAILS(
OrderDetailID int not null unique Identity,
OrderId int,
ProductID int,
Quantity int,
UnitPrice decimal(6)
foreign key (OrderID) references ORDERS(OrderID),
foreign key (ProductID) references PRODUCTS(ProductID)
);

SELECT * FROM ORDERDETAILS;

--Create a table named Products with columns: ProductID, ProductName, UnitPrice, and InStockQuantity.
CREATE TABLE PRODUCTS(
ProductID int not null unique identity,
ProductName Varchar(255),
UnitPrice varchar(255),
InstockQuantity int
);

--Insert sample data in Products tables.
insert into PRODUCTS (ProductName, UnitPrice, InstockQuantity) values
('Ponds','3000',2),
('Perfume','4000',4),
('Flowers','3000',9),
('Mobile','4500',5),
('Watches','3000',7),
('Bike','8000',8),
('Cars','3300',6),
('Smart Watches','4000',4),
('Rings','9000',2),
('Earbuds','35500',9);

SELECT * FROM PRODUCTS;

--1) Create a new user named Order_Clerk with permission to insert new orders and update order details in the Orders and OrderDetails tables.
create login Sawera with Password ='Sawera'

create user Order_Clerk for Login Sawera
GO
grant insert,update on dbo.ORDERS to Order_Clerk
grant insert,update on dbo.ORDERDETAILS to Order_Clerk

--2) Create a trigger named Update_Stock_Audit that logs any updates made to the InStockQuantity column of the Products table into a Stock_Update_Audit table.
CREATE trigger update_Stock_Audit on PRODUCTS 
for Update
as
begin 
print 'someone trying to update'
end

update PRODUCTS SET InStockQuantity ='5' where ProductID = 2;

--3) Write a SQL query that retrieves the FirstName, LastName, OrderDate, and TotalAmount of orders along with the customer details by joining the Customers and Orders tables.

SELECT Cus.FirstName , Cus.LastName , Ord.OrderDate , Ord.TotalAmount FROM CUSTOMERS AS Cus join ORDERS AS Ord ON Cus.CustomerID = Ord.CustomerID;

--4) Write a SQL query that retrieves the ProductName, Quantity, and TotalPrice of products ordered in orders with a total amount greater than the average total amount of all orders.
SELECT Pro.ProductName, Od.Quantity, Od.Quantity * Pro.UnitPrice AS TotalPrice FROM Orders Ord JOIN OrderDetails Od ON Ord.OrderID = Od.OrderID 
JOIN Products Pro ON Od.ProductID = Pro.ProductID WHERE Ord.TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);

--5) Create a stored procedure named GetOrdersByCustomer that takes a CustomerID as input and returns all orders placed by that customer along with their details:
CREATE PROCEDURE GetOrdersByCustomer 
@CustomerID INT
AS
BEGIN
SELECT *FROM Orders WHERE CustomerID = @CustomerID;
END;
EXEC GetOrdersByCustomer @CustomerID = 4;

--6) Create a view named OrderSummary displaying OrderID, OrderDate, CustomerID, and TotalAmount from the Orders table:
CREATE VIEW OrderSummary 
AS
SELECT OrderID, OrderDate, CustomerID, TotalAmount FROM Orders;

SELECT * FROM OrderSummary;

--7) Create a view named ProductInventory showing ProductName and InStockQuantity from the Products table:
CREATE VIEW ProductInventory AS
SELECT ProductName, InStockQuantity FROM PRODUCTS;

SELECT * FROM ProductInventory;

--8) Join OrderSummary view with Customers table to retrieve customer's first name and last name along with their order details:
SELECT Ord.OrderID, Ord.OrderDate, Ord.CustomerID, Ord.TotalAmount, Cus.FirstName, Cus.LastName FROM ORDERS Ord JOIN Customers Cus ON Ord.CustomerID = Cus.CustomerID;















