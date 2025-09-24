SELECT empno
    ,ename
    ,job
    ,mgr
FROM emp;

-- || 연산자로 2개의 column을 연결
SELECT empno AS "똥!ㅋㅋ" -- 별칭(alizs)
    ,ename AS "사원명"
    ,'Nice Morning!!  ' || ename AS "Wellcome MSG"
    , ename || '''s 급여' || sal as "급여" -- kim's salary
FROM emp;

SELECT deptno 
FROM emp;

SELECT 
    DISTINCT deptno 
FROM emp;

-- distinct: 중복되는 값을 제거하고 출력
-- 정렬 ASC
SELECT DISTINCT job 
    ,deptno
FROM emp
ORDER BY job;

-- 정렬 DESC
SELECT DISTINCT job 
    ,deptno
FROM emp
ORDER BY job DESC;

-- Page 39 Q1(ID AND WEIGHT): name, id, weight
SELECT name ||'''s ID: '||id || ' , WEIGHT is '||weight||'Kg' AS "ID AND WEIGHT"
FROM student;

-- Page 39 Q2(NAME AND JOB): ename, job
SELECT ename || '(' || job || '), ' || ename || '''' || job || '''' AS "NAME AND JOB"
FROM emp;

-- Page 39 Q2(Name And Sal): ename, sal
SELECT ename || '''s sal is $'||sal AS "Name And Sal"
FROM emp;

-- where.
SELECT empno
    ,ename
    ,job
    ,mgr
    ,hiredate
    ,sal + comm as "Salary"
    ,comm
    ,deptno
from emp
--WHERE job='SALESMAN';
--WHERE empno = 7499;
--WHERE sal > 1000;
--WHERE sal between 1000 and 2000;
--WHERE empno in (7934, 7844, 7499) and comm = 0;
--WHERE empno in (7934, 7844, 7499) and (comm is null or comm = 0);
--WHERE empno in (7934, 7844, 7499) or comm is null;
--WHERE ename like '%LA%';
--WHERE ename like 'M%';
--WHERE 1=1;
--WHERE comm is not null;
WHERE hiredate > '80/12/30' and hiredate < '82/1/1';

select * from emp;
-- 사원번호가 7900번대인사람을조회한다?

SELECT *
FROM emp
WHERE empno >= 7900 and empno < 8000 and hiredate > '82/01/01';

-- 단일행 함수
SELECT *
FROM professor
--WHERE email LIKE '%naver.com';
WHERE pay + nvl(bonus, 0) >= 300;

-- 문자 함수
SELECT profno 
    ,lower(name) AS "low_Name"
    ,upper(id) AS "upp_id"
    ,initcap(position) AS "pos"
    ,pay
    ,concat(concat(name,' - '),id) AS "name - id"
FROM professor
where length(name) <> 10;

-- lengthb('A') => 1, lengthb('ㄱ') => 3
SELECT length(name) as "length"
    ,name
    ,substr(name, 1, 5) as "substr"
    ,instr(name, 'A') as "instr A"
    ,instr(name, 'a') as "instr a"
--    ,instr(upper(name), 'A') as "instr upper(A)"
    ,pay
    ,bonus
    ,ltrim(lpad(id, 10, '*'),'*') AS "lpad"
    ,trim('  hell, togo') as "str"
    ,replace('  hell, togo ','h','FFF')
from professor
WHERE instr(upper(name), 'A') > 0;

-- Page.79: SUBSTR/INSTR
SELECT name
    ,tel
    ,substr(tel, 0, instr(tel, ')')-1) AS "AREA CODE"
FROM student
WHERE deptno1 = 201;

-- Page 84. REPLACE Q1 replace(lpad(length(ename)),4,'*')
SELECT ename
--    ,lpad(length(ename))
--    ,REPLACE(ename,length(ename),'*')
    ,REPLACE(ename, SUBSTR(ename,2,2),lpad('-',length(SUBSTR(ename,2,2)),'-')) AS "REPLACE"
FROM emp;

-- Page 84. REPLACE Q2
SELECT name
    ,jumin
    ,REPLACE(jumin,SUBSTR(jumin,7,7),rpad('-/',length(SUBSTR(jumin,7,7)), '-/'))AS "REPLACE"
--    ,rpad(substr(jumin,1,6),13,'-/') AS "REPLACE"
--    ,rpad(substr(substr(jumin,7,7),1,6),13,'-/')
FROM student
where deptno1 = 101;

-- Page 85. REPLACE Q3
SELECT name
    ,tel
--    ,length(substr(tel,5,3))
--    ,concat(' ',rpad('',length(substr(tel,5,3)),'*'))
    ,REPLACE(tel, substr(tel,5,3),lpad('*',length(substr(tel,5,3)),'*')) AS "REPLACE"
FROM student
WHERE deptno1 = 102;

-- Page 85. REPLACE Q4
SELECT name
    ,tel
    ,REPLACE(tel, substr(tel,instr(tel,'-')+1,4),'****') AS "REPLACE"
FROM student
WHERE deptno1 = 101;

-- 86p Math Function
SELECT empno
    ,job
    ,ROUND(sal / 12, 2) AS "month"
    ,trunc(sal / 12) AS "trunc"
    ,mod(sal, 12) AS "mod"
    ,ceil(sal/12) AS "ceil"
    ,FLOOR(sal/12) AS "FLOOR"
    ,power(2,10) AS "POWER"
from emp
ORDER BY (sal / 12) desc;

-- 89p Date Function
select *
from emp
where hiredate > '82/1/1';
--where hiredate > '1982/01/01';-- RR/MM/DD, RRRR/MM/DD

-- 앞에서 뒤의값을 뺀다(15년 1월1일 - 10년 1월1일) = 60개월
SELECT months_between('15/01/01', '10/01/01')
FROM dual;

SELECT add_months(sysdate, 2)
    ,next_day(sysdate+1, '목') AS "nd"
    ,last_day(add_months(sysdate,1)) AS "ld"
FROM dual;

-- page 99 DataType   (n): n이 자릿수/데이터 크기
-- char(2000)    ->'         3' : 고정길이 문자열
-- varchar2(4000)->'3' : 가변길이 문자열
-- number(38)    -> 999999999
-- number(10,2)  -> 99999999.99 전체 10자리중 2자리를 소숫점표현에 사용

-- SQL의 형변환
-- 1+'2' => 3 자동(묵시적) 형변환
-- 2*'3' => 6
-- 1+'A' => err
select 2 * '3'
from dual;

--select to_char(sysdate, 'rrrr-mm-dd') AS "today"
-- Date타입에서 문자열타입으로 명시적 변환 되었기때문에 비교연산자 안먹음
select sysdate
    ,to_char(sysdate, 'year/mon/ddth hh24:mi:ss') AS "today"
from dual;
--where sysdate = to_char(sysdate, 'rrrr/mm/dd');

SELECT sysdate
    ,TO_DATE('2025-09-24','yyyy-mm-dd')
    ,TO_DATE('2025-09-24 13','yyyy-mm-dd hh24')
FROM dual
where sysdate = TO_DATE('2025/09/24','yyyy/mm/dd');