-- 문제에 이름(last_name)이니까 사원 이름, 이름 들도 last_name으로가면되는거 맞죠
--Q1. where salary between 7000 and 12000 And substr(last_name,1,1) = 'H'
SELECT employee_id
  , last_name 
  , salary
  , department_id
FROM employees e
WHERE salary BETWEEN 7000 AND 12000 
And SUBSTR(last_name,1,1) = 'H';

--Q2. where department_id in (50, 60) And sa
SELECT employee_id
  , last_name 
  , job_id
  , salary
  , department_id
FROM employees e
WHERE department_id IN (50, 60) 
And salary >= 5000;

-- Q3. input
SELECT last_name 
  , salary
  , CASE WHEN salary <= 5000 THEN salary*1.2
         WHEN salary <= 10000 THEN salary*1.15
         WHEN salary <= 15000 THEN salary*1.1
         ELSE salary
  END AS "인상된 급여"
FROM employees
WHERE employee_id = :input;

-- Q4. departments, locations join
SELECT department_id
  ,  department_name
  ,  city
FROM departments d
JOIN locations l
ON d.location_id = l.location_id;

-- Q5. subqueury
select employee_id
  ,last_name
  ,job_id
from employees 
where employee_id in(
  (SELECT employee_id FROM EMPLOYEES e JOIN departments d on e.department_id = d.department_id WHERE department_name = 'IT')
);

-- Q6 2014 아니라 2004년도
select e.* 
from employees e
where job_id = 'ST_CLERK'
and hire_date < to_date('2004-01-01','yyyy-mm-dd');

-- Q7.
select last_name
  , job_id
  , salary
  , lpad(to_char(commission_pct, '.9'),length('commission_pct'), ' ') AS "COMMISSION_PCT"
from employees
where commission_pct is not null
order by salary desc;

-- Q8. CREATE PROF
CREATE TABLE PROF (
  PROFNO NUMBER(4)
  , NAME VARCHAR2(15) NOT NULL
  , ID   VARCHAR2(15) NOT NULL
  , HIREDATE DATE
  , PAY NUMBER(4)
);

--DD Q.9-1
INSERT INTO PROF (PROFNO, NAME, ID, HIREDATE, PAY)
  VALUES (1001, 'Mark', 'm1001', TO_DATE('07/03/01','yy/mm/dd'), 800);
INSERT INTO PROF (PROFNO, NAME, ID, HIREDATE)
  VALUES (1003, 'Adam', 'm1003', TO_DATE('11/03/02','yy/mm/dd'));

COMMIT;

-- Q.9-2
UPDATE PROF 
SET PAY = 1200
WHERE PROFNO = 1001;

-- Q.9-3
DELETE FROM PROF 
WHERE PROFNO = 1003;


-- Q. 10-1
ALTER TABLE PROF
MODIFY(PROFNO NUMBER(4) PRIMARY KEY);
-- Q. 10-2 ADD
ALTER TABLE PROF
ADD(GENDER CHAR(3));

-- Q. 10-3 MODIFY
ALTER TABLE PROF
MODIFY(NAME VARCHAR2(20));
