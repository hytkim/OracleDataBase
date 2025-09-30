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

-- 09 - 30
-- rownum 모든 행에대한 호출이 끝난 후, 순차적으로 순번을 매김. => 중간에 행몇개사라져도 안심

select rownum, b.* 
from board_t b
order by board_no;

delete from board_t where board_no = 6;



-- primarykey인 index를 쓰면 겁나빠른정렬이가능해서 rownum이랑 같이쓰면 맛집이다.
-- 0.006초컷 레전드
-- 1page: rn 1~10, 2page: 11~20
select rownum rn, a.*
from(select b.* from board_t b
order by board_no) a;


-- 0< page <=10 .. 10 < page <= 20  !근데 2부터 안돌아감
-- 첫번째: rownum의값은 1부터 시작하기때문에 가져온 모든데이터를 버리고 1번부터 다시 시작하기때문에 불가능한코드다.
select c.*
  from (select rownum rn, a.* from (select b.* from board_t b order by board_no) a ) c
where c.rn> (:page - 1) * 10 
and c.rn <= (:page * 10);

-- ((인덱스로 정렬된 원본 테이블a))
-- 정렬을 index가아니라 write_date로하면 효율20%넘게 차이남 미친손실보는거임 index는 신이다.
select c.*
  from (select rownum rn, a.* from (select b.* from board_t b order by write_date) a ) c
where c.rn> (:page - 1) * 10 
and c.rn <= (:page * 10);

-- 인덱스를 만들어서 해보자
create index board_write_date_idx
on board_t(write_date);
-- 인덱스를 쓴다고 다 빨라지는건 아니다 ㅋ
select c.*
  from (select rownum rn, a.* from (select b.* from board_t b order by write_date) a ) c
where c.rn> (:page - 1) * 10 
and c.rn <= (:page * 10);

-- 오라클 실행계획 에 index를 활용하면 좋다, order by같은 쓰레기는 안쓰는게 맞다.
select /*+ INDEX_DESC(b pk_board)*/ b.*
from board_t b;

-- 바 로 실 전
-- ':page'  콜론페이지 전체가 하나의 매개변수라는뜻이라서 js에넣을때는 : 떼야겠지??
select c.*
  from (select /*+ INDEX(a pk_board)*/ rownum rn, a.* from board_t a ) c
where c.rn> (:page - 1) * 10 
and c.rn <= (:page * 10);
