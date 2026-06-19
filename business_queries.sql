CREATE DATABASE retail_analysis;
USE retail_analysis;
SHOW DATABASES;

#TOP 10 CUSTOMERS
SELECT CustomerID,
SUM(Quantity* UnitPrice) AS REVENUE 
FROM online_retail
GROUP BY CustomerID
ORDER BY REVENUE DESC
LIMIT 10;

#TOP SELLING PRODUCTS
SELECT Description,
SUM(Quantity) AS TOTALSOLD
FROM online_retail
GROUP BY Description
ORDER BY TOTALSOLD DESC
LIMIT 10;

#REVENUE BY CONTRY
SELECT Country,
ROUND(SUM(Quantity * UnitPrice) ,2) AS REVENUE
FROM online_retail
GROUP BY Country
ORDER BY REVENUE DESC;

#MONTHLY REVENUE TREND 
SELECT 
MONTH(InvoiceDATE) AS MONTH,
ROUND(SUM(Quantity * UnitPrice) ,2) AS REVENUE
FROM online_retail
GROUP BY MONTH
ORDER BY MONTH;

SELECT InvoiceDate
FROM online_retail
LIMIT 10;

#AVERAGE ORDER VALUE
SELECT
AVG(OrderRevenue) AS AvgOrderValue
FROM
(
SELECT InvoiceNo,
SUM(Quantity * UnitPrice) AS OrderRevenue
FROM online_retail
GROUP BY InvoiceNo
) x;

#WINDOW FUNCTION QUERY
SELECT
Description,
SUM(Quantity*UnitPrice) AS Revenue,
RANK() OVER(
ORDER BY SUM(Quantity*UnitPrice) DESC
) AS RevenueRank
FROM online_retail
GROUP BY Description;
#DUPLICATE VALUES
select CustomerID
FROM online_retail
where CustomerID;

select CustomerID,
SUM(CustomerID > 1) AS DUPLICATE_ID
FROM online_retail
GROUP BY CustomerID
ORDER BY DUPLICATE_ID DESC;

#TOTAL REVENUE
SELECT ROUND(SUM(Quantity * UnitPrice),2) AS TotalRevenue
FROM online_retail;

#COUNTRY WITH MORE THAN 10,000 REVENUE
SELECT Country,
SUM(Quantity * UnitPrice) AS Revenue
FROM online_retail
GROUP BY Country
HAVING Revenue > 10000
ORDER BY Revenue DESC;

#CREATING CUSTOMER TABEL
CREATE TABLE customers(
    CustomerID INT,
    CustomerName VARCHAR(50)
);
INSERT INTO customers VALUES(1,"john");
#JOINS
SELECT
    c.CustomerName,
    SUM(r.Quantity * r.UnitPrice) AS Revenue
FROM online_retail r
INNER JOIN customers c
ON r.CustomerID = c.CustomerID
GROUP BY c.CustomerName;

#QUERY OPTIMIZATION
EXPLAIN
SELECT Country,
       SUM(Quantity * UnitPrice)
FROM online_retail
GROUP BY Country;

CREATE INDEX idx_country
ON online_retail(Country);