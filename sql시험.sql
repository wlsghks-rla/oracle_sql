-- 1.
SELECT employee_id "사원번호"
      ,last_name "이름"
      ,salary "급여"
      ,department_id "부서번호" 
FROM employees
WHERE salary >= 7000 
AND salary <= 12000
AND last_name LIKE 'H%';

-- 2.
SELECT employee_id "사원번호"
      ,last_name "이름"
      ,job_id "업무"
      ,salary "급여"
      ,department_id "부서번호"
FROM employees
WHERE department_id = 50
      OR department_id = 60
      AND salary > 5000
order by 5 desc;
-- 3.
SELECT last_name "사원이름"
      ,salary "급여"
      ,CASE WHEN salary <= 5000 THEN salary * 1.2
            WHEN salary <= 10000 THEN salary * 1.15
            WHEN salary <= 15000 THEN salary * 1.1
            WHEN salary >= 15001 THEN salary 
       END "인상된 급여"
FROM employees
WHERE employee_id = :employee_id;

-- 4.
SELECT d.department_id "부서번호"
      ,d.department_name "부서이름"
      ,l.city "도시명"
FROM departments d
JOIN locations l ON d.location_id = l.location_id;


-- 5.
SELECT employee_id "사원번호"
      ,last_name "이름"
      ,job_id "업무"
FROM employees
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE DEPARTMENT_NAME = 'IT');

-- 6.
SELECT employee_id
      ,first_name
      ,last_name
      ,email
      ,phone_number
      ,TO_CHAR(hire_date, 'DD-MON-RR') hire_date
      ,job_id
FROM employees
WHERE TO_CHAR(hire_date,'yyyy') < 2014
AND job_id ='ST_CLERK';

-- 7.
SELECT last_name, job_id, salary, commission_pct
FROM employees
ORDER BY 3 desc;

-- 8.
drop table prof;
CREATE TABLE prof
 (profno   number(4),
  name     varchar2(15)
           CONSTRAINT profno_name_nn NOT NULL,
  id       varchar2(15)
           CONSTRAINT profno_id_nn NOT NULL,
  hiredate date,
  pay      number(4));

COMMIT;

-- 9.
INSERT INTO prof
VALUES( 1001, 'Mark', 'm1001', '07/03/01', 800);
INSERT INTO prof (profno, name, id, hiredate)
VALUES( 1003, 'Adam', 'a1003', '11/03/02');

COMMIT;

UPDATE prof
SET pay = 1200
WHERE profno = 1001;

DELETE FROM prof
WHERE profno = 1003;

-- 10.
ALTER TABLE prof
ADD CONSTRAINT prof_profno_pk PRIMARY KEY(profno);

ALTER TABLE prof
ADD (gender CHAR(3));

ALTER TABLE prof
MODIFY (name VARCHAR(20));

select * from prof
