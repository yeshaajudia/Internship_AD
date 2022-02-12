SELECT 
    *
FROM
    members
WHERE
    gender = 'F';

CREATE BITMAP INDEX members_gender_i
ON members(gender);

EXPLAIN PLAN FOR 
SELECT 
    *
FROM
    members
WHERE
    gender = 'F';
    
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());      

CREATE TABLE bitmap_index_demo(
    id INT GENERATED BY DEFAULT AS IDENTITY,
    active NUMBER NOT NULL,
    PRIMARY KEY(id)
);

CREATE BITMAP INDEX bitmap_index_demo_active_i
ON bitmap_index_demo(active);

INSERT INTO bitmap_index_demo(active) 
VALUES(1);