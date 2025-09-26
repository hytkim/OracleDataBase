--게시판, 회원관리, 상품관리, 입출관리 JSON 포멧->
-- 오라클서버 --- 웹서버(노드) --- 클라이언트(fetch)

select * from emp;


-- sys에서 작업--
SELECT *
from dba_users
where username = 'SCOTT';

ALTER USER SCOTT ACCOUNT UNLOCK;

select * from emp;

DELETE FROM emp where EMPNO = 7654;
rollback;