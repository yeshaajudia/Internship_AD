alter session set "_ORACLE_SCRIPT"=true;

create user c##northwind identified by root;

GRANT CONNECT, RESOURCE, DBA TO c##northwind;