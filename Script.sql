SELECT * FROM tab;

SELECT d.dname, p.*
FROM professor p
JOIN department d ON p.deptno = d.deptno;

SELECT * FROM emp e
WHERE ename = 'FORD';

--inline view
SELECT d.dname, a.sal max_salary
FROM (SELECT deptno, MAX(sal) sal
      FROM emp e
      GROUP BY deptno) a
JOIN dept d ON a.deptno = d.deptno;

-- sub query
SELECT * FROM emp 
WHERE sal > (SELECT sal
             FROM emp e
             WHERE e.ename = 'FORD');

SELECT empno
      ,ename
      ,sal
      ,deptno
      ,(SELECT dname FROM dept WHERE deptno = e.deptno) dname --한건만 배출하는 조건만..
FROM emp e;

-- 연습문제1 p.429
SELECT s.name stud_name
      ,d.dname dept_name
FROM STUDENT s
JOIN department d ON s.deptno1 = d.deptno
WHERE s.deptno1 = (SELECT deptno1
                   FROM student 
                   WHERE name = 'Anthony Hopkins');

-- 연습문제2 p.429
select p.name prof_name
     , p.hiredate
     , d.dname dept_name
FROM professor p
JOIN department d ON p.deptno = d.deptno
WHERE p.hiredate > (SELECT hiredate
      FROM professor
      WHERE name = 'Meg Ryan');


-- 다중행 sub query
SELECT e.empno
      ,e.NAME 
      ,e.deptno
FROM emp2 e
WHERE e.deptno in (SELECT dcode
                  FROM DEPT2 
                  WHERE area = 'Pohang Main Office');

-- exist
SELECT *
FROM DEPT d
WHERE EXISTS (SELECT *
              FROM dept d2
              WHERE d2.deptno = 11);

-- 연습문제1 p.434
SELECT e.name
     , e.POSITION
     , e.pay salary
FROM EMP2 e
WHERE pay >Any (SELECT pay
             FROM emp2
             WHERE POSITION = 'Section head')
ORDER BY 3 desc;


-- 연습문제2 p.434
SELECT s.name, s.grade, s.weight
FROM STUDENT s
WHERE s.weight <ALL (SELECT weight -- 72, 70, 82, 51, 62
                     FROM STUDENT
                     WHERE grade = 2);

-- 연습문제3 p.435
SELECT d.dname, e.name, e.pay
FROM EMP2 e
JOIN dept2 d ON e.deptno = d.dcode
WHERE e.pay <ALL (SELECT avg(pay) avg_sal
                FROM emp2
                GROUP BY deptno);


-- 다중 query p.435
SELECT s.grade, s.name, s.weight
FROM student s
WHERE (s.grade, s.weight) IN (SELECT grade, max(weight) max_weight
                            FROM student
                            GROUP BY grade);

-- 연습문제1 p.436
SELECT p.profno
     , p.name prof_name
     , p.hiredate
     , d.dname dept_name
FROM professor P
JOIN department d ON p.deptno = d.deptno
where(p.deptno, p.hiredate) IN (SELECT deptno, min(hiredate)
                                FROM professor
                                GROUP BY deptno)
ORDER BY 3;

-- 연습문제2 p.436
SELECT e.name
     , e.POSITION
     , to_char(e.pay, '$999,999,999') salary
FROM EMP2 e
WHERE (e.POSITION, e.pay) IN (SELECT POSITION, max(pay)
                              FROM emp2
                              GROUP BY POSITION)
ORDER BY 3;

-- 상호 연관 query p.437
SELECT name, POSITION, pay
FROM EMP2 e 
WHERE 1=1 
AND  e.pay >= (SELECT trunc(avg(pay))
               FROM emp2
               WHERE e.POSITION = position);

SELECT name
     , POSITION, pay
     , (SELECT trunc(avg(pay)) FROM emp2 WHERE POSITION = e.position) avg_pay
FROM EMP2 e;

-- with subquery p.447
WITH emp AS 
(SELECT deptno deptno, max(pay) salary
 FROM emp2
 GROUP BY deptno)
SELECT d.dname, e.salary 
FROM emp e
JOIN dept2 d ON e.deptno = d.DCODE;

SELECT *
FROM EMP2 e mp2

-- p.448 실습
CREATE TABLE WITH_test1 (
  NO NUMBER,
  name varchar2(10),
  pay number(6))
  TABLESPACE users;


/*
BEGIN
	FOR i IN 1 .. 5000000 LOOP
		INSERT INTO with_test1 
        VALUES (i, dbms_random.string('A',5), dbms_random.value(6,99999));
	END LOOP
	COMMIT;
END;
*/

SELECT * FROM with_test1;

SELECT max(pay) - min(pay) -- 0.4s
FROM with_test1;

CREATE INDEX idx_with_pay ON with_test1(pay); -- 3.7s

WITH a AS (
 SELECT /*+ INDEX_DESC(w idx_with_pay)*/ pay 
 FROM with_test1 w
 WHERE pay > 0
 AND rownum = 1
), b AS (
 SELECT /*+ INDEX(w idx_with_pay)*/ pay 
 FROM with_test1 w
 WHERE pay > 0
 AND rownum = 1
)
SELECT a.pay -b.pay FROM a, b;



 SELECT /*+ INDEX_DESC(w idx_with_pay)*/ rownum, pay 
 FROM with_test1 w
 WHERE pay > 0
 AND rownum = 1;
 
 
 -- 계층형 커리 p.478
 SELECT *
 FROM emp;
 
 SELECT lpad(ename, LEVEL*5, '*') ename
       ,level
 FROM emp e
 CONNECT BY PRIOR empno = mgr
 START WITH empno = 7839;
 
 -- 연습문제 p.491
 -- kurt russel - boss
 
 SELECT lpad(name || '-' || nvl(POSITION, 'Team-Workder'), LEVEL*17, '-')
 FROM emp2
 CONNECT BY PRIOR empno = pempno
 START WITH empno = 19900101 
 ORDER siblings BY name;
 
 SELECT * FROM emp2;
 SELECT *
 from dept2;
 
 