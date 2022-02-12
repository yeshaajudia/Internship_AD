DROP TABLE members;

CREATE TABLE members(
    member_id INT GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    gender CHAR(1) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR2(255) NOT NULL,
    PRIMARY KEY(member_id)
);

SELECT 
    index_name, 
    index_type, 
    visibility, 
    status 
FROM 
    all_indexes
WHERE 
    table_name = 'MEMBERS';

CREATE INDEX members_last_name_i 
ON members(last_name);

SELECT 
    index_name, 
    index_type, 
    visibility, 
    status 
FROM 
    all_indexes
WHERE 
    table_name = 'MEMBERS';

SELECT * FROM members
WHERE last_name = 'Harse';

EXPLAIN PLAN FOR
SELECT * FROM members
WHERE last_name = 'Harse';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());

CREATE INDEX members_name_i
ON members(last_name,first_name);

SELECT * 
FROM members
WHERE last_name LIKE 'A%' 
    AND first_name LIKE 'M%';

EXPLAIN PLAN FOR
SELECT * 
FROM members
WHERE last_name LIKE 'A%' 
    AND first_name LIKE 'M%';
    
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
    