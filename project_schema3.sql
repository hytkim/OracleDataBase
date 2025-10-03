-- 시퀀스 드롭
DROP SEQUENCE items_seq;
DROP SEQUENCE board_seq;
DROP SEQUENCE history_seq;
DROP SEQUENCE comments_seq;


-- 테이블 드롭 (FK 관계를 고려하여 순서대로 드롭)
DROP TABLE project_comments_t CASCADE CONSTRAINTS;
DROP TABLE project_history_t CASCADE CONSTRAINTS;
DROP TABLE project_board_t CASCADE CONSTRAINTS;
DROP TABLE project_items_t CASCADE CONSTRAINTS;
DROP TABLE project_discount_t CASCADE CONSTRAINTS;
DROP TABLE project_user_t CASCADE CONSTRAINTS;


-- PK용 시퀀스 생성
CREATE SEQUENCE items_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE board_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE history_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE comments_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- VARCHAR2 변환용

---
-- 사용자 테이블 (DEFAULT 값 추가)
CREATE TABLE project_user_t (
    user_id          VARCHAR2(50)     NOT NULL,
    user_pw          VARCHAR2(100)    NOT NULL,
    user_name        VARCHAR2(50)     NOT NULL,
    user_address     VARCHAR2(50)     NULL,
    user_birth       DATE             NOT NULL,
    user_create_date DATE             DEFAULT SYSDATE, -- DEFAULT 추가: 현재 날짜
    user_grade       NUMBER(20)       DEFAULT 1,       -- DEFAULT 추가: 일반 회원(1)
    user_access      NUMBER(1, 0)     DEFAULT 0,       -- DEFAULT 추가: 일반 접근(0)
    user_point       NUMBER(38, 0)    DEFAULT 1000,       -- DEFAULT 추가: 0 포인트
    user_mileage     NUMBER(1, 0)     DEFAULT 0,       -- DEFAULT 추가: 0 마일리지
    CONSTRAINT pk_user_id PRIMARY KEY (user_id)
);

---
-- 상품 할인 정보 테이블
CREATE TABLE project_discount_t (
    items_category   VARCHAR2(100)    NOT NULL,
    discount_percent NUMBER(5, 2)     NULL,
    CONSTRAINT pk_items_category PRIMARY KEY (items_category)
);

---
-- 상품 테이블
CREATE TABLE project_items_t (
    items_no         NUMBER(38, 0)    NOT NULL,
    user_id          VARCHAR2(50)     NOT NULL,
    items_category   VARCHAR2(100)    NOT NULL,
    items_name       VARCHAR2(50)     NULL,
    items_info       VARCHAR2(1000)   NULL,
    items_date       DATE             NULL,
    items_price      NUMBER(10)       NOT NULL,
    items_image      VARCHAR2(1000)   NULL,
    CONSTRAINT pk_items_no PRIMARY KEY (items_no),
    CONSTRAINT fk_items_user FOREIGN KEY (user_id) REFERENCES project_user_t (user_id),
    CONSTRAINT fk_items_category FOREIGN KEY (items_category) REFERENCES project_discount_t (items_category)
);

---
-- 상품 게시판 테이블
CREATE TABLE project_board_t (
    board_no         NUMBER(20)       NOT NULL,
    user_id          VARCHAR2(50)     NOT NULL,
    items_no2        NUMBER(38, 0)    NOT NULL,
    board_title      VARCHAR2(50)     NOT NULL,
    board_content    VARCHAR2(1000)   NOT NULL,
    writer_date      DATE             DEFAULT SYSDATE, -- DEFAULT 추가: 현재 날짜
    CONSTRAINT pk_board_no PRIMARY KEY (board_no),
    CONSTRAINT fk_board_user FOREIGN KEY (user_id) REFERENCES project_user_t (user_id),
    CONSTRAINT fk_board_items FOREIGN KEY (items_no2) REFERENCES project_items_t (items_no)
);

---
-- 댓글 테이블
CREATE TABLE project_comments_t (
    comments_no      VARCHAR2(50)     NOT NULL,
    board_no         NUMBER(20)       NOT NULL,
    user_id          VARCHAR2(50)     NOT NULL,
    comments_content VARCHAR2(50)     NULL,
    writer_date      DATE             DEFAULT SYSDATE, -- DEFAULT 추가: 현재 날짜
    CONSTRAINT pk_comments_no PRIMARY KEY (comments_no),
    CONSTRAINT fk_comments_board FOREIGN KEY (board_no) REFERENCES project_board_t (board_no),
    CONSTRAINT fk_comments_user FOREIGN KEY (user_id) REFERENCES project_user_t (user_id)
);

---
-- 구매내역 테이블
CREATE TABLE project_history_t (
    history_no         NUMBER(38, 0)  NOT NULL,
    items_no           NUMBER(38, 0)  NOT NULL,
    user_id            VARCHAR2(50)   NOT NULL,
    history_date       DATE           DEFAULT SYSDATE, -- DEFAULT 추가: 현재 날짜
    history_item_name  VARCHAR2(50)   NOT NULL,
    history_count      VARCHAR2(50)   NOT NULL,
    history_item_totalpay VARCHAR2(50)NOT NULL,
    history_item_image VARCHAR2(1000) NULL,
    history_note       VARCHAR2(50)   NOT NULL,
    CONSTRAINT pk_history_no PRIMARY KEY (history_no),
    CONSTRAINT fk_history_items FOREIGN KEY (items_no) REFERENCES project_items_t (items_no),
    CONSTRAINT fk_history_user FOREIGN KEY (user_id) REFERENCES project_user_t (user_id)
);