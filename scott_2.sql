select *
from tab;

-- Page 107. to_char()
SELECT sysdate 
    ,to_char(sysdate, 'rrrr/mm/dd') AS "sytem"
    ,to_char(12345.6,'099,999.99') AS "num"
FROM dual;

SELECT empno
    ,ename
    ,job
    ,to_Char(sal,'999,999') AS "salary"
FROM emp;

select *
from emp;

-- to_date('str','format')
select *
from professor
WHERE hiredate > to_date('90/01/01 00:00:00','rrrr/mm/dd hh24:mi:ss')
and hiredate <= to_date('00/01/01 00:00:00','rrrr/mm/dd hh24:mi:ss')
ORDER BY hiredate;

-- nvl() : NullVaLue
SELECT * 
FROM emp
WHERE sal+nvl(comm,0) >= 2000;

-- Page 112. Nvl Q1.
SELECT profno
    ,name
    ,pay
    ,bonus
--    ,pay*12+nvl(bonus,0) AS "total"
    ,nvl2(bonus, (pay*12+bonus), pay*12) AS "total"
FROM professor
WHERE deptno = 201;

-- Page 113. Nvl2 Q1.
SELECT empno
    ,ename
    ,comm
    ,nvl2(comm, 'Exist', 'NULL') AS "nvl2"
FROM emp
WHERE deptno = 30;

-- Page 113. DECODE() // Oracle Only => decode(a,b,1,0) => a == b ? 1 : 0;
SELECT empno
    ,ename
    ,decode(job,'SALESMAN','령도부서','kita buseo') AS "ASS"
    ,decode(job,'MANAGER','관ㄹ부서','kita buseo') AS "ASS"
    ,job
FROM emp;

-- Page 120. DECODE() Q1.
SELECT name
    ,jumin
    ,DECODE(substr(jumin, 7, 1), '1' ,'MAN', 'WOMAN') AS "Gender"
FROM student
WHERE deptno1 = 101;

-- Page 120. DECODE() Q2.
SELECT name
    ,tel
    ,DECODE(substr(tel,1,instr(tel,')')-1), '02' ,'SEOUL',
        DECODE(substr(tel,1,instr(tel,')')-1), '031' ,'GYEONGGI',
            DECODE(substr(tel,1,instr(tel,')')-1), '051' ,'BUSAN',
                DECODE(substr(tel,1,instr(tel,')')-1), '052' ,'ULSAN',
                    DECODE(substr(tel,1,instr(tel,')')-1), '055' ,'GYEONGNAM','DAEGU')
                )
            )
        )
    ) AS "LOC"
    ,decode(substr(tel,1,instr(tel,')')-1), '02' , '서울'
                                          , '031', '경기'
                                          , '051', '서울'
                                          , '052', '울산'
                                          , '053', '대구'
                                          , '055', '경남') AS "지!역"
FROM student
WHERE deptno1 = 101;

-- PAGE 121. CASE()
SELECT name
    ,tel
    ,case substr(tel,1,instr(tel,')')-1) when'02' then '서울'
                                         when'031' then '경기'
                                         when'051' then '부산'
                                         when'052' then '울산'
                                         when'053' then '대구'
                                         when'055' then '경남'
                                         else '지역 더 락' 
    end AS "LOC"
FROM student;
-- PAGE 121. CASE-when then else end
-- Case의 매개변수를받지않고 바로 when으로 들어가고, where에 case를넣고 end = '원하는값' 을 넣어서 필터링가능
SELECT profno
    ,name
    ,position
    ,pay *12
    ,case when pay*12 > 5000 then 'high'
          when pay*12 > 4000 then 'mid'
          when pay*12 > 3000 then 'low'
          else 'etc'
    end AS "sal"
FROM professor
WHERE case when pay*12 > 5000 then 'high'
          when pay*12 > 4000 then 'mid'
          when pay*12 > 3000 then 'low'
          else 'etc'
    end = 'high';
-- PAGE 123. CASE Q2
SELECT empno
    ,ename
    ,sal
    ,'LEVEL ' || LEAST(FLOOR(sal/1000)+1, 5) AS "LEVEL"
--    ,case when sal between 1 and 1000 then 'Level 1' 
--          when sal between 1001 and 2000 then 'Level 2' 
--          when sal between 2001 and 3000 then 'Level 3' 
--          when sal between 3001 and 4000 then 'Level 4' 
--          when sal >= 4001 then 'Level 5' 
--    end AS "LEVEL"
FROM emp
ORDER BY sal DESC;

-- PAGE 165. GROUP 함수.
-- UNION, 칼럼의개수가 맞아야 연결이 가능하다.
SELECT profno
    ,name
    ,'pro'
FROM professor
where deptno = 101
union
SELECT studno
    ,name
    ,'std'
FROM student
where deptno1 = 101;

-- group by
SELECT min(job)
  ,COUNT(*)||'명' AS "인원"
  ,sum(sal) AS "직무별 급여 합계"
  ,avg(sal) AS "직무별 급여 평균"
  ,stddev(sal) AS "ㅍㅍ"
  ,variance(sal) AS "ㅄ"
FROM emp
group by job;

-- 
SELECT  TO_CHAR(HIREDATE,'YYYY') AS "YYYY"
  ,COUNT(*) AS "인원"
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YYYY');

SELECT DEPTNO1
  ,COUNT(DEPTNO1) AS "학과별 인원"
FROM STUDENT
GROUP BY DEPTNO1 HAVING COUNT(DEPTNO1) > 2;

-- 교수TABLE: POSITION, PAY 합계ㅡ 최고급여, 최저급여 출력 => GROUP BY (POSITION)
SELECT POSITION
  ,SUM(PAY) AS "합계"
  ,MAX(PAY) AS "최고 급여"
  ,MIN(PAY) AS "최저급여"
FROM PROFESSOR
GROUP BY POSITION;

--EMP TABLE: 부서별 평균 급여, 인원
SELECT DEPTNO
  , TRUNC(AVG(SAL),0) AS "부서별 평균 급여"
  , COUNT(DEPTNO) as "부서별 인원"
FROM EMP
GROUP BY (DEPTNO);

--EMP TABLE: 부서, 직무별 평균 급여, 인원
SELECT JOB
  , TRUNC(AVG(SAL),0) AS "직무별 평균 급여"
  , COUNT(JOB) AS "인원"
FROM EMP
GROUP BY (JOB);

-- EMP TABLE: 전체사원의 평균급여, 인원
SELECT TRUNC(AVG(SAL),0) AS "전체 사원의 평균 급여"
  ,COUNT(*) AS "인원"
FROM EMP;

-- 부서, 직무, 급여, 인원
-- 부서,      급여, 인원
-- 부서, 직무, 급여, 인원
-- 부서,      급여, 인원
--           급여, 인원
SELECT DEPTNO -- 부서의 평균 급여.
  ,NULL ,TRUNC(AVG(SAL),0) ,COUNT(*), 'A'
FROM EMP
GROUP BY DEPTNO
UNION
SELECT DEPTNO -- 부서 코드를 공유하는 직무별 평균 급여.
  ,JOB ,TRUNC(AVG(SAL),0) ,COUNT(*), 'B'
FROM EMP
GROUP BY DEPTNO, JOB
UNION
SELECT NULL -- 모든 직원의 평균 급여.
  ,NULL, TRUNC(AVG(SAL),0), COUNT(*), 'C'
FROM EMP
ORDER BY 1, 2; -- 1열로 우선 정렬을 하고,그 값에서 2열기준으로 세부 정렬을 갈기갰다

--PAGE 165. 집계함수, 리포트만드는 직무에서 자주쓴다.
-- FULL < INDEX	, COST는 낮을수록 좋다
-- 바로위에 머리터지게어지러운 코드를 딸ㄹ깍으로 해치워주는 ROLLUP()
SELECT --NVL2(DEPTNO, DEPTNO, '합계') 이건 되겠죠?
DECODE(NVL(DEPTNO, 999),999,'전체', DEPTNO) AS " 부서" -- 이건 추후에 개선해볼여지가있다
--  NVL2(TO_CHAR(DEPTNO), DEPTNO, '합계')AS " 부서"
  ,NVL(JOB, '합계') AS "직무"
  ,ROUND(AVG(SAL)) AS "평균 급여"
  ,COUNT(*) AS "인원 수"
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB) -- 부서별, 직무별 소계 함수 사용.
ORDER BY 1, 2;

-- Page 178. CUBE() 집계함수
SELECT deptno, job, round(avg(sal),1) avg_sal, count(*) cnt_emp
from emp
group by cube(deptno, job)
order by deptno, job;



-- 오후 수업

SELECT dept.*, emp.*
FROM emp 
JOIN dept
on emp.deptno = dept.deptno -- 이너조인, 이퀴조인?
order by emp.deptno;

select count(*) from emp;
select count(*) from dept;

-- Page 220. emp * dept => 48
select count(*) from emp, dept;

-- on을 통해 특정항목에대한 조건을 주면 => 12
select count(*)
from emp
join dept
on emp.deptno = dept.deptno;

-- 학생태이블의 교수번호대신에 교수테이블의 교수이름을가져와서 보여줄수있을까
select * from student; -- Profno 
select * from professor; -- Profno

-- 이너조인을하면 드라이빙테이블에 널값이있을때 해당항목은 날아간다.
-- 드라이빙테이블의 모든항목에대하여 조인조건을 만족하지못하더라도 출력하려면 아우터조인을 걸어준다.
-- Left OUTER: 근데 아우터조인은 안쓰는게 제일좋다.
select studno -- order by s.studno p.profno
  ,s.name  AS "학생 명"
  ,grade
  ,s.profno
  ,p.name AS "교수 명"
  ,s.deptno1
  ,d.dname AS "학과 명"
from student s -- from 뒤에오는 테이블을 주(드라이빙) 테이블(Left)이라고 한다.
Left OUTER JOIN professor p -- 드리븐 테이블(Right)
on s.profno = p.profno
join department d
on s.deptno1 = d.deptno;

-- Right outer join
SELECT p.profno
  ,p.name
  ,s.name AS "학생명" 
  ,s.profno AS "담당 교수"
FROM professor p
left outer join student s
--right outer join student s
on p.profno = s.profno;

-- Page 236. none Equi Join 
-- 어? 그러면 조인 조건의 순서에따라서도 효율이 달라질수있겠네? 아닌가? 
-- => 오라클 옵티마이저님님님이 한 문장(;까지)읽고 다 알아서 효율좋은방향으로 실행해주니까 걱정ㄴ
-- Ansi join문법이 가장 중요하다 모든 sql공통으로 사용하기때문에 무조건 이걸 우선으로 해라.
select s.grade, e.*
from emp e
join salgrade s
on e.sal >= s.losal
and e.sal <= s.hisal
and s.grade = 2; -- 조건을 조인조건내부에주는게 연산이 줄어들어서 효율이 좋다.
--where s.grade = 3;


-- oracle join.
select e.*, d.*
from emp e, dept d
where e.deptno = d.deptno;

-- oracle outer join 
select e1.empno AS "사원 번호"
  ,e1.ename as "dlfma"
  ,e2.empno AS "admin num"
  ,e2.ename AS "admin name"
from emp e1, emp e2
where e1.mgr = e2.empno(+);

select * from department;

-- 254p Q1. Ansi join
select s.name
  ,s.deptno1
  ,d.dname
from student s
join department d
on s.deptno1 = d.deptno;

-- 254p Q1. oracle join
select s.name
  ,s.deptno1
  ,d.dname
from student s, department d
where s.deptno1 = d.deptno;

--254p Q2. Ansi join
select * from emp2; 
select * from p_grade;
select e.name
  ,e.position
  ,to_Char(e.pay, '999,999,999')
  ,to_Char(p.s_pay, '999,999,999') AS "Low PAY"
  ,to_Char(p.e_pay,'999,999,999') AS "High PAY"
from emp2 e
join p_grade p
on e.position = p.position;


--255p Q3. Ansi join
select * from emp2; 
select * from p_grade;
select e.name
  ,e.position
  ,TRUNC(MONTHS_BETWEEN(ADD_MONTHS(sysdate, - 144), e.birthday) / 12) AS age
--  ,case when (MONTHS_BETWEEN(ADD_MONTHS(sysdate, - 144), e.birthday) / 12) BETWEEN p.s_age and p.e_age then p.position
--        else ''||p.s_age||'~'||p.e_age ||p.position
    ,case when TRUNC(MONTHS_BETWEEN(ADD_MONTHS(sysdate, - 144), e.birthday) / 12) BETWEEN 0 and 24 then '매니저'
          when TRUNC(MONTHS_BETWEEN(ADD_MONTHS(sysdate, - 144), e.birthday) / 12) BETWEEN 25 and 28 then 'Deputy Section chief'
          when TRUNC(MONTHS_BETWEEN(ADD_MONTHS(sysdate, - 144), e.birthday) / 12) BETWEEN 29 and 32 then 'Section Head'
          when TRUNC(MONTHS_BETWEEN(ADD_MONTHS(sysdate, - 144), e.birthday) / 12) BETWEEN 33 and 36 then 'Deputy department head'
          when TRUNC(MONTHS_BETWEEN(ADD_MONTHS(sysdate, - 144), e.birthday) / 12) BETWEEN 37 and 40 then 'department head'
          when TRUNC(MONTHS_BETWEEN(ADD_MONTHS(sysdate, - 144), e.birthday) / 12) BETWEEN 41 and 55 then 'Director'
    else to_char(TRUNC(MONTHS_BETWEEN(ADD_MONTHS(sysdate, - 144), e.birthday) / 12))
    end AS "BE_POSITION"
from emp2 e
left outer join p_grade p
on e.position = p.position
order by TRUNC(MONTHS_BETWEEN(ADD_MONTHS(sysdate, - 144), e.birthday) / 12);

--255p Q4. Ansi join
select * from customer order by point desc;
select * from gift;
SELECT c.gname AS "CUST_NAME"
  ,c.point AS "POINT"
  ,g.gname AS "GIFT_NAME"
from customer c
join gift g
on g.g_end <= c.point -- g.g_start
and g.gname = 'Notebook';


--256p Q5. Ansi join
--select * from professor;
--select p1.profno
--  ,p1.name
--  ,to_char(p1.hiredate,'yyyy/mm/dd') AS "HIREDATE"
--from professor p1
--join professor p2
--on p1.id = substr(p2.name, -1 ,instr(p2.name,' '));