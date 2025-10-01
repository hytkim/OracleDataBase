--SELECT constraint_name, table_name
--FROM user_constraints
--WHERE constraint_name IN ('COMMENTS_BOARD_FK', 'COMMENTS_WRITER_FK');
--
--ALTER TABLE project_board_t DROP CONSTRAINT comments_board_fk;
--ALTER TABLE project_user_t DROP CONSTRAINT comments_writer_fk;
--
--DROP TABLE COMMENTS_T CASCADE CONSTRAINTS PURGE;
-- Sample data inserts for project_user_t

INSERT ALL
  INTO project_user_t (user_id, user_pw, user_name, user_address, user_birth)
    VALUES ('user01', 'pw01', 'Alice',  'Seoul',   TO_DATE('1990-05-12','YYYY-MM-DD'))
  INTO project_user_t (user_id, user_pw, user_name, user_address, user_birth)
    VALUES ('user02', 'pw02', 'Bob',    'Busan',   TO_DATE('1985-11-23','YYYY-MM-DD'))
  INTO project_user_t (user_id, user_pw, user_name, user_address, user_birth)
    VALUES ('admin1','adminpw','Carol','Daegu',   TO_DATE('1978-02-14','YYYY-MM-DD'))
  INTO project_user_t (user_id, user_pw, user_name, user_address, user_birth)
    VALUES ('user03', 'pw03', 'Dave',   'Incheon', TO_DATE('1995-07-30','YYYY-MM-DD'))
  INTO project_user_t (user_id, user_pw, user_name, user_address, user_birth)
    VALUES ('user04', 'pw04', 'Eve',    'Gwangju', TO_DATE('1992-12-05','YYYY-MM-DD'))
SELECT * FROM DUAL;
select * from project_user_t;

update project_user_t
set user_access = 1
where user_id = 'admin1';

-- 1) project_items_t 데이터 삽입 (INSERT ALL)
INSERT ALL
  INTO project_items_t (items_no, user_id, items_name, items_info, items_category, items_price, items_volume, items_image)
    VALUES (1001, 'user01', 'T-Shirt',       '100% Cotton, White',   'Clothing',    20000, 1, '/images/tshirt.jpg')
  INTO project_items_t (items_no, user_id, items_name, items_info, items_category, items_price, items_volume, items_image)
    VALUES (1002, 'user02', 'Wireless Mouse', 'Ergonomic, Black',     'Electronics', 35000, 1, '/images/mouse.jpg')
  INTO project_items_t (items_no, user_id, items_name, items_info, items_category, items_price, items_volume, items_image)
    VALUES (1003, 'admin1','Coffee Mug',     'Ceramic, 300ml',        'Kitchen',     12000, 1, '/images/mug.jpg')
  INTO project_items_t (items_no, user_id, items_name, items_info, items_category, items_price, items_volume, items_image)
    VALUES (1004, 'user03', 'Yoga Mat',       'Non-slip, Blue',        'Sports',      25000, 1, '/images/mat.jpg')
  INTO project_items_t (items_no, user_id, items_name, items_info, items_category, items_price, items_volume, items_image)
    VALUES (1005, 'user04', 'Notebook',       'A5, 100 pages',         'Stationery',   5000, 1, '/images/notebook.jpg')
SELECT * FROM DUAL;


-- 2) project_history_t 데이터 삽입 (INSERT ALL)
INSERT ALL
  INTO project_history_t (history_no, items_no, history_seller, history_buyer, history_item_name, history_count, history_item_totalpay, history_item_image)
    VALUES (5001, 1001, 'user01', 'user02', 'T-Shirt',        '2', '40000', '/images/tshirt.jpg')
  INTO project_history_t (history_no, items_no, history_seller, history_buyer, history_item_name, history_count, history_item_totalpay, history_item_image)
    VALUES (5002, 1002, 'user02', 'user03', 'Wireless Mouse',  '1', '35000', '/images/mouse.jpg')
  INTO project_history_t (history_no, items_no, history_seller, history_buyer, history_item_name, history_count, history_item_totalpay, history_item_image)
    VALUES (5003, 1003, 'admin1','user04', 'Coffee Mug',      '3', '36000', '/images/mug.jpg')
  INTO project_history_t (history_no, items_no, history_seller, history_buyer, history_item_name, history_count, history_item_totalpay, history_item_image)
    VALUES (5004, 1004, 'user03', 'user01', 'Yoga Mat',        '1', '25000', '/images/mat.jpg')
  INTO project_history_t (history_no, items_no, history_seller, history_buyer, history_item_name, history_count, history_item_totalpay, history_item_image)
    VALUES (5005, 1005, 'user04', 'user02', 'Notebook',        '5', '25000', '/images/notebook.jpg')
SELECT * FROM DUAL;


-- 3) project_board_t 데이터 삽입 (INSERT ALL)
INSERT ALL
  INTO project_board_t (board_no, writer, items_no, board_title, board_content)
    VALUES (2001, 'user01', 1002, '제품 문의', '이 마우스 블랙 외에 화이트는 없나요?')
  INTO project_board_t (board_no, writer, items_no, board_title, board_content)
    VALUES (2002, 'user02', 1001, '사이즈 문의', 'L 사이즈가 있나요?')
  INTO project_board_t (board_no, writer, items_no, board_title, board_content)
    VALUES (2003, 'admin1',1003, '재고 문의', '머그컵 재고가 얼마나 남았나요?')
  INTO project_board_t (board_no, writer, items_no, board_title, board_content)
    VALUES (2004, 'user03', 1004, '배송 문의', '요가 매트 언제 배송되나요?')
  INTO project_board_t (board_no, writer, items_no, board_title, board_content)
    VALUES (2005, 'user04', 1005, '할인 문의', '노트북이 할인 중인가요?')
SELECT * FROM DUAL;


-- 4) project_comments_t 데이터 삽입 (INSERT ALL)
INSERT ALL
  INTO project_comments_t (comments_no, board_no, writer, comments_content)
    VALUES (3001, 2001, 'admin1', '화이트 색상도 곧 입고 예정입니다.')
  INTO project_comments_t (comments_no, board_no, writer, comments_content)
    VALUES (3002, 2001, 'user02',  '알려주셔서 감사합니다!')
  INTO project_comments_t (comments_no, board_no, writer, comments_content)
    VALUES (3003, 2002, 'admin1', 'L 사이즈는 다음 주 재입고 예정입니다.')
  INTO project_comments_t (comments_no, board_no, writer, comments_content)
    VALUES (3004, 2004, 'admin1', '오늘 발송 처리되었습니다.')
  INTO project_comments_t (comments_no, board_no, writer, comments_content)
    VALUES (3005, 2005, 'admin1', '현재 할인 프로모션은 없습니다.')
SELECT * FROM DUAL;
