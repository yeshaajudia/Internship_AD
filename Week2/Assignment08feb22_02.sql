CREATE UNIQUE INDEX members_email_i
ON members(email);

INSERT INTO members(first_name, last_name, gender, dob, email)
VALUES('Pegpa','Elce','F',DATE '1990-01-02','pelce0@trellian.com');

CREATE TABLE unq_idx_demo(
    a INT,
    b INT
);   

CREATE UNIQUE INDEX unq_idx_demo_ab_i
ON unq_idx_demo(a,b);

INSERT INTO unq_idx_demo(a,b)
VALUES(1,1);

INSERT INTO unq_idx_demo(a,b)
VALUES(1,2);

INSERT INTO unq_idx_demo(a,b)
VALUES(1,1);

CREATE TABLE t1 (
    pk1 INT PRIMARY KEY,
    c1 INT
);

SELECT 
    index_name, 
    index_type, 
    visibility, 
    status 
FROM 
    all_indexes
WHERE 
    table_name = 'T1';

CREATE TABLE t2 (
    pk2 INT PRIMARY KEY 
        USING INDEX (
            CREATE INDEX t1_pk1_i ON t2 (pk2)
    ),
    c2 INT
);

SELECT 
    index_name, 
    index_type, 
    visibility, 
    status 
FROM 
    all_indexes
WHERE 
    table_name = 'T2';
