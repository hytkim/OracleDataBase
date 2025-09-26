SELECT * FROM tab; -- 모든 테이블 조회, drop으로 날려버린 테이블이름이 BIN으로시작하는 값으로 조회된다
-- BIN$vPnmVd0+RX+YBd5x9CPY6w==$0 형식으로 BIN으로 시작되는 테이블은 drop테이블의 잔재이다.
-- 실무에서 Drop table같은거쓰면 돈물어주고 업계 쫓겨날수도있다 절!대! 쓰지마라.
purge table "BIN$xzlG18BbRxagpuEiN/c7oQ==$0";
purge table "BIN$wwm57R+mRFaYh7xb27y6qg==$0";
-- 위처럼 쌀숭이들이나 쓸법한 생각은 하지않는다 효율적인방법이 있었다는것이다(난 수동으로함)
SELECT 'purge table "' || tname || '";' from tab ;
--오라클db서버에 테이블스페이스를 만들고 그 공간에 테이블을 논리적인 명칭을붙여서 2진 값으로 저장한다

-- 쇼핑몰구조를가져와서 테이블을 만들고 ERD를그린다.
-- 이렇게 제약조건만들면 오라클에서 임의로 제약조건의 이름을 넣어준다 SYS C08113 같은식
CREATE TABLE NEW_TABLE(
  NO NUMBER(3) PRIMARY KEY    -- 회원 번호(숫자 3자리 000~999), 유일한 값이에요.
  ,NAME VARCHAR2(100) NOT NULL -- 이름 (가변문자 10자리), 반드시 값을 넣어 주세요.
  ,BIRTH DATE DEFAULT SYSDATE -- 생일 TO_DATE('2020-01-01', 'RRRR-MM-DD'), 기본값은 생성된 현재날자로 주겠어요.
);

-- 밑에서올라옴 327p.
create table new_emp( no number(4) CONSTRAINT emp_pk PRIMARY KEY
  , name varchar2(20) CONSTRAINT emp_name_nn NOT NULL
  , jumin varchar2(13) CONSTRAINT emp_jumin_nn Not null
                       CONSTRAINT emp_jumin_uk unique
  , loc_code number(1) CONSTRAINT emp_area_ck check(loc_code < 5)
  , deptno number(2) CONSTRAINT emp_dept_fk references dept(deptno)
);
select * from new_emp;

SELECT * FROM NEW_TABLE;
SELECT * FROM tab;

INSERT INTO new_table(no, name) values(1, '홍길동');
INSERT INTO new_table(no, name, birth) values(1, '홍길동', '2001-01-01');

INSERT INTO new_table(no, name, birth) values(2, '홍길동', '2001-01-01');
-- 컬럼 추가
alter table new_table add phone varchar2(20);

update new_table set phone = '010-1111-1111';
update new_table 
set phone = '010-2222-2222',
  birth =  to_date('2001-02-02', 'yyyy-mm-dd')
where no = 2;

-- 컬럼 수정, 변경
alter table new_table RENAME column phone to tel;
alter table new_table modify tel varchar2(30);

-- 테이블 제약조건 출력
desc new_table;
-- 컬럼 에대한 추가, 수정, 변경, 제거 
alter table new_table drop column tel;
-- truncate: 테이블의 모든데이터 제거, delete로 모든 행 지운거랑 비슷한결과인데 delete가 더 안전하다 데이터가살아있다
-- truncate table new_table; 
drop table new_table;
select * from user_recyclebin; -- 휴지통뒤져서 테이블 이름 보는 명령
flashback table new_table to before drop; -- 테이블 휴지통에서 꺼내오는 명령, data있는상태에서 drop했으면 데이터도 살아났을거다.
-- 절대!! purge쓰지마라!!!!!!
--drop table new_table purge;-- 퍼지써서 날리면 tab로 조회해도 안나온다 절대!! purge쓰지마라!!!!!!
select * from new_table;
commit;
-- 삭제된것 처럼 보이지만! 그것은 내 작업환경에서만 그렇게 보이고 실제 DB에는 반영되지않았다.
-- commit 하기전까지는 슈뢰딩거의 값으로써 존재상태와 비존재상태가 공존한다
-- commit 하기전에는 복구가능한게 delect
-- 복구불가능한게 truncate, drop porge
delete from new_table
where no = 2;
rollback;

-- oracle DB의 11g버전에서만쓰던 옵션 지금은 21c(10년전이다..), 실무에선 11g쓸수도있다
alter table new_table read only;
-- read only에서는 insert작업은 할 수 없고, 조회는 가능하다
INSERT INTO new_table(no, name, birth) values(3, '갈!길동', '2001-01-01');
-- 이걸로 읽기/쓰기 모드로 변경가능하다는데? 한가할때해보던가
--alter table new_table read write;

-- Virture Column => 값 입력은 안 된다.
alter table new_table add info GENERATED always as (no || '-' || name);

select * from tab;

--------------------------------------------------------------------------------
-- 290p DML Insert, delete, update
select * from dept2;
desc dept2;

insert into dept2( dcode, dname, pdept, area) --(여기안에거는 생략가능한데 순서 정확하게 맞춰줘야한다.)
values(to_char(9000), 'temp_1',to_char(1006), 'Temp Area');

insert into dept2
values(to_char(9001), 'temp_2',to_char(1006), 'Temp Area');

-- professor2를 만드는데 professor의 모든데이터를 가져와서 만들겠다.
-- CTAS(크리에이트 테이블 에즈 셀렉트)
create table professor2 
as
select * from professor;

select * from professor2;

-- professor2 만드는데 professor의 구조와 제약조건만 가져와서 만들겠다.
create table professor3
as
select * from professor
where 1=2;
select * from professor3;
desc professor3;

-- 테이블을 들고와서 그대로 만들수도있고, 구조만 가져와서 만들고, 추가는 내입맛대로 조건넣어서 만들수도있다.
-- ITAS (인서트 테이블 에즈 셀렉트)
insert into professor3 
select * from professor;
select * from professor3;

-- 인서트 -> 롤백 => 동작함
-- 인서트 -> 테이블생성 -> 롤백 => 동작안함, 테이블만들면 자동커밋 이루어짐

--drop table professor3 purge;
--drop table prof_1 purge;
Create table prof_1(
  profno number,
  name varchar2(25));
Create table prof_2(
  profno number,
  name varchar2(25));
  
Insert all
when profno between 1000 and 1999 then into prof_1 values(profno, name)
when profno between 2000 and 2999 then into prof_2 values(profno, name)
  select profno, name
from professor;
select * from prof_1;
select * from prof_2;

rollback;
-- 이런식으로도 insert 할 수 있다.
insert all
  into prof_1 values (profno, name)
  into prof_2 values (profno, name)
select profno, name
from professor;

-- 299p Update
select * from professor;
update professor
set bonus = 111
where bonus is null;

update professor
set bonus = decode(bonus,null,111, bonus),
  pay = pay+pay*0.1
where 1=1;

rollback;
select * from professor;
--숙제 컫!!!!!!!!!!
update professor
set bonus = decode(bonus,null, 999, bonus),
  pay = pay+pay*0.1,
  hpage =  decode(hpage,null,'http://www.' || substr(email,instr(email,'@')+1, length(email)-instr(email,'@')), hpage)
  -- hpage를 이메일의 회사의 홈페이지로 변경. 
where 1=1;

--300p delete 삭제.
select * from dept;
select * from emp;

-- emp에서 포링키로 dept.deptno를 참조중이라서 dept의no를지우면 emp의 no가 참조하는 원본이사라짐, 참조무결성 위배됨
delete from dept
where deptno = 30;

--select * from emp
--where deptno = 30
--order by deptno;

delete emp 
where deptno = 30;

-- emp에서 포링키로 dept.deptno를 참조중이라서 deptno에 없는 값으로 변경해서는 안됨, 참조무결성 위배됨
update emp
set deptno = 50
where deptno = 20;

-- exists update
select * from emp;
select * from dept;

select * from emp e, dept d
where e.deptno = d.deptno
order by e.deptno;

update emp e
set sal = sal +100
where exists (select 1
  from dept d
  where e.deptno = d.deptno
  and d.loc = 'DALLAS'
);

select *
from emp e
where exists (select 1
  from dept d
  where e.deptno = d.deptno
  and d.loc = 'DALLAS');
--where ename in ('smith', 'allen');

select *
from emp e
where not exists (select 1
  from dept d
  where e.deptno = d.deptno
  and d.loc = 'DALLAS');
  
rollback;

select * from new_table;