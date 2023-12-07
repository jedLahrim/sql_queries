ALTER TABLE employee
ADD CONSTRAINT fk_employee_user
FOREIGN KEY (user_id) REFERENCES user(id);


select *
from user
inner join employee e on user.id = e.user_id
where e.Address in (select Address='990-9029 Duis Street');

SELECT
    Address,
    COUNT(Address) as AddressCount
FROM
    employee
GROUP BY
    Address
HAVING
    COUNT(Address) > 1;


SELECT id, EmpName, EmpBOD, EmpJoiningDate, PrevExperience, Salary, user_id, Address, COUNT(*) as count
FROM employee
GROUP BY id, EmpName, EmpBOD, EmpJoiningDate, PrevExperience, Salary, user_id, Address
HAVING COUNT(*) > 0;

select count(employee.user_id) as user_id_count,u.id
from employee inner join user u on employee.user_id = u.id
group by u.id
having count(user_id)>1;

select *
from user
inner join employee e on user.id = e.user_id
where Salary BETWEEN 40000 and 60000 and user.gender='Male';

select *
from user
inner join employee e on user.id = e.user_id
where e.Salary between 40000 and 60000;

# todo typeorm get dup rows
# const duplicates = await this.repo.find({
#   select: ['name'],
#   from: MyTable,
#   groupBy: ['name'],
#   having: 'COUNT(name) > 1',
# });
# todo typeorm remove dup rows
# await this.repo.remove(duplicates);
# todo sequelize get dup rows
# const duplicates = await MyTable.findAll({
#   attributes: ['name'],
#   group: ['name'],
#   having: Sequelize.literal('COUNT(name) > 1')
# });
# todo sequelize remove dup rows
# await MyTable.destroy({
#   where: {
#     name: {
#       [Sequelize.Op.in]: duplicates.map(d => d.name)
#     }
#   }
# });
# todo prizma get dup rows
# const duplicates = await prisma.myTable.findMany({
#   select: {
#     name: true
#   },
#   groupBy: {
#     name: true
#   },
#   having: {
#     name: {
#       gt: 1
#     }
#   }
# });

# todo prizma remove dup rows
# const idsToRemove = duplicates.map(duplicate => duplicate.id);
#
# await prisma.myTable.deleteMany({
#   where: {
#     id: {
#       in: idsToRemove
#     }
#   }
# });
select *
from employee inner join user u on employee.user_id = u.id
where u.username like 'r%' ;

DELETE FROM employee
WHERE id NOT IN (
     SELECT employee.user_id
    from (
    select user_id
    FROM employee
    GROUP BY employee.user_id
    )as temp_table
);
# todo deprecated
DELETE FROM user
WHERE id IN (
  SELECT id FROM (
    SELECT id, ROW_NUMBER() OVER (
      PARTITION BY user.last_name ORDER BY id
    ) AS row_num
    FROM user
  ) as t
  WHERE t.row_num > 1
);


select *
from user where first_name='michael' order by username ASC;

DELETE u1 FROM user u1,user u2
WHERE u1.id < u2.id
AND u1.first_name = u2.first_name;

select t1.first_name FROM user t1, user t2
WHERE t1.id < t2.id
AND t1.first_name = t2.first_name;

SELECT last_name, COUNT(last_name)
FROM user
GROUP BY last_name
HAVING COUNT(last_name) > 1;
SELECT username, first_name, last_name, gender, password, activation_status, COUNT(*)
FROM user
GROUP BY username, first_name, last_name, gender, password, activation_status
HAVING COUNT(*) > 1;

SELECT u1.*
FROM user u1, user u2
WHERE u1.id < u2.id
AND u1.first_name = u2.first_name;
insert into employee (EmpName, EmpBOD, EmpJoiningDate, PrevExperience, Salary, Address, user_id)
VALUES ('george','Mar 17, 2020','Sep 22, 2020',10,64478,'adress test',2);

select *
from allergie inner join user on user.id=allergie.userId
    inner join employee e on user.id = e.user_id
where Salary between 20000 and 60000;

update user
set last_name = 'hello'
where id=19248;

select *
from user inner join allergie on user.id=allergie.userId
    inner join employee e on user.id = e.user_id limit 2 offset 2;
delete
from user
where user.last_name='';
drop table if exists temporary_table_name;
create TEMPORARY TABLE temporary_table_name SELECT * FROM user;
select *
from temporary_table_name;
create schema temporary_schema_name;
DELETE u1 FROM user u1,user u2
WHERE u1.id < u2.id
AND u1.gender = u2.gender ;
drop table if exists temporary_schema_name.Hello;
create table temporary_schema_name.Hello_Server(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
begin work;
select *
from user where gender='MALE';
commit;
rollback work;
select *
from temporary_schema_name.Hello_Server as Hello_Server inner join user on user.id=Hello_Server.id;

update temporary_schema_name.Hello_Server as Hello_Server
set Hello_Server.email = 'hello-server@gmail.com'
where id = '19274';

insert into temporary_schema_name.Hello_Server (id, name, email)
values ('19206','John Doe 06','server6@gmail.com');

update temporary_schema_name.Hello_Server
set Hello_Server.email = 'server8@gmail.com'
where id = 19277;
