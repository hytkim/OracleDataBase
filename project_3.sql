-- 1. project_user_t (필수 컬럼: user_id, user_pw, user_name, user_birth)
-- admin은 판매자, user1~user4는 일반 구매자로 설정
INSERT INTO project_user_t (user_id, user_pw, user_name, user_birth, user_access)
VALUES ('admin', 'p_admin', '관리자', TO_DATE('1980-01-01', 'YYYY-MM-DD'), 1); -- 판매자/어드민
INSERT INTO project_user_t (user_id, user_pw, user_name, user_birth)
VALUES ('user1', 'p_user1', '김사용', TO_DATE('1990-03-01', 'YYYY-MM-DD'));
INSERT INTO project_user_t (user_id, user_pw, user_name, user_birth)
VALUES ('user2', 'p_user2', '이구매', TO_DATE('1995-05-01', 'YYYY-MM-DD'));
INSERT INTO project_user_t (user_id, user_pw, user_name, user_birth)
VALUES ('user3', 'p_user3', '박회원', TO_DATE('2000-10-10', 'YYYY-MM-DD'));
INSERT INTO project_user_t (user_id, user_pw, user_name, user_birth)
VALUES ('user4', 'p_user4', '최회원', TO_DATE('1975-12-25', 'YYYY-MM-DD'));

-- 2. project_discount_t (필수 컬럼: items_category)
INSERT INTO project_discount_t (items_category, discount_percent) VALUES ('가전', 10.00);
INSERT INTO project_discount_t (items_category, discount_percent) VALUES ('의류', 5.50);
INSERT INTO project_discount_t (items_category, discount_percent) VALUES ('식품', 0.00);
INSERT INTO project_discount_t (items_category, discount_percent) VALUES ('도서', 15.00);
INSERT INTO project_discount_t (items_category, discount_percent) VALUES ('가구', 0.00);

-- 3. project_items_t (필수 컬럼: items_no, user_id, items_category, items_price)
-- user_id는 'admin'이 판매자로 등록
INSERT INTO project_items_t (items_no, user_id, items_category, items_name, items_price)
VALUES (items_seq.NEXTVAL, 'admin', '가전', '스마트TV', 1500000);
INSERT INTO project_items_t (items_no, user_id, items_category, items_name, items_price)
VALUES (items_seq.NEXTVAL, 'admin', '의류', '프리미엄 코트', 250000);
INSERT INTO project_items_t (items_no, user_id, items_category, items_name, items_price)
VALUES (items_seq.NEXTVAL, 'admin', '식품', '유기농 쌀', 50000);
INSERT INTO project_items_t (items_no, user_id, items_category, items_name, items_price)
VALUES (items_seq.NEXTVAL, 'admin', '도서', 'Oracle SQL', 30000);
INSERT INTO project_items_t (items_no, user_id, items_category, items_name, items_price)
VALUES (items_seq.NEXTVAL, 'admin', '가구', '원목 책상', 120000);

-- 4. project_board_t (필수 컬럼: board_no, user_id, items_no2, board_title, board_content)
-- user_id는 'user1', 'user2', 'user3' 등 구매자 사용
INSERT INTO project_board_t (board_no, user_id, items_no2, board_title, board_content)
VALUES (board_seq.NEXTVAL, 'user1', 1, 'TV 구매 후기', '화질 정말 선명하고 좋네요.');
INSERT INTO project_board_t (board_no, user_id, items_no2, board_title, board_content)
VALUES (board_seq.NEXTVAL, 'user2', 2, '사이즈 문의', '코트 L사이즈 재고 있나요?');
INSERT INTO project_board_t (board_no, user_id, items_no2, board_title, board_content)
VALUES (board_seq.NEXTVAL, 'user3', 3, '쌀 배송문의', '언제쯤 도착할까요?');
INSERT INTO project_board_t (board_no, user_id, items_no2, board_title, board_content)
VALUES (board_seq.NEXTVAL, 'user1', 4, '책 내용 질문', '6장 부분이 이해가 안돼요.');
INSERT INTO project_board_t (board_no, user_id, items_no2, board_title, board_content)
VALUES (board_seq.NEXTVAL, 'user2', 5, '책상 사용 후기', '조립이 조금 힘들었지만 만족합니다.');

-- 5. project_comments_t (필수 컬럼: comments_no, board_no, user_id)
INSERT INTO project_comments_t (comments_no, board_no, user_id, comments_content)
VALUES (TO_CHAR(comments_seq.NEXTVAL), 1, 'admin', '감사합니다!');
INSERT INTO project_comments_t (comments_no, board_no, user_id, comments_content)
VALUES (TO_CHAR(comments_seq.NEXTVAL), 2, 'user4', '저도 L사이즈 고민 중이에요.');
INSERT INTO project_comments_t (comments_no, board_no, user_id, comments_content)
VALUES (TO_CHAR(comments_seq.NEXTVAL), 3, 'admin', '내일 출고 예정입니다.');
INSERT INTO project_comments_t (comments_no, board_no, user_id, comments_content)
VALUES (TO_CHAR(comments_seq.NEXTVAL), 4, 'user3', '유튜브에서 관련 강의를 찾아보세요.');
INSERT INTO project_comments_t (comments_no, board_no, user_id, comments_content)
VALUES (TO_CHAR(comments_seq.NEXTVAL), 5, 'admin', '조립 불편을 드려 죄송합니다.');

-- 6. project_history_t (필수 컬럼: history_no, items_no, user_id)
INSERT INTO project_history_t (history_no, items_no, user_id, history_item_name, history_count, history_item_totalpay)
VALUES (history_seq.NEXTVAL, 1, 'user1', '스마트TV', '1', '1500000');
INSERT INTO project_history_t (history_no, items_no, user_id, history_item_name, history_count, history_item_totalpay)
VALUES (history_seq.NEXTVAL, 2, 'user2', '프리미엄 코트', '2', '500000');
INSERT INTO project_history_t (history_no, items_no, user_id, history_item_name, history_count, history_item_totalpay)
VALUES (history_seq.NEXTVAL, 3, 'user3', '유기농 쌀', '1', '50000');
INSERT INTO project_history_t (history_no, items_no, user_id, history_item_name, history_count, history_item_totalpay)
VALUES (history_seq.NEXTVAL, 4, 'user1', 'Oracle SQL', '1', '30000');
INSERT INTO project_history_t (history_no, items_no, user_id, history_item_name, history_count, history_item_totalpay)
VALUES (history_seq.NEXTVAL, 5, 'user2', '원목 책상', '1', '120000');



select d.discount_percent, i.items_price, i.items_name, h.history_item_image
                  FROM project_items_t i
                  JOIN project_discount_t d
                      ON i.items_category = d.items_category
                  JOIN project_history_t h
                      ON i.items_no = h.items_no
                  WHERE h.history_note != '입고';