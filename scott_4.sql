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

--update emp e
--set sal = sal *1.1
--  where exists();

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

select * from emp;
SELECT * from dept;

select * from emp e
join dept d
on e.deptno = d.deptno;
select * from emp;
select * from dept;
create or replace view emp_dept_v
as
select empno
  ,ename
  ,job
  ,sal 
  ,e.deptno
  ,dname
from emp e
join dept d
on e.deptno = d.deptno;

select * from emp_dept_v;

drop view emp_dept_v;

create or replace view emp_v
as
select empno, ename, job, deptno
from emp;

select * from emp_v;

select * from tab;

-- 학생과 담당교수 뷰.
-- 학생번호, 이름, id, 학년, 주민, 생일, 번호, 키,무게 전공1,전공2, 교수번호
select * from student; 
-- 교수번호, 이름, id, 포지션, 급여, 입사일, 보너스, 과목번호, 이메일, 홈페이지
select * from professor;

create or replace view stud_prof_v
as 
(select studno
  ,s.name studname
  ,s.birthday
  ,s.tel
  ,s.deptno1
  ,p.profno profno
  ,p.name profname
  ,p.position
  ,p.email
from student s
left outer join professor p
on s.profno = p.profno);

select * from stud_prof_v;

select v.*, d.dname
from stud_prof_v v
join department d
on v.deptno1 = d.deptno
where position = 'a full professor';

select position, count(*)
from stud_prof_v v
join department d
on v.deptno1 = d.deptno
group by position;

-- update view
create or replace view emp_v2
as select  empno, ename, job
from emp;

-- 없는거 호출하니까 오류남
update emp_v2
set ename = ''
  ,deptno = ''
where empno = '9999';

-- Create

drop table board_t purge;
CREATE TABLE board_t(
  board_no NUMBER(5) CONSTRAINT PK_board PRIMARY KEY
  ,	title VARCHAR2(100)    NOT NULL
  ,	content VARCHAR2(1000) NOT NULL
  ,	writer NVARCHAR2(50)   NOT NULL
  ,	write_date DATE DEFAULT SYSDATE  
  ,	likes	NUMBER(3) DEFAULT 0  
);

--INSERT INTO table VALUES ()
INSERT INTO board_t(board_no, title, content, writer) 
  VALUES (1, '예담맛집부록', '탄탄면이 상당해..', 'Hong');
INSERT INTO board_t(board_no, title, content, writer) 
  VALUES (2, '마리포사 폐점', '건물보수를 위한 공사,,,,', '맛집 사랑꾼');
INSERT INTO board_t(board_no, title, content, writer) 
  VALUES (3, '취직실패', '개같이 실패!!!!', '나너무힘들어');
INSERT INTO board_t(board_no, title, content, writer) 
  VALUES (4, 'Insert 쿼리', 'INSERT INTO table VALUES ()', 'dba');
INSERT INTO board_t(board_no, title, content, writer) 
  VALUES ( nvl((select max(board_no)+1 from board_t), 1), 'Insert 쿼리(wls)', 'INSERT INTO table(c1, c2, c3) VALUES (1, c2, c3)', 'dba');
-- 시퀀스를쓰면값이 자동으로 올라가기때문에 주의!
INSERT INTO board_t(board_no, title, content, writer) 
  VALUES ( board_t_seq.nextval , 'Insert 쿼리(wls)', 'INSERT INTO table(c1, c2, c3) VALUES (1, c2, c3)', 'dba');

select * from board_t;

-- Oracle Sequence 오라클 시퀀스
drop sequence board_t_seq;
create sequence board_t_seq
increment by 2 -- 2씩증가함
start WITH 100-- 100부터 시작함
maxvalue 120 --최대값 120으로지정함
MINVALUE 80 -- 이 시퀀스가 가질수있는 최소값
cycle -- 120까지가면 minvalue부터 다시 시작함
;
select board_t_seq.nextval from dual;


-- 시퀀스를 반영해서 생성문을 최적화해보자
drop table board_t purge;
CREATE TABLE board_t(
  board_no NUMBER(5) CONSTRAINT PK_board PRIMARY KEY
  ,	title VARCHAR2(100)    NOT NULL
  ,	content VARCHAR2(1000) NOT NULL
  ,	writer NVARCHAR2(50)   NOT NULL
  ,	write_date DATE DEFAULT SYSDATE  
  ,	likes	NUMBER(3) DEFAULT 0  
);

drop sequence board_t_seq;
create sequence board_t_seq;

INSERT INTO board_t(board_no, title, content, writer) 
  VALUES (board_t_seq.nextval, '예담맛집부록', '탄탄면이 상당해..', 'Hong');
INSERT INTO board_t(board_no, title, content, writer) 
  VALUES (board_t_seq.nextval, '마리포사 폐점', '건물보수를 위한 공사,,,,', '맛집 사랑꾼');
INSERT INTO board_t(board_no, title, content, writer) 
  VALUES (board_t_seq.nextval, '취직실패', '개같이 실패!!!!', '나너무힘들어');
INSERT INTO board_t(board_no, title, content, writer) 
  VALUES (board_t_seq.nextval, 'Insert 쿼리', 'INSERT INTO table VALUES ()', 'dba');
INSERT INTO board_t(board_no, title, content, writer) 
  VALUES ( board_t_seq.nextval, 'Insert 쿼리(wls)', 'INSERT INTO table(c1, c2, c3) VALUES (1, c2, c3)', 'dba');
  
select * from board_t;

-- 테이블의 데이터를가져와서 그대로 새 데이터처럼집어넣어서 양 복사하는 기술
insert into board_t (board_no, title, content, writer)
select board_t_seq.nextval, title, content, writer
from board_t;

select count(*) from board_t;

-- 처음 지정한 테이블크기때문에 값이 더 안들어가서 수정이필요해졌다
alter table board_t modify board_no number(10);



