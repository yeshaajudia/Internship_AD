SELECT * FROM members
WHERE last_name = 'Sans';

SELECT * FROM members
WHERE UPPER(last_name) = 'SANS';

EXPLAIN PLAN FOR
SELECT * FROM members
WHERE UPPER(last_name) = 'SANS';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());

CREATE INDEX members_last_name_fi
ON members(UPPER(last_name));

EXPLAIN PLAN FOR
SELECT * FROM members
WHERE UPPER(last_name) = 'SANS';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
