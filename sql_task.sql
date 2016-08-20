--Given tables:
create table tasks (
  id int primary key,
  name varchar(256),
  status varchar(10),
  project_id int
);
create table projects (
  id int primary key,
  name varchar(256)
);

-- 1. get all statuses, not repeating, alphabetically ordered
select distinct status
from tasks
order by status asc;

-- 2. get the count of all tasks in each project, order by tasks count descending
select b.name, count(*) as task_cnt
from tasks as a, projects as b
where a.project_id = b.id
group by b.name
order by count(*) desc;

-- 3. get the count of all tasks in each project, order by projects names
select b.name, count(*) as task_cnt
from tasks as a, projects as b
where a.project_id = b.id
group by b.name
order by b.name;

-- 4. get the tasks for all projects having the name beginning with “N” letter
select a.*
from tasks as a, projects as b
where a.project_id = b.id
and b.name like 'N%';

-- 5. get the list of all projects containing the ‘a’ letter in the middle of the name, and
--    show the tasks count near each project. Mention that there can exist projects without
--    tasks and tasks with project_id=NULL
select b.name, count(*) as task_cnt
from tasks as a
right join projects as b
on a.project_id = b.id
where b.name like '%_a_%'
group by b.name;

-- 6. get the list of tasks with duplicate names. Order alphabetically
select name
from tasks
group by name
having count(*) > 1
order by name;

-- 7. get the list of tasks having several exact matches of both name and status, from
--    the project ‘Garage’. Order by matches count
select a.name, count(*)
from tasks as a, projects as b
where a.project_id = b.id
and b.name = 'Garage'
group by a.name, a.status
having count(*) > 1
order by count(*);

-- 8. get the list of project names having more than 10 tasks in status ‘completed’. Order
--    by project_id
select b.name
from tasks as a, projects as b
where a.project_id = b.id
and a.status = 'completed'
group by b.name, a.project_id
having count(a.id) > 10
order by a.project_id;