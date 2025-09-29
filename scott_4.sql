select * from emp order by ename;
desc emp;

-- empno, ename, job, hiredate, deptno 만넣는걸 진행해보자.

insert into emp(empno, ename, job, hiredate, deptno) 
         values(9999, 'Hong', 'SALESMAN', to_date('1982-03-01','rrrr-mm-dd'), 30);

--update emp, sal = 1000: sal < 1000
update emp set sal = 1000
where sal < 1000;

update emp set comm = 500
where comm < 500;

update emp set sal = sal * 1.1
where hiredate < to_date('1981-07-01','yyyy-mm-dd')
and hiredate >= to_date('1981-01-01','yyyy-mm-dd'); 


-- Rene Russo 학생을 담당하고있는 교수(profno)의 name, position
select * from professor;
select * from student;

select s.studno, s.name AS "STUDENT NAME"
  ,p.profno
  ,p.name AS "PROFSOOR NAME"
  ,p.position
from student s
join professor p
on s.profno = p.profno
where s.studno = 9412;

-- department.dname = Computer Engineering, student studno, name
select * from department;
select * from student;

select s.studno
  , s.name
  ,s.deptno1,s.deptno2
  ,d.dname
from student s
join department d
on s.deptno1 = d.deptno or s.deptno2 = d.deptno
where d.deptno = 101;

-- student.deptno1 = 101 =>  professor.profno,name,position
select * from professor;
select * from student;

select s.studno
  , s.name AS "STUDENT NAME"
  ,d.dname
  , p.name AS "PROFSOOR NAME"
  ,p.position
from student s
left outer join professor p
on s.profno = p.profno
join department d
on s.deptno1 = d.deptno
where s.deptno1 = 101;

select distinct p.profno, p.name, p.position
from student s
join professor p
on s.profno = p.profno
join department d
on s.deptno1 = d.deptno
where s.deptno1 = 101;

-- assistant professor
select * from professor; 
select distinct position from professor;
-- 학생중에 담당교수의 포지션이 어시스턴트프로페서인놈
select * 
from student s
join professor p
on s.profno = p.profno
where p.position = 'assistant professor';

-- SubQuery
-- 학생전공이 컴공인 학생들의 height, weight 중 키가 가장 큰 학생 184
select * from student order by height desc; 
select * from professor; 

--  weight의 평균, 평균몸무게보다 많은 무게가 나가는 놈들만 고로시
select *
from student ss 
where ss.weight >
(select AVG(weight)
from student s
join department d
on s.deptno1 = d.deptno
where deptno = 101);

-- student s.deptno = 201, 학생의 담당교수
select * from department;
select * from student;
select nvl(profno, 0) from student where deptno1 = 201;


select * 
from professor pp
where pp.profno in (select p.profno
                    from professor p
                    join student s
                    on p.profno = s.profno
                    join department d
                    on s.deptno1 = d.deptno
                    where d.deptno = 201);

-- 교수 급여pay의 평균avg이상 받는 교수를 보여줘라
select * from department;
select * from professor p
where p.pay >= (select avg(pay)
from professor);

-- 보너스없는찐따중에 가장먼저 입사한교수
select * from professor order by bonus;

(select min(hiredate) from professor
where bonus is null);

select * 
from professor p
where p.hiredate < (select min(hiredate) from professor
where bonus is null)
order by p.hiredate;

--보너스를 안받는사람들중 가장 많은 월급을 받는 교수보다 월급이 적은교수의 월급 10% 인상

select * 
from professor p
where p.pay < (select max(pay) from professor
where bonus is null);

select * from professor p;

update professor p
set pay = pay*1.1
where p.pay < (select max(pay) from professor
where bonus is null);

rollback;