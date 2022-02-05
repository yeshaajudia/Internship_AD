SELECT 
    empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM 
    emp;

-- ##############################################################
    
SELECT DISTINCT 
    job 
FROM 
    emp;

-- ##############################################################
    
SELECT 
    empno, ename, sal
FROM 
    emp
ORDER BY
    sal;
    
-- ##############################################################    
    
SELECT 
    empno, ename, deptno, job
FROM 
    emp
ORDER BY
    deptno, job DESC;
    
-- ##############################################################    

SELECT 
    DISTINCT job
FROM 
    emp
ORDER BY
    job DESC;
    
-- ##############################################################    

SELECT 
    empno, ename, job, mgr, hiredate, sal, comm, deptno 
FROM 
    emp
WHERE
    job = 'MANAGER';
    
-- ##############################################################   

SELECT 
    empno, ename, hiredate
FROM 
    emp
WHERE
    hiredate < (to_date('01-01-1981','dd-mm-yy'));
    
-- ##############################################################    

SELECT 
    empno, ename, sal, ROUND(sal/30,2) AS daily_sal
FROM 
    emp
ORDER BY
    sal*30;
    
-- ##############################################################    

SELECT 
    empno, ename, job, hiredate, ROUND((sysdate-hiredate)/365) AS exp
FROM 
    emp
WHERE
    job = 'MANAGER' OR empno IN (SELECT mgr FROM emp);  
    
-- ##############################################################    

SELECT 
    empno, ename, sal, ROUND((sysdate-hiredate)/365) AS exp
FROM 
    emp
WHERE
    mgr=7369;  
    
-- ##############################################################  

SELECT 
    empno, ename, job, mgr, hiredate, sal, comm, deptno, branchno
FROM 
    emp
WHERE
    comm > sal;  
    
-- ##############################################################    

SELECT 
    empno, ename, ROUND((sysdate-hiredate)/365) AS exp, ROUND(sal/30,2) AS daily_sal
FROM 
    emp
WHERE
    ROUND(sal/30,2)>100;  
    
-- ##############################################################  

SELECT 
    empno, ename, job
FROM 
    emp
WHERE
    job IN ('CLERK', 'ANALYST')
ORDER BY
    job DESC;
    
-- ##############################################################  

SELECT 
    empno, ename, hiredate, ROUND((sysdate-hiredate)/365) AS exp
FROM 
    emp
WHERE
    hiredate IN ('01-05-81', '03-12-81', '17-12-81', '19-01-80')
ORDER BY
    exp;
    
-- ##############################################################  

SELECT 
    empno, ename, deptno
FROM 
    emp
WHERE
    deptno=10 OR deptno=20;
    
-- ##############################################################  

SELECT 
    empno, ename, hiredate
FROM 
    emp
WHERE
    EXTRACT(Year FROM hiredate)=1981;

-- ##############################################################  

SELECT 
    empno, ename, sal, (sal*12) AS annsal
FROM 
    emp  
WHERE
    (sal*12)>22000 AND (sal*12)<45000;

-- ##############################################################  

SELECT 
    empno, ename
FROM 
    emp
WHERE
    LENGTH(ename)=5;
    
-- ##############################################################  

SELECT 
    empno, ename
FROM 
    emp
WHERE
    ename LIKE 'S%' AND LENGTH(ename)=5;
    
-- ##############################################################  

SELECT 
    empno, ename
FROM 
    emp
WHERE
    LENGTH(ename)=4 AND ename LIKE '__R%'; 

-- ##############################################################  

SELECT 
    empno, ename
FROM 
    emp
WHERE
    LENGTH(ename)=5 AND ename LIKE 'S%H'; 
    
-- ##############################################################  

SELECT 
    empno, ename, hiredate
FROM 
    emp
WHERE
    EXTRACT(Month FROM hiredate)=01;   
    
-- ##############################################################  

SELECT 
    empno, ename
FROM 
    emp
WHERE
    ename LIKE '%LL%';       
    
-- ##############################################################  

SELECT 
    empno, ename, deptno
FROM 
    emp
WHERE
    deptno NOT IN 20;       
    
-- ##############################################################  

SELECT 
    empno, ename, job, sal
FROM 
    emp
WHERE
    job NOT IN ('PRESIDENT', 'MANAGER')
ORDER BY
    sal;    
    
-- ##############################################################  

SELECT 
    empno, ename
FROM 
    emp
WHERE
    empno NOT LIKE '78%';    
    
-- ##############################################################  

SELECT 
    empno, ename
FROM 
    emp
WHERE
    mgr IN (SELECT 
                empno 
            FROM 
                emp 
            WHERE 
                job='MANAGER');    

-- ##############################################################  

SELECT 
    empno, ename, hiredate
FROM 
    emp
WHERE
    EXTRACT(Month FROM hiredate)!=03;    
    
-- ##############################################################  

SELECT 
    empno, ename, job, deptno
FROM 
    emp
WHERE
    job='CLERK' AND deptno=20;     
    
-- ##############################################################  

SELECT 
    empno, ename, hiredate, deptno
FROM 
    emp
WHERE
    deptno IN (30, 10) AND EXTRACT(Year FROM hiredate)=1981;      
    
-- ##############################################################  

SELECT 
    empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM 
    emp
WHERE
    ename='SMITH';         
    
-- ##############################################################  

SELECT 
    empno, ename, location
FROM 
    branch JOIN dept
    ON branch.branchno=dept.branchno
    JOIN emp
    ON dept.deptno=emp.deptno
WHERE
    ename='SMITH';      