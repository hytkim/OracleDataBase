select username from all_users;

alter session set "_ORACLE_SCRIPT"=true;

create user scott
IDENTIFIED by tiger
DEFAULT TABLESPACE users
TEMPORARY tablespace temp;

--권한 여기서 안 주면 scott씨는 db에접속 할수가 없다
grant connect, resource, unlimited tablespace
to scott;