CREATE VIEW customer_category_sales AS
SELECT 
    category_name category, 
    customers.name customer, 
    SUM(quantity*unit_price) sales_amount
FROM 
    orders
    INNER JOIN customers USING(customer_id)
    INNER JOIN order_items USING (order_id)
    INNER JOIN products USING (product_id)
    INNER JOIN product_categories USING (category_id)
WHERE 
    customer_id IN (1,2)
GROUP BY 
    category_name, 
    customers.name;

SELECT 
    customer, 
    category, 
    sales_amount 
FROM 
    customer_category_sales
ORDER BY
    customer,
    category;

--(category)
SELECT 
    category, 
    SUM(sales_amount) 
FROM 
    customer_category_sales
GROUP BY 
    category;

--(customer)
SELECT 
    customer, 
    SUM(sales_amount)
FROM 
    customer_category_sales
GROUP BY 
    customer;    

--(category, customer)
SELECT 
    customer, 
    category, 
    sales_amount 
FROM 
    customer_category_sales
ORDER BY
    customer,
    category;

--()
SELECT 
    SUM(sales_amount)
FROM 
    customer_category_sales;

--the UNION ALL operator requires all involved queries return the same number of columns. 
--Therefore, to make it works, you need to add NULL to the select list of each query
SELECT 
    category, 
    NULL,
    SUM(sales_amount) 
FROM 
    customer_category_sales
GROUP BY 
    category
UNION ALL    
SELECT 
    customer,
    NULL,
    SUM(sales_amount)
FROM 
    customer_category_sales
GROUP BY 
    customer
UNION ALL
SELECT 
    customer, 
    category, 
    sum(sales_amount)
FROM 
    customer_category_sales
GROUP BY 
    customer,
    category
UNION ALL   
SELECT
    NULL,
    NULL,
    SUM(sales_amount)
FROM 
    customer_category_sales;

SELECT 
    customer, 
    category,
    SUM(sales_amount)
FROM 
    customer_category_sales
GROUP BY 
    GROUPING SETS(
        (customer,category),
        (customer),
        (category),
        ()
    )
ORDER BY 
    customer, 
    category;     

SELECT 
    customer, 
    category,
    GROUPING(customer) customer_grouping,
    GROUPING(category) category_grouping,
    SUM(sales_amount) 
FROM customer_category_sales
GROUP BY 
    GROUPING SETS(
        (customer,category),
        (customer),
        (category),
        ()
    )
ORDER BY 
    customer, 
    category;

SELECT 
    DECODE(GROUPING(customer),1,'ALL customers', customer) customer,
    DECODE(GROUPING(category),1,'ALL categories', category) category,
    SUM(sales_amount) 
FROM 
    customer_category_sales
GROUP BY 
    GROUPING SETS(
        (customer,category),
        (customer),
        (CATEGORY),
        ()
    )
ORDER BY 
    customer, 
    category;

SELECT 
    customer, 
    category,
    GROUPING_ID(customer,category) grouping,
    SUM(sales_amount) 
FROM customer_category_sales
GROUP BY 
    GROUPING SETS(
        (customer,category),
        (customer),
        (category),
        ()
    )
ORDER BY 
    customer, 
    category;
