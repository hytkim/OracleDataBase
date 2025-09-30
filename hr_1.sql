select * from tab;

-- employee_id first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
select *
from employees;

-- department_id, department_name, manager_id, location_id
select * 
from departments;

-- job_id, job_title, min_salary, max_salary
select * 
from jobs;

-- employee_id, start_date, end_date, job_id, department_id
select *
from job_history;

-- emploee -> departments -> locaitions -> conturiID
--location_id, street_address, postal_code, city, state_province, county_id
select * 
from locations;

--country_id, country_name, region_id
select * 
from countries;

--region_id, region_name
select * 
from regions;


-- Q1. 임플로이의 도날드씨가일하는 도시
select department_id from employees where employee_id = 198;
select * from departments where department_id = 50;
select * from locations where location_id = 1500;


select e.employee_id
  , e.first_name
  , e.last_name
  ,d.location_id
  ,d. department_name
  ,l.street_address
  ,l.city
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on l.location_id = d.location_id
where e.employee_id = 198;

-- Q2. jobs.job_id IT_PROG인 employees 들이 어떤 도시에 사는지 조회

select *
from jobs;

select distinct e.department_id
from jobs j
join employees e
on j.job_id = e.job_id;


select location_id from departments d where d.department_id in (select distinct e.department_id
from jobs j
join employees e
on j.job_id = e.job_id);


select l.* 
from locations l
where l.location_id in(select location_id from departments d where d.department_id in (select distinct e.department_id from jobs j join employees e on j.job_id = e.job_id)
);
      
      
-- Q3. 
--it 부서별정보인 dept로가면 각부서의 매니저정보가있다 (사번) it부서의 mgr은 103이래
-- mgr이랑 emp랑 걸어서 103에대한 정보를 볼수있겠지
select * from departments;
select * 
from departments d
join employees e
on d.department_id = e.department_id
where d.manager_id = 103
and d.manager_id = e.employee_id;



-- Q4.job의 최소 급여 최대 급여가 있다
-- e 테이블에 sal이 범위를 벗어나는사람이 있는가
-- job id가 일치함
select * from jobs;
select * from employees;

select j.job_id, min_salary, max_salary, e.salary
from jobs j
join employees e
on j.job_id = e.job_id
where e.salary > max_salary
OR e.salary < min_salary;

select /*+ INDEX(e. emp_emp_id_pk)*/e.* from employees e
where exists (select 1 from jobs j where e.job_id = j.job_id and e.salary between j.min_salary and j.max_salary);

update employees
set salary = 99999
where employee_id = 103;

rollback;