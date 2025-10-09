------------------------------------------------
-- 1. 사용자 (project_user_t)
------------------------------------------------
INSERT INTO project_user_t (user_id, user_pw, user_name, user_birth, user_access)
VALUES ('admin', 'p_admin', '관리자', TO_DATE('1980-01-01', 'YYYY-MM-DD'), 1); -- 판매자/관리자

INSERT INTO project_user_t (user_id, user_pw, user_name, user_birth)
VALUES ('user1', 'p_user1', '김사용', TO_DATE('1990-03-01', 'YYYY-MM-DD'));
INSERT INTO project_user_t (user_id, user_pw, user_name, user_birth)
VALUES ('user2', 'p_user2', '이구매', TO_DATE('1995-05-01', 'YYYY-MM-DD'));
INSERT INTO project_user_t (user_id, user_pw, user_name, user_birth)
VALUES ('user3', 'p_user3', '박회원', TO_DATE('2000-10-10', 'YYYY-MM-DD'));
INSERT INTO project_user_t (user_id, user_pw, user_name, user_birth)
VALUES ('user4', 'p_user4', '최회원', TO_DATE('1975-12-25', 'YYYY-MM-DD'));


------------------------------------------------
-- 2. 할인정보 (project_discount_t)
------------------------------------------------
INSERT INTO project_discount_t (items_category, discount_percent) VALUES ('가전', 0.9);
INSERT INTO project_discount_t (items_category) VALUES ('의류');
INSERT INTO project_discount_t (items_category, discount_percent) VALUES ('식품', 0.1);
INSERT INTO project_discount_t (items_category, discount_percent) VALUES ('도서', 0.2);
INSERT INTO project_discount_t (items_category, discount_percent) VALUES ('가구', 0.5);


------------------------------------------------
-- 3. 상품 (project_items_t)
------------------------------------------------
INSERT INTO project_items_t (items_no, user_id, items_category, items_name, items_price, items_info)
VALUES (items_seq.NEXTVAL, 'admin', '가전', '스마트TV', 1500000, '최신형 OLED 스마트 TV');
INSERT INTO project_items_t (items_no, user_id, items_category, items_name, items_price, items_info)
VALUES (items_seq.NEXTVAL, 'admin', '의류', '프리미엄 코트', 250000, '겨울용 프리미엄 울 코트');
INSERT INTO project_items_t (items_no, user_id, items_category, items_name, items_price, items_info)
VALUES (items_seq.NEXTVAL, 'admin', '식품', '유기농 쌀', 50000, '10kg 포장 유기농 쌀');
INSERT INTO project_items_t (items_no, user_id, items_category, items_name, items_price, items_info)
VALUES (items_seq.NEXTVAL, 'admin', '도서', 'Oracle SQL 완벽 가이드', 30000, 'DB 입문자를 위한 SQL 가이드');
INSERT INTO project_items_t (items_no, user_id, items_category, items_name, items_price, items_info)
VALUES (items_seq.NEXTVAL, 'admin', '가구', '원목 책상', 120000, '자연 원목으로 만든 견고한 책상');


------------------------------------------------
-- 4. 게시판 (project_board_t)
------------------------------------------------
INSERT INTO project_board_t (board_no, user_id, items_no, board_title, board_content)
VALUES (board_seq.NEXTVAL, 'user1', 1, 'TV 구매 후기', '화질이 정말 선명하고 음질도 좋아요!');
INSERT INTO project_board_t (board_no, user_id, items_no, board_title, board_content)
VALUES (board_seq.NEXTVAL, 'user2', 2, '사이즈 문의', '코트 L사이즈 재고 있나요?');
INSERT INTO project_board_t (board_no, user_id, items_no, board_title, board_content)
VALUES (board_seq.NEXTVAL, 'user3', 3, '배송문의', '쌀 주문했는데 언제 도착할까요?');
INSERT INTO project_board_t (board_no, user_id, items_no, board_title, board_content)
VALUES (board_seq.NEXTVAL, 'user1', 4, '책 질문', '6장 예제 부분이 이해가 안됩니다.');
INSERT INTO project_board_t (board_no, user_id, items_no, board_title, board_content)
VALUES (board_seq.NEXTVAL, 'user2', 5, '책상 후기', '조립이 좀 힘들었지만 완성품은 만족합니다.');


------------------------------------------------
-- 5. 댓글 (project_comments_t)
------------------------------------------------
INSERT INTO project_comments_t (comments_no, board_no, user_id, comments_content)
VALUES (comments_seq.NEXTVAL, 1, 'admin', '좋은 후기 감사합니다!');
INSERT INTO project_comments_t (comments_no, board_no, user_id, comments_content)
VALUES (comments_seq.NEXTVAL, 1, 'user4', '저도 같은 모델 샀어요!');
INSERT INTO project_comments_t (comments_no, board_no, user_id, comments_content)
VALUES (comments_seq.NEXTVAL, 2, 'admin', 'L사이즈 재고 있습니다 :)');
INSERT INTO project_comments_t (comments_no, board_no, user_id, comments_content)
VALUES (comments_seq.NEXTVAL, 3, 'admin', '배송은 내일 도착 예정입니다.');
INSERT INTO project_comments_t (comments_no, board_no, user_id, comments_content)
VALUES (comments_seq.NEXTVAL, 5, 'user3', '저도 이 책상 사용 중인데 정말 좋아요!');


------------------------------------------------
-- 6. 구매내역 (project_history_t)
------------------------------------------------
INSERT INTO project_history_t (history_no, items_no, user_id, history_item_name, history_count, history_item_totalpay, history_note, history_address)
VALUES (history_seq.NEXTVAL, 1, 'user1', '스마트TV', '1', '1500000', '출고', '서울시 강남구 테헤란로 123');
INSERT INTO project_history_t (history_no, items_no, user_id, history_item_name, history_count, history_item_totalpay, history_note, history_address)
VALUES (history_seq.NEXTVAL, 2, 'user2', '프리미엄 코트', '1', '250000', '출고', '부산시 해운대구 센텀중앙로 456');
INSERT INTO project_history_t (history_no, items_no, user_id, history_item_name, history_count, history_item_totalpay, history_note, history_address)
VALUES (history_seq.NEXTVAL, 3, 'admin', '유기농 쌀', '2', '100000', '입고', '물류센터 A동');
INSERT INTO project_history_t (history_no, items_no, user_id, history_item_name, history_count, history_item_totalpay, history_note, history_address)
VALUES (history_seq.NEXTVAL, 4, 'user1', 'Oracle SQL 완벽 가이드', '1', '30000', '출고', '서울시 강남구 테헤란로 123');
INSERT INTO project_history_t (history_no, items_no, user_id, history_item_name, history_count, history_item_totalpay, history_note, history_address)
VALUES (history_seq.NEXTVAL, 5, 'user2', '원목 책상', '1', '120000', '출고', '부산시 해운대구 센텀중앙로 456');


update project_history_t h
set h.history_item_image = 'logo.png';

update project_items_t i
set i.items_image = 'logo.png';

select * from project_history_t;
select * from project_user_t;
select * from project_items_t;
select * from project_board_t;
select * from project_comments_t;


select d.discount_percent
    , i.items_price
    , i.items_name
    , i.items_category
    , h.history_item_image
                  FROM project_items_t i
                  JOIN project_discount_t d
                      ON i.items_category = d.items_category
                  JOIN project_history_t h
                      ON i.items_no = h.items_no
                  WHERE h.history_note != '입고';

INSERT INTO project_user_t (user_id, user_pw, user_name,user_address, user_birth)
VALUES ('user5', 'user5', '랆쥐','람각' ,TO_DATE('1999-09-09', 'YYYY-MM-DD'));
       
commit;