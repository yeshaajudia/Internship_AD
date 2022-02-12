CREATE SEQUENCE item_seq;

SELECT item_seq.NEXTVAL
FROM dual;

SELECT item_seq.CURRVAL
FROM dual;

SELECT item_seq.NEXTVAL
FROM   dual
CONNECT BY level <= 5;

CREATE TABLE items(
    item_id NUMBER
);

INSERT INTO items(item_id) VALUES(item_seq.NEXTVAL);
INSERT INTO items(item_id) VALUES(item_seq.NEXTVAL);

COMMIT;

SELECT item_id FROM items;

SET SERVEROUTPUT ON;

DECLARE
    v_seq NUMBER;
BEGIN
    v_seq  := item_seq.NEXTVAL;
    DBMS_OUTPUT.put_line('v_seq=' || v_seq);
END;

ALTER SEQUENCE item_seq MAXVALUE 100;

DROP SEQUENCE item_seq;