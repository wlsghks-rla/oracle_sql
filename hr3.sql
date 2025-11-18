-- index

commit;

select /*+ INDEX(EMP_EMP_ID_PK) */  *
from employees e;

select * from employees order by email;

-- index 있고 없고 차이 속도 확인
insert into employees
select /*+ INDEX(EMP_EMP_ID_PK) */ employees_seq.nextval, first_name, last_name, 'Email' || EMPLOYEES_SEQ.currval, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
from employees e; -- 자동으로 정렬됨 => insert 작업시 index 사용하면 작업시간이 늦어질 수도 있음.

insert into employees
select employees_seq.nextval, first_name, last_name, 'Email' || EMPLOYEES_SEQ.currval, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
from employees;

--insert into employees
select /*+ INDEX(EMP_EMP_ID_PK) */ employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
from employees e; -- 0.03 / 50 index로 인한 자동 정렬로 인해 시간이 단축됨.

--insert into employees
select employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
from employees
order by salary; -- 0.099 / 50

--


select employees_seq.nextval from dual; -- 다음값
select employees_seq.currval from dual; -- 현재값

delete from employees
where employee_id >206;

select *
from hr.employees;

select *
from proff; -- public으로 synonym만들어서 scott. 생략 가능. 아니면 권한 부여.

select to_char(1234, '09999999')
from dual;