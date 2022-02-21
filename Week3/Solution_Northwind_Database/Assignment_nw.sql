@D:\Training\Internship_AD\Week3\Solution_Northwind_Database\CreateObjects.sql;

@D:\Training\Internship_AD\Week3\Solution_Northwind_Database\InsertData.sql;

SET SERVEROUTPUT ON;

--1. Get a list of latest order IDs for all customers by using the max function on Order_ID column.
SELECT 
    MAX(orderid) AS latest_orderid, customerid
FROM 
    orders
GROUP BY 
    customerid;

--2. Find suppliers who sell more than one product to Northwind Trader.
SELECT 
    s.supplierid, s.companyname, q.no_products 
FROM 
    suppliers s, (SELECT 
                      supplierid, COUNT(productid) AS no_products 
                  FROM 
                      products 
                  GROUP BY 
                      supplierid) q
WHERE 
    s.supplierid=q.supplierid AND no_products>1;

--3. Create a function to get latest order date for entered customer_id
CREATE OR REPLACE FUNCTION get_latest_order_date(p_customer_id orders.customerid%TYPE)
RETURN orders.orderdate%TYPE
AS
    v_latest_order_date orders.orderdate%TYPE;
BEGIN
    SELECT 
        MAX(orderdate) 
    INTO 
        v_latest_order_date
    FROM 
        orders
    WHERE 
        customerid=p_customer_id;
    RETURN v_latest_order_date;
END;

DECLARE
    v_customerid orders.customerid%TYPE:=&customer_id;
    v_order_date orders.orderdate%TYPE;
BEGIN
    v_order_date:=get_latest_order_date(v_customerid);
    DBMS_OUTPUT.PUT_LINE('For customer id= '||v_customerid||', latest orderdate is: '||v_order_date);
END;

--4. Get the top 10 most expensive products.
SELECT 
    productname, unitprice
FROM
    (SELECT 
        productname, unitprice
    FROM 
        products
    ORDER BY 
        unitprice DESC)
WHERE ROWNUM<11;

--OR--

SELECT 
    productname, unitprice
FROM 
    products
ORDER BY 
    unitprice DESC
FETCH FIRST 10 ROWS ONLY;

--5. Rank products by the number of units in stock in each product category.
SELECT 
    p.productname, p.unitsinstock, c.categoryname, DENSE_RANK() OVER(
                                                            PARTITION BY c.categoryname
                                                            ORDER BY p.unitsinstock) AS rank
FROM 
    products p, categories c
WHERE 
    c.categoryid=p.categoryid AND p.discontinued=0;

--6. Rank customers by the total sales amount within each order date
SELECT 
    c.companyname, SUM(od.unitprice * od.quantity * (1 - od.discount)) AS total_sales, o.orderdate, DENSE_RANK() OVER(
                                                                                                                    PARTITION BY o.orderdate
                                                                                                                    ORDER BY SUM(od.unitprice * od.quantity * (1 - od.discount))) AS rank
FROM
    customers c, orderdetails od, orders o
WHERE
    od.orderid=o.orderid AND o.customerid=c.customerid
GROUP BY 
    o.orderdate, c.companyname;

--7. For each order, calculate a subtotal for each Order (identified by OrderID).
SELECT 
    orderid, sum(unitprice * quantity * (1 - discount)) AS subtotal 
FROM 
    orderdetails
GROUP BY 
    orderid
ORDER BY 
    orderid;

--8. Sales by Year for each order. Hint: Get 
--Subtotal as sum(UnitPrice * Quantity * (1 - Discount)) for every order_id then join with orders 
--table
SELECT 
    o.orderid, d.subtotal, o.shippeddate, EXTRACT(Year FROM shippeddate) AS ship_year
FROM
    (SELECT 
        orderid, SUM(unitprice * quantity * (1 - discount)) AS subtotal 
    FROM 
        orderdetails
    GROUP BY    
        orderid) d
    JOIN
        orders o
    ON 
        o.orderid=d.orderid
ORDER BY 
    shippeddate;

--9. Get Employee sales by country names
SELECT 
    e.country, e.lastname, e.firstname, o.shippeddate, o.orderid, SUM(od.unitprice * od.quantity * (1 - od.discount)) AS sale_amount
FROM 
    employees e, orders o, orderdetails od
WHERE 
    o.orderid=od.orderid AND e.employeeid=o.employeeid
GROUP BY 
    e.country, e.lastname, e.firstname, o.shippeddate, o.orderid
ORDER BY 
    lastname;

--10. Alphabetical list of products
SELECT 
    productid, productname, supplierid, categoryid, quantityperunit, unitprice
FROM 
    products
WHERE 
    discontinued=0
ORDER BY 
    productname;

--11. Display the current Productlist 
--Hint: Discontinued=’N’
SELECT 
    productid, productname 
FROM 
    products
WHERE 
    discontinued=0
ORDER BY 
    productname;

--12. Calculate sales price for each order after discount is applied.
SELECT 
    od.orderid, p.productid, p.productname, od.unitprice, od.quantity, od.discount, (od.unitprice * od.quantity * (1 - od.discount)) AS extendedprice
FROM 
    orderdetails od, products p
WHERE
    od.productid=p.productid;

--13. Sales by Category: For each category, we get the list of products sold and the total sales amount.
SELECT 
    c.categoryid, c.categoryname, p.productname, SUM(od.unitprice * od.quantity * (1 - od.discount)) AS productsales
FROM 
    categories c, products p, orderdetails od 
WHERE 
    c.categoryid=p.categoryid AND od.productid=p.productid 
GROUP BY 
    c.categoryid, c.categoryname, p.productname
ORDER BY 
    c.categoryid, p.productname;

--14. Create below views:
--1. Displays products(productname,unitprice) who’s price is greater than 
--avg(price)
CREATE VIEW vwProducts_Above_Average_Price
AS
SELECT 
    productname, unitprice
FROM 
    products
WHERE 
    unitprice>(SELECT 
                   AVG(unitprice) 
               FROM 
                   products)
ORDER BY 
    unitprice;

SELECT * FROM vwProducts_Above_Average_Price;

--2. Display product(productname), customers(companyname), orders(orderyear)
CREATE VIEW vwQuarterly_Orders_by_Product
AS
SELECT 
    p.productname, c.companyname, EXTRACT (Year FROM o.orderdate) AS orderyear
FROM 
    products p, customers c, orders o, orderdetails od
WHERE 
    c.customerid=o.customerid AND o.orderid=od.orderid AND od.productid=p.productid
ORDER BY 
    c.companyname, p.productname;

SELECT * FROM vwQuarterly_Orders_by_Product;

--3. Display Supplier Continent wise sum of unitinstock.
--'Europe'= ('UK','Spain','Sweden','Germany','Norway', 'Denmark','Netherlands','Finland','Italy','France')
--'America'= 'USA','Canada','Brazil' and 'Asia-Pacific'
CREATE VIEW vwUnitsInStock
AS
SELECT 
    sup.supplier_continent, SUM(p.unitsinstock) AS continent_sum
FROM 
    products p, (SELECT s.supplierid, 
                    CASE
                        WHEN s.country IN ('UK','Spain','Sweden','Germany','Norway', 'Denmark','Netherlands','Finland','Italy','France')
                            THEN 'Europe'
                        WHEN s.country IN ('USA','Canada','Brazil', 'Asia-Pacific')
                            THEN 'America'
                        WHEN s.country NOT IN ('UK','Spain','Sweden','Germany','Norway', 'Denmark','Netherlands','Finland','Italy','France', 'USA','Canada','Brazil', 'Asia-Pacific')
                            THEN 'Others'
                        END AS supplier_continent 
                  FROM suppliers s) sup
WHERE 
    sup.supplierid=p.supplierid
GROUP BY 
    sup.supplier_continent;

SELECT * FROM vwUnitsInStock;

--4. Display top 10 expensive products
CREATE VIEW vw10Most_Expensive_Products
AS
SELECT 
    productname, unitprice
FROM 
    products
ORDER BY 
    unitprice DESC
FETCH FIRST 10 ROWS ONLY;

SELECT * FROM vw10Most_Expensive_Products;

--5. Display customer supplier by city
CREATE VIEW vwCustomer_Supplier_by_City
AS
(SELECT companyname, city, contactname, 'Customers' AS relationship
FROM customers)
UNION 
(SELECT companyname, city, contactname, 'Suppliers' AS relationship
FROM suppliers) 
ORDER BY city;

SELECT * FROM vwCustomer_Supplier_by_City;