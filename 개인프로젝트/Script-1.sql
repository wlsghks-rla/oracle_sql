
-- 개인정보
CREATE TABLE users(
id      varchar2(15) CONSTRAINT users_id_pk PRIMARY KEY,
pw      varchar2(20) CONSTRAINT users_pw_nn NOT NULL,
name    varchar2(10) CONSTRAINT users_name_nn NOT NULL,
address varchar2(25) constraint users_email_nn NOT NULL
);

SELECT * FROM users;
DROP TABLE users;


-- 게시판
CREATE TABLE board(
title varchar2(20) CONSTRAINT board_title_nn NOT NULL ,
author varchar2(10) CONSTRAINT board_author_nn NOT NULL REFERENCES users(id),
dday date DEFAULT sysdate CONSTRAINT board_dday_nn NOT null,
categories varchar2(20) CONSTRAINT board_thing_nn NOT NULL,
variety varchar2(20) CONSTRAINT board_variety_nn NOT NULL,
gender varchar2(20) CONSTRAINT board_gender_nn NOT NULL,
age varchar2(20) CONSTRAINT board_age_nn NOT NULL,
content varchar2(100) CONSTRAINT board_content_nn NOT NULL,
idx number(10) DEFAULT 1 CONSTRAINT board_idx_pk PRIMARY key
);

SELECT * FROM board ORDER BY idx;
ALTER TABLE board
modify( age varchar(20));
truncate TABLE board;


-- sample data(users)
INSERT INTO users
values('tlswkdrn', 'tlswkdrn', '신짱구', 'wkdrn@naver.com' );
INSERT INTO users
values('rlacjftn', 'rlacjftn', '김철수', 'cjftn@gmail.com' );
INSERT INTO users
values('rladbfl', 'rladbfl', '김유리', 'dbfl@gmail.com' );
INSERT INTO users
values('ghdrlfehd', 'ghdrlfehd', '홍길동', 'rlfehd@gmail.com' );

SELECT * FROM users;

DELETE FROM users
WHERE id = 'rladbfl';

-- sample data(board)
INSERT INTO board (title, author, categories, variety, gender, age, content,idx)
values('4번 제목입니다', 'tlswkdrn', '행동 성격', '러시안블루', '남', 3, '1번 내용입니다',(select max(idx) +1 from board));
INSERT INTO board (title, author, categories, variety, gender, age, content,idx)
values('2번 제목입니다', 'rlacjftn', '사료 후기', '먼치킨', '여', 2, '2번 내용입니다', (select max(idx) +1 from board));
INSERT INTO board (title, author, categories, variety, gender, age, content,idx)
values('3번 제목입니다', 'rladbfl', '입양 보호', '코리안숏헤어', '여', 1, '3번 내용입니다', (select max(idx) +1 from board));
INSERT INTO board (title, author, categories, variety, gender, age, content,idx)
values('4번 제목입니다', 'ghdrlfehd', '일상 공유', '아비시니안', '남', 2, '4번 내용입니다', (select max(idx) +1 from board));
INSERT INTO board (title, author, categories, variety, gender, age, content,idx)
values('4번 제목입니다', 'ghdrlfehd', '용품 후기', '아비시니안', '남', 2, '4번 내용입니다', (select max(idx) +1 from board));

SELECT *
FROM board;

--id 중복체크
SELECT count(id)
FROM users
where id = 'tlswkdrn';

-- 로그인
SELECT id,pw
FROM users
where id = 'tlswkdrn'and pw='tlswkdrn';

-- 선택 게시판 목록
SELECT idx, title, author, dday
FROM board
WHERE categories = '일상공유';

SELECT b.*
FROM (SELECT rownum rn, a.title, a.author, a.dday, a.categories
      FROM (SELECT idx, title, author, dday, categories
            FROM board
            WHERE categories = :category OR '전체' = :category 
            ORDER BY IDX) a)b
WHERE b.rn > 0 AND b.rn <= 5 ;


-- 페이징
SELECT b.*
       FROM (SELECT rownum rn, a.title, a.author, a.dday, a.categories
             FROM (SELECT idx, title, author, dday, categories
                   FROM board
                   WHERE categories = :category OR '전체' = :category
                   ORDER BY idx) a ) b
       WHERE b.rn > (:page - 1) * 5
       AND   b.rn <= (:page * 5);

SELECT rownum rn, a.title, a.author, a.dday, a.categories
FROM (SELECT idx, title, author, dday, categories
      FROM board
      WHERE categories = :category OR '전체' = :category 
      ORDER BY IDX)a;