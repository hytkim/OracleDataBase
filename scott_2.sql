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

--PAGE 165.  바로위에 머리터지게어지러운 코드를 딸ㄹ깍으로 해치워주는 ROLLUP()
SELECT --NVL2(DEPTNO, DEPTNO, '합계') 이건 되겠죠?
DECODE(NVL(DEPTNO, 999),999,'전체', DEPTNO) AS " 부서" -- 이건 추후에 개선해볼여지가있다
--  NVL2(TO_CHAR(DEPTNO), DEPTNO, '합계')AS " 부서"
  ,NVL(JOB, '합계') AS "직무"
  ,ROUND(AVG(SAL)) AS "평균 급여"
  ,COUNT(*) AS "인원 수"
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB) -- 부서별, 직무별 소계 함수 사용.
ORDER BY 1, 2;


