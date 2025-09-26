select username from all_users;

alter session set "_ORACLE_SCRIPT"=true;

create user scott
IDENTIFIED by tiger
DEFAULT TABLESPACE users
TEMPORARY tablespace temp;

--권한 여기서 안 주면 scott씨는 db에접속 할수가 없다
grant connect, resource, unlimited tablespace
to scott;


-- 09- 26
-- sys는 최종권한자라서 oracleDB에있는 DataDictionary에서 관리중인 테이블을 볼 수 있다.
select * from tab;

select * from all_users;
select * from dba_users
order by username;