select username from all_users order by username;

alter session set "_ORACLE_SCRIPT"=true;

create user hr
IDENTIFIED by hr
DEFAULT TABLESPACE users
TEMPORARY tablespace temp;

grant connect, resource,create view, unlimited tablespace
to hr;
