-- Structure Query Language.
select *
from tab;
-- 사원정보(employees 테이블)
SELECT employee_id
      , first_name
      , last_name -- 컬럼.(오라클은 대소문자 구분x, 두단어의 조합은 언더바사용)
      , salary
      , email
      , hire_date
FROM employees; -- 테이블.

select hire_date
from employees;

-- 1. 입사일자 :2000년 이후인 사원조회.
select *
from employees
where hire_date >= '000101';

-- 2. salary가 10000인 이상인데 입사일자가 2000년대 이후인 사원.
select *
from employees
where salary >= 10000
and hire_date >= '000101';

-- 3. 이름(first)이 5글자인 사원
select *
from employees
where first_name like '_____';
-- 4. 급여(salary, salarty + 보너스)의 10000 이상인 사원.
select *
from employees
where salary >= 10000
or (salary +salary *commission_pct) >= 10000;

-- 문자함수.
SELECT length(initcap(lower(first_name))) as "소문자크기", upper(last_name) as "대문자"
FROM employees;

select length('홍길동') as lnth, lengthb('홍길동') as lnthb
from dual; -- 더미 테이블(단순히 출력용) : dual

select *
from employees
where length(first_name) > 5;

select employee_id, concat(concat(first_name, ','),last_name) as "Name"
from employees
where length(first_name) > 5;

select *
from employees
where substr(first_name,1,2) = 'El';

select first_name,instr(upper(first_name), 'S')
from employees;

select first_name, rpad(first_name, 10, '*') as "Lpad"
from employees;

select first_name, ltrim(first_name, 'E') as "ltrim"
from employees;

select first_name, replace(rpad(first_name, 10, '*'), '*', '-') as "Lpad"
from employees;

