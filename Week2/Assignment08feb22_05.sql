SELECT
    product_name,
    quantity
FROM
    inventories
INNER JOIN products
        USING(product_id)
ORDER BY
    quantity DESC 
FETCH NEXT 5 ROWS ONLY;

SELECT
    product_name,
    quantity
FROM
    inventories
INNER JOIN products
        USING(product_id)
ORDER BY
    quantity DESC 
FETCH NEXT 10 ROWS ONLY;

SELECT
	product_name,
	quantity
FROM
	inventories
INNER JOIN products
		USING(product_id)
ORDER BY
	quantity DESC 
FETCH NEXT 10 ROWS WITH TIES;

SELECT
    product_name,
    quantity
FROM
    inventories
INNER JOIN products
        USING(product_id)
ORDER BY
    quantity DESC 
FETCH FIRST 5 PERCENT ROWS ONLY;

SELECT
	product_name,
	quantity
FROM
	inventories
INNER JOIN products
		USING(product_id)
ORDER BY
	quantity DESC 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;