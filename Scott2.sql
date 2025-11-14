select *
from tab;

--  사원번호, 급여(sal + comm)
select ename, sal + nvl(comm, 0) as "급여"
from emp;

-- 퀴즈 p.112
select profno
     , name
     , pay
     , nvl(bonus, 0) as bonus
     , to_char(pay*12+nvl(bonus,0),'9,999') as total
from professor
where deptno = 201;

select empno
     , ename
     , sal
     , comm
     , nvl2(comm, sal+comm, sal*0) nvl2
from emp
where deptno = 30;

-- nvl2 퀴즈
select empno
     , ename
     , comm
     , nvl2(comm, 'Exist', 'NULL') as nvl2
from emp
where deptno = 30
order by 1;

-- decode 함수 => 자바스크립트의 삼항연산자와 비슷
select deptno
      ,name
      ,decode(deptno, 101, 'Computer Engieering', 'other') as dname
from professor;

select deptno
      ,name
      ,decode(deptno, 101, decode(name, 'Audie Murphy', 'BEST!')) as "ETC"
from professor;

update professor
set    name = 'Audie Murphy'
where profno = 2001;

-- decode 퀴즈1
select name
      ,jumin
      ,decode(substr(jumin,7,1),1,'man','woman') as "Gender"
from student
where deptno1 = 101;

-- decode 퀴즈2
select name
      ,tel
      ,substr(tel,1,instr(tel,')')-1) num
      ,decode(substr(tel,1,instr(tel,')')-1),'02', 'SEOUL'
                                           ,'031', 'GYEGONGGI'
                                           ,'051', 'BUSAN'
                                           ,'052', 'ULSAN'
                                           ,'055', 'GYEONGNAM') as "LOC"
from student
where deptno1 = 101;

select name
      ,substr(jumin, 3, 2) "Month"
      ,case when substr(jumin, 3, 2) between '01' and '03' then '1/4'
            when substr(jumin, 3, 2) between '04' and '06' then '2/4'
            when substr(jumin, 3, 2) between '07' and '09' then '3/4'
            when substr(jumin, 3, 2) between '10' and '12' then '4/4'
        end as "Quarter"
from student;

-- case문 퀴즈
select empno
      ,ename
      ,sal
      ,case when sal between '1' and '1000' then 'Level 1'
            when sal between '1001' and '2000' then 'Level 2'
            when sal between '2001' and '3000' then 'Level 3'
            when sal between '3001' and '4000' then 'Level 4'
                                               else 'Level 5'
      end as "LEVEL"
from emp
order by sal desc;

select *
from t_reg;



-- 그룹함수
select count(*), count(comm)
from emp;

select count(*) as "인원"
     , sum(sal) as "Total"
     , avg(sal) as "평균"
     , sum(sal) / count(*) as "Average"
     , min(sal) "최소"
     , max(sal) "최고"
     , stddev(sal) as "표준편자"
     , variance(sal) as "분산"
from emp
where job = 'SALESMAN';

select job, deptno, count(job), sum(sal)
from emp
group by job, deptno
order by 2,1;

-- 집계 함수.
-- 부서별, 직무별, 평균급여, 인원
-- 부서별 편균급여, 인원
-- 전체 평균 급여, 인원
select deptno, job, avg(sal) as avg_sal, count(*) as total_member
from emp
group by deptno, job
union all
select deptno, null, round(avg(sal), 1), count(*)
from emp
group by deptno
union all
select null, null, round(avg(sal), 1), count(*)
from emp
order by 1, 2;

select deptno, job, round(avg(sal),1) as "평균급여", count(*) as "인원"
from emp
group by rollup(deptno, job)
order by 1,2;

-- professor -> deptno, position, pay
select deptno, position, sum(pay), count(*)
from professor2
group by rollup(deptno, position)
order by deptno;

create table professor2
as select deptno, position, pay
from professor;

select *
from professor2;
-- 추가.
insert into professor2 values(101, 'instructors', 100);
insert into professor2 values(101, 'a full professor', 100);
insert into professor2 values(101, 'assistant professor', 100);

-- grouping

select grade || '학년', count(*)
from student
group by grade
union all
select deptno1 || '학과', count(*)
from student
group by deptno1;

select grade, deptno1, count(*)
from student
group by grouping sets(grade, deptno1);

-- 학생번호, 이름, 학년, 전공부서명 => James Seo
select s.studno as "학생번호"
      ,s.name as "이름"
      ,s.grade as "학년"
      ,d.dname as "전공부서명"
      ,s.profno as "담당교수_번호"
      ,p.name as "담당교수"
from student s
join department d
on s.deptno1 = d.deptno
join professor p
on s.profno = p.profno
where s.name = 'James Seo';

select * from student;
select * from department;
select * from professor;

-- 시험성적이 90점 이상인 사람의 학번, 이름, 학년, 점수
select s.studno as "학번"
     , s.name as "이름"
     , s.grade as "학년"
     , c.total as "점수"
from student s
join score c
on s.studno = c.studno
where c.total >= 90;

select * from student;
select * from score;

-- 4학년 중 시험점수가 90점이상 A, 80점이상 B, 70점이상 C, 60점이상 D, 그외 F
-- 학번, 이름, 점수, 학점 출력
select s.studno
     , s.name
     , c.total
     --, case when c.total between 90 and  100 then 'A'
            --when c.total between 80 and  89 then 'B'
            --when c.total between 70 and  79 then 'C'
            --when c.total between 60 and  69 then 'D'
              --                              else 'F'
            --end "학점"
            
     , decode(c.total, between 100 and 90, 'A'
                     , between 89 and 80, 'B'
                     , between 79 and 70, 'C'
                     , between 69 and 60, 'D'
                     ,                    'F')
from student s
join score c
on s.studno = c.studno;

select * from student;
select * from score;

-- 학점 점수 join 
select * from hakjum;

select s.*, h.grade
from score s
join hakjum h on s.total between h.min_point and h.max_point;

-- deptno1 = 101 학생들의 학점.
-- 학생번호, 이름, 전공부서명, 점수, 학점 출력.
select s.studno, s.name, d.dname, c.total, h.grade
from student s
join department d
on s.deptno1 = d.deptno
join score c
on s.studno = c.studno
join hakjum h
on c.total between h.min_point and h.max_point
where deptno1 = 101;

select * from student;
select * from department;
select * from score;
select * from hakjum;