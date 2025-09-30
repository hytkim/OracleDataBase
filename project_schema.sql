-- 회원 테이블
DROP TABLE user_t purge;
CREATE TABLE user_t(
--  user_no  number(10)
  id VARCHAR2(20) CONSTRAINT user_pk PRIMARY KEY
  ,  pw VARCHAR2(20) NOT NULL
  ,  name VARCHAR2(50) NOT NULL

  ,  CONSTRAINT name_uk UNIQUE(name)
);


-- 작성 글 테이블
drop table board_t purge;
CREATE TABLE board_t(
  board_no NUMBER(5) CONSTRAINT board_pk PRIMARY KEY
  , title VARCHAR2(100) NOT NULL
  ,	content VARCHAR2(1000) NOT NULL
  ,	writer VARCHAR2(50) NOT NULL
  ,	write_date DATE DEFAULT SYSDATE
  ,	likes	NUMBER(3) DEFAULT 0

  ,  CONSTRAINT board_t_writer_fk FOREIGN KEY (writer) REFERENCES user_t(name)
);

-- 작성 댓글 테이블
drop table comments_t purge;
CREATE TABLE comments_t(
  comments_no NUMBER(10) -- 댓글 인덱스
  ,  board_no NUMBER(5) -- 댓글이 달린 테이블 인덱스
  ,  content VARCHAR2(1000) NOT NULL -- 댓글 내용
  ,  writer VARCHAR2(50) NOT NULL    -- 댓글 작성자 이름
  ,  writer_date DATE DEFAULT SYSDATE -- 댓글 작성 일자

  ,  CONSTRAINT comments_pk PRIMARY KEY (comments_no)
  ,  CONSTRAINT comments_board_no_fk FOREIGN KEY (board_no) REFERENCES board_t(board_no)
  ,  CONSTRAINT comments_writer_fk FOREIGN KEY (writer) REFERENCES user_t(name)
);

select * 
from user_t;

select * 
from board_t;

select * 
from comments_t;


drop sequence user_t_seq;
create sequence user_t_seq;
-- Oracle Sequence 오라클 시퀀스 속성 설정
--drop sequence board_t_seq;
--create sequence board_t_seq
--increment by 2 -- 2씩증가함
--start WITH 100-- 100부터 시작함
--maxvalue 120 --최대값 120으로지정함
--MINVALUE 80 -- 이 시퀀스가 가질수있는 최소값
--cycle -- 120까지가면 minvalue부터 다시 시작함
--;

INSERT INTO user_t(id, pw, name) 
  VALUES ('scott', 'tiger', 'Sc000');
select * from user_t;

drop sequence board_t2_seq;
create sequence board_t2_seq;

INSERT INTO board_t(board_no, title, content, writer) 
  VALUES (board_t2_seq.nextval, 'test_Sc000'||board_t2_seq.nextval, 'Lolem ipsum pl', (select name from user_t where id = (:id)));

drop sequence comments_t_seq;
create sequence comments_t_seq;

INSERT INTO comments_t(comments_no, board_no, content, writer)
  VALUES (comments_t_seq.nextval, (:board_no), 'test input comment', (select writer from board_t where board_no = (:board_no) ));

-- 테이블의 데이터를가져와서 그대로 새 데이터처럼집어넣어서 양 복사하는 기술
--insert into user_t (id, pw, name)
--select id||user_seq.nextval, pw, name||user_seq.nextval
--from user_t;
-- 처음 지정한 테이블크기때문에 값이 더 안들어가서 수정이필요하다면?
--alter table board_t modify board_no number(10);

