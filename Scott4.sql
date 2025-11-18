-- 어제 삭제 내용 완전 삭제.
select 'purge table '|| '"' || tname || '";'
from tab
where tname like 'BIN%';

purge table "BIN$QnEH5N5FSm2y+DZz3x8U3A==$0";
purge table "BIN$hcgakcOrToWUlYaWovW+Tg==$0";
purge table "BIN$n132Nzh2TGCaioMk++GjLQ==$0";
purge table "BIN$qwmMxM3gQauzPt66Kjv5Bw==$0";
purge table "BIN$uN1bcljbTuWkk5ZlkBaXIA==$0";

select *
from tab;

create table professor4
as 
select profno, name, pay
from professor
where 1=2;

insert into professor4
select *
from professor3;

select *
from professor4;

rollback;
-- 커밋 없어도 프로페서5번 테이블 만든 시점에서 자동 커밋 돼서 저장됨.

create table professor5
as
select * from professor4;


select *
from professor3;
select *
from professor4;

truncate table professor3;
truncate table professor4;

insert all
--when profno between 1000 and 2999 then
     into professor3 values(profno, name, pay)
--when profno between 3000 and 4999 then
     into professor4 values(profno, name, pay)
select profno, name, pay
from professor;

-- update.
select *
from professor
where position = 'assistant professor';

update professor
set    bonus = nvl(bonus, 0) + 200
where position = 'assistant professor';

-- 사용예2
select *
from professor
where position = (select position
                 from professor
                 where name = 'Sharon Stone');
                 --and pay <250;

update professor
set pay = pay * 1.15
where position = (select position
                 from professor
                 where name = 'Sharon Stone')
                 and pay <250;
                 
    
-- merge p.301
create table charge_01(
u_date varchar2(6),
cust_no number,
u_tiume number,
charge number
);
create table charge_02(
u_date varchar2(6),
cust_no number,
u_tiume number,
charge number
);
create table ch_total(
u_date varchar2(6),
cust_no number,
u_tiume number,
charge number
);

insert into charge_01 values('141001', 1000, 2, 1000);
insert into charge_01 values('141001', 2000, 2, 1000);
insert into charge_02 values('141002', 4000, 2, 1000);
insert into charge_02 values('141002', 4000, 2, 1000);

merge into ch_total total
using charge_02 ch01
on (total.u_date = ch01.u_date) -- 중복 X (primary key)
when matched then
update set total.cust_no = ch01.cust_no
when not matched then
insert values(ch01.u_date, ch01.cust_no, ch01.u_time, ch01.charge);

select * from charge_01;
select * from charge_02;
select * from ch_total;

rollback;

alter table ch_total rename column u_tiume to u_time;

-- update join
select e.*
from emp e
join dept d on e.deptno = d.deptno
where d.loc != 'DALLAS';

update emp e
set    sal = sal * 1.1
where not exists (select 1
              from dept d
              where e.deptno = d.deptno
              and d.loc = 'DALLAS');



select *
from dept;

-- 연습문제
-- 1.
select *
from dept2;

insert into dept2
values( '9010', 'temp_10', '1006', 'temp area');

-- 2.
insert into dept2(dcode, dname, pdept)
values('9020', 'temp_20', '1006');

-- 3.
insert all
when profno <= 3000 then
into  professor4 values(profno, name, pay)
select profno, name, pay
from professor;

select *
from professor4;

-- 4.
select *
from professor
where professor.name = 'Sharon Stone';

update professor
set bonus = 100
where professor.name = 'Sharon Stone';

-- p.327
create table new_emp1(
no number(4) constraint emp1_no_pk primary key,
name varchar2(20) constraint emp1_name_nn not null,
jumin varchar2(13)constraint emp1_jumin_nn not null
                  constraint emp1_jumin_uk unique,
loc_code number(1) constraint emp1_area_ck check(loc_code < 5),
deptno varchar2(6) constraint emp1_deptno_fk references dept2(dcode)
);

alter table new_emp1
add constraint emp1_name_nk unique(name); -- 이미 있는 값이 unique 해야 작동됨.

insert into new_emp1 (no, name, jumin, loc_code,deptno)
values(2000, 'null', '11112',4, 1011);

update new_emp1
set name = 'null2'
where no = 2000;

select *
from new_emp1;
select *
from dept2;

delete from dept2
where dcode = '1011'; -- new_emp1에서 참조중이여서 불가. -> 변경 후 진행하면 진행됨.

-- 연습 문제 p.353
-- 1.
create table tcons(
no number(5) constraint tcons_no_pk primary key,
name varchar2(20) constraint tcons_name_nn not null,
jumin varchar2(13) constraint tcons_jumin_nn not null
                   constraint tcons_jumin_uk unique,
area number(1) constraint tcons_area_ck check ( area >= 1 and area <= 4),
deptno varchar2(6) constraint tcons_deptno_fk references dept2(dcode)
);

-- 2.
alter table tcons
add constraint tcons_name_uk unique(name);

-- 3.



-- index
create unique index idx_emp_name
on emp(ename);

select *
from emp; -- 실행계획 세움(f10) full scan

select /*+ INDEX(e SYS_C008401) */ *
from emp e
where e.empno > 1000;














-- view : table x, 쿼리 -> 조회용으로 많이 사용, 테이블은 업데이트등 종합
-- view 생성권한(관리자)
create or replace view emp_dept_v as -- create or replace로 수정 가능
select e.empno, e.ename, e.sal,e.job, d.dname, d.loc, e.mgr
from emp e
join dept d on e.deptno = d.deptno;

select v.*, e.ename
from emp_dept_v v
join emp e on v.mgr = e.empno
where v.sal > 2000;

select *
from tab; -- 전체 목록 검색(veiw는 테이블로 안나옴_)

-- inline view
select a.deptno, a.sal, d.dname
from (select deptno, max(sal) sal
      from emp
      group by deptno) a
join dept d on a.deptno = d.deptno;

-- p.420 연습문제2.
select d.dname, s.max_height, s.max_weight
from (select deptno1, max(height) max_height, max(weight) max_weight
      from student
      group by deptno1) s
join department d on s.deptno1 = d.deptno;

select *
from student;

select *
from department;

-- 3.
select d.dname, height max_height, name, height
from (select name, height, deptno1
      from student
      where (deptno1, height) in (select deptno1, max(height)
                                  from student
                                  group by deptno1)) s
join department d on s.deptno1 = d.deptno;

select d.dname, height max_height, name, height
from (SELECT name, height, deptno1,
      -- 각 부서(deptno1) 내에서 height를 기준으로 순위 매기기
      RANK() OVER (PARTITION BY deptno1 ORDER BY height DESC) AS rnk
      FROM student) a
join department d on a.deptno1 = d.deptno
where a.rnk = 1;






-- sequence p.464
select *
from emp;

create sequence emp_seq
--increment by 100
--start with 7990
minvalue 1
maxvalue 10
cycle
cache 2;
drop sequence emp_seq;

select emp_seq.nextval from dual;

/*
-- 프로시저 : 커리를 순차적 진행
create or replace procedure re_seq(sname in varchar2)--, bname out varchar2) -- 1번째 입력받는, 2번째 출력되는
is
  val number; -- 변수선언.
begin
  execute immediate 'select ' || sname || '.nextval from dual' into val;
  execute immediate 'alter sequence ' || sname || ' increment by  -' || val || 'minvalue 0';
  execute immediate 'select ' || sname || '.nextval from dual' into val;
  execute immediate 'alter sequence ' || sname || ' increment by 1 minvalue 0';
end;*/

begin
 --조건문 입력시 자동실행.
  re_seq('emp_seq');
end;

-- synonym(관리자 권한에서 부여)
create public synonym proff for professor; -- synonym : private와 같음.

select *
from prof;

grant select on professor to hr;

