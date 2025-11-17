-- left outer
select s.studno "학번"
      ,s.name "학생이름"
      ,p.profno "교수번호"
      ,p.name "교수명"
from student s
left outer join professor p
on s.profno = p.profno
order by 1;
-- oralce 기준
select s.studno "학번"
      ,s.name "학생이름"
      ,p.profno "교수번호"
      ,p.name "교수명"
from student s, professor p
where s.profno = p.profno(+);


-- rigtht outer
select p.profno "교수번호"
      ,p.name "교수명"
      ,s.studno "학번"
      ,s.name "학생이름"
from professor p
right join student s
on p.profno = s.profno;
-- oracle 기준
select s.studno "학번"
      ,s.name "학생이름"
      ,p.profno "교수번호"
      ,p.name "교수명"
from student s, professor p
where s.profno(+) = p.profno;


-- full outer
select s.studno "학번"
      ,s.name "학생이름"
      ,p.profno "교수번호"
      ,p.name "교수명"
from student s
full outer join professor p
on s.profno = p.profno
order by 1;
-- oracle 기준
select s.studno "학번"
      ,s.name "학생이름"
      ,p.profno "교수번호"
      ,p.name "교수명"
from student s, professor p
where s.profno = p.profno(+)
union
select s.studno "학번"
      ,s.name "학생이름"
      ,p.profno "교수번호"
      ,p.name "교수명"
from student s, professor p
where s.profno(+) = p.profno;
;

-- self join(p.250)
SELECT *
FROM emp;

-- 연습문제 p.254
-- 1.
SELECT s.name "STU_NAME",s.deptno1 "DEPTNO1", d.dname "DEPT_NAME"
FROM student s
join department d on s.deptno1 = d.deptno;

-- 2.
SELECT e.name "NAME"
     , e.position "POSITION"
     , TO_CHAR(e.pay,'99,999,999') "PAY"
     , TO_CHAR(p.s_pay, '99,999,999') "Low PAY"
     , TO_CHAR(p.e_pay, '99,999,999') "High PAY"
FROM emp2 e
join p_grade p on e.position = p.position;

-- 3.
SELECT e.name
      ,trunc(months_between(add_months(sysdate,-144),e.birthday)/12) "AGE"
      , e.position curr_positon
      , p.position be_positon
             
FROM emp2 e
JOIN p_grade p ON trunc(months_between(add_months(sysdate,-144),e.birthday)/12) between p.s_age and p.e_age
order by 2;

 -- 4.
SELECT c.gname
     , c.point
     , g.gname gift_name
FROM customer c
join gift g on c.point >= g.g_start and g.gname = 'Notebook'  ;

SELECT *
FROM gift;

select *
from customer;

-- 5.
select p.profno, p.name, p.hiredate, count(pp.hiredate)
from professor p
left outer join professor pp on p.hiredate > pp.hiredate
group by p.profno, p.name, p.hiredate
order by 4;

select *
from professor
order by 6;

-- 6.
select e.empno, e.ename, e.hiredate, count(*) 
from emp e
left outer join emp e2 on e.hiredate > e2.hiredate
group by e.empno, e.ename, e.hiredate
order by e.hiredate;




-- DDL
-- 상품 (상품명, 상품코드, 금액, 날짜.....)
-- product / product_name(100), product_code(5), price(10), product_date
drop table product2; (
prodcut_name varchar2(100),
prodcut_code char(5),
price        number(10),
product_date date
);

select *
from product2;

-- 게시판 테이블 생성. board
-- 글번호(board_id), 제목(title), 내용(content), 작성자(author), 작성일시(created_at), 좋아요(like_it)
drop table board purge; -- purge 옵션은 tab테이블에도 안남음.(사용 x)
create table board (
 board_id number primary key, -- 중복x
 title    varchar2(100) not null,
 content  varchar2(1000) not null,
 author   varchar2(20) not null, -- 값 없으면 생성x
 created_at date default sysdate -- 값이 없으면 현재날짜를 넣음.
);

alter table board
add like_it number default 1; -- like처럼 키위드는 사용 불가. / 기본값 1

alter table board
rename column like_it to stars; -- like_it에서 변경

alter table board
drop column stars; -- 만든 컬럼 삭제.

select *
from board
order by 1;

-- 입력.
insert into board(board_id, title, content, author, created_at)
values(1, '제목2입니다', '내용1입니다', 'user01', sysdate );

insert into board -- 칼럼에 내용을 다 넣는다는 뜻.
values ((select max(board_id) +1 from board) , '2번 제목', '2번 내용', 'user01', sysdate);
-- id가 자동으로 1씩 늘어남.

update board
set    title = '제목3입니다',
       content = '내용3입니다' -- .넣으면 구문 에러남.
where board_id = 3;

update board
set    author = 'user02'
where board_id in(5,6,7);

-- 8,9,10번이  title, content가 각각 번호 들어가게 변경
update board
set    title = board_id || '번 제목',
       content = board_id || '번 내용'
where author = 'user03';

-- 삭제.
delete from board
where board_id = 11;

truncate table board;

select *
from tab; --table한 내용이 bin으로 저장됨 

commit; -- 접속한 사람들이 내가 추가한 데이터를 볼 수 있음
rollback; -- 삭제된 정보가 되돌려짐.

