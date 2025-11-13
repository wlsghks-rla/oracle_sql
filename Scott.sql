select *
from tab;

SELECT * FROM emp;

SELECT distinct job || ',' || deptno as "Job And Dept"
FROM emp
order by 1;


SELECT * FROM professor;

SELECT name as "이름"
     , 'good morning!!' as "Message"
     , 3 + 5 as summary
FROM professor;

SELECT PROFNO AS "Prof's No"
     ,name as "Prof's Name"
     ,pay as "Prof Salary"
FROM professor;

select name|| '''s ID: ' || id || ' , ' || 'WEIGHT is' || weight as "ID AND WEIGHT"
from student;

SELECT ENAME || '(' || JOB || ')' || ', ' || ENAME || '''' || JOB || ''''as "NAME AND JOB"
FROM emp
ORDER BY job;

SELECT ename || '''s sal is $' || sal as "Name And Sal"
FROM emp;

select job, ename, sal "현재급여", sal + 500 "인상된급여"
from emp
where job in ('ANALYST', 'SALESMAN');

select *
from professor
minus
select *
from professor
where( pay >= 400 or bonus < 100 );
--order by name;


select *
from emp -- 급여가 2000이 넘는 사람
where sal + nvl(comm, 0) >= 1500
order by comm; --or sal >= 2000;

-- 집합연산자(union)
select studno, name, deptno1, 1 as gubun
from student
union all
select profno, name, deptno, 2
from professor;

select studno, name--, deptno1
from student
where deptno1 = 101
minus
select studno, name--, deptno2
from student
where deptno2 = 201
order by 1;

select * 
from professor;


-- 단일행함수.
select substr(ename,1,2) as "NAME"
from emp;
-- 복수행함수.
select count(*)
from emp; -- 14건

select *
from student;

select name
    ,tel
    ,substr(tel, 1, instr(tel, ')')-1) as "AREA CODE"
FROM student
where deptno1 = 201;