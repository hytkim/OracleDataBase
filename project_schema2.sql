DROP TABLE project_comments_t CASCADE CONSTRAINTS PURGE;
DROP TABLE project_board_t CASCADE CONSTRAINTS PURGE;
DROP TABLE project_history_t CASCADE CONSTRAINTS PURGE;
DROP TABLE project_items_t CASCADE CONSTRAINTS PURGE;
DROP TABLE project_user_t CASCADE CONSTRAINTS PURGE;


CREATE TABLE project_user_t (
    user_id         VARCHAR2(50) CONSTRAINT project_user_pk PRIMARY KEY,
    user_pw         VARCHAR2(100) NOT NULL,
    user_name       VARCHAR2(50) UNIQUE NOT NULL,
    user_address    VARCHAR2(50),
    user_birth      DATE,
    user_create_date DATE DEFAULT SYSDATE,
    user_grade      NUMBER(1, 0) DEFAULT 1,
    user_access     NUMBER(1, 0) DEFAULT 0, -- 0=user, 1=admin
    user_point      NUMBER(38, 0) DEFAULT 1000,
    user_mileage    NUMBER(1, 0) DEFAULT 0
);

CREATE TABLE project_items_t (
    items_no        NUMBER(38, 0) CONSTRAINT project_items_pk PRIMARY KEY,
    user_id         VARCHAR2(50) NOT NULL,
    items_name      VARCHAR2(50) NOT NULL,
    items_info      VARCHAR2(1000),
    items_category  VARCHAR2(100),
    items_date      DATE DEFAULT SYSDATE,
    items_price     NUMBER(10) NOT NULL,
    items_volume    NUMBER(10),
    items_image     VARCHAR2(1000),
    CONSTRAINT items_user_fk FOREIGN KEY (user_id) REFERENCES project_user_t(user_id)
);

CREATE TABLE project_history_t (
    history_no          NUMBER(38, 0) CONSTRAINT project_history_pk PRIMARY KEY,
    items_no            NUMBER(38, 0) NOT NULL,
    history_seller      VARCHAR2(50) NOT NULL,
    history_buyer       VARCHAR2(50) NOT NULL,
    history_date        DATE DEFAULT SYSDATE,
    history_item_name   VARCHAR2(50) NOT NULL,
    history_count       VARCHAR2(50) NOT NULL,
    history_item_totalpay VARCHAR2(50) NOT NULL,
    history_item_image  VARCHAR2(1000),
    CONSTRAINT history_items_fk FOREIGN KEY (items_no) REFERENCES project_items_t(items_no),
    CONSTRAINT history_seller_fk FOREIGN KEY (history_seller) REFERENCES project_user_t(user_id),
    CONSTRAINT history_buyer_fk FOREIGN KEY (history_buyer) REFERENCES project_user_t(user_id)
);

CREATE TABLE project_board_t (
    board_no        NUMBER(10) CONSTRAINT project_board_pk PRIMARY KEY,
    writer          VARCHAR2(50) NOT NULL,
    items_no        NUMBER(38, 0) NOT NULL,
    board_title     VARCHAR2(50) NOT NULL,
    board_content   VARCHAR2(1000) NOT NULL,
    writer_date     DATE DEFAULT SYSDATE,
    CONSTRAINT board_writer_fk FOREIGN KEY (writer) REFERENCES project_user_t(user_id),
    CONSTRAINT board_items_fk FOREIGN KEY (items_no) REFERENCES project_items_t(items_no)
);

CREATE TABLE project_comments_t (
    comments_no         NUMBER(10) CONSTRAINT project_comments_pk PRIMARY KEY,
    board_no            NUMBER(10) NOT NULL,
    writer              VARCHAR2(50) NOT NULL,
    comments_content    VARCHAR2(1000),
    writer_date         DATE DEFAULT SYSDATE,
    CONSTRAINT comments_board_fk FOREIGN KEY (board_no) REFERENCES project_board_t(board_no),
    CONSTRAINT comments_writer_fk FOREIGN KEY (writer) REFERENCES project_user_t(user_id)
);


select * from project_user_t;
select * from project_items_t;
select * from project_history_t;
select * from project_board_t;
select * from project_comments_t;