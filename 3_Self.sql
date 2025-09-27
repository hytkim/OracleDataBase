-- Page 250~ 253 -> Page 89 -> Page 86

-- 254p. Q1
select * from student;
select * from department;

select s.name
    ,s.deptno1
    ,d.dname
from student s
join department d
on s.deptno1 = d.deptno;


-- 254p. Q2
select * from emp2;
select * from p_grade;

select e.name
    ,e.position
    ,to_char(e.pay,'99,999,999') AS "PAY"
    ,to_char(p.s_pay,'99,999,999') AS "Low PAY"
    ,to_char(p.e_pay,'99,999,999') AS "High Pay"
from emp2 e
join p_grade p
on e.position = p.position;


-- 255p. Q3
--    ,TRUNC(MONTHS_BETWEEN(sysdate, e.birthday)/12 - 12) AS "나이"
--    ,(MONTHS_BETWEEN(sysdate, e.birthday)-2)/12 -12 AS "소숫점 나이"

select * from emp2;
select * from p_grade;

select e.name
    ,TRUNC((MONTHS_BETWEEN(sysdate, e.birthday)-2)/12 - 12) AS "나이"   
    ,e.emp_type AS "CURR_POSITION"
    ,p.position AS "BE_POSITON"
from emp2 e
join p_grade p
on TRUNC((MONTHS_BETWEEN(sysdate, e.birthday)-2)/12 - 12) BETWEEN p.s_age and e_age
order by e.birthday desc;

-- 256p. Q5
select * from professor order by hiredate;

select p.profno
    ,p.name
    ,TO_CHAR(p.hiredate,'yyyy/mm/dd') AS "HIREDATE"
--    ,trunc(MONTHS_BETWEEN(sysdate, p.hiredate),2)
    ,count(p2.hiredate) AS " COUNT"
from professor p
left outer join professor p2
on trunc(MONTHS_BETWEEN(sysdate, p.hiredate),2) < trunc(MONTHS_BETWEEN(sysdate, p2.hiredate),2)
GROUP BY p.profno
    ,p.name
    ,TO_CHAR(p.hiredate,'yyyy/mm/dd')
    ,trunc(MONTHS_BETWEEN(sysdate, p.hiredate),2)
order by trunc(MONTHS_BETWEEN(sysdate, p.hiredate),2) desc;


-- 257p. Q6
select * from emp;

select e.empno
    ,e.ename
    ,e.hiredate
    ,count(e2.hiredate) AS "COUNT"
from emp e
left outer join emp e2
on trunc(MONTHS_BETWEEN(sysdate, e.hiredate),5) < trunc(MONTHS_BETWEEN(sysdate, e2.hiredate),5)
group by e.empno
    ,e.ename
    ,e.hiredate
order by trunc(MONTHS_BETWEEN(sysdate, e.hiredate),2) desc, e.empno desc; 