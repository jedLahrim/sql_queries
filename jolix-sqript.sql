select *
from allergie
left join child c on c.id = allergie.childId
left join user u on u.id = c.userId;
select *
from tutorial;
select carer_child.carerId as carer
from carer_child
left join child c on carer_child.childId = c.id
where childId = '5f32143e-e8e1-4723-86e7-79475c46085d';



select u.email,u.type,u.activated
from tutorial
inner join user_tutorial ut on tutorial.id = ut.tutorialId
inner join user u on ut.userId = u.id
inner join child c on u.id = c.userId
where ut.viewed = 1 and u.email='amine@appyventures.com'
group by u.email,u.type,u.activated;

select user.id,user.email,udi.dailyInsightId,di.title,di.description
from user
left join user_daily_insight udi on user.id = udi.userId
inner join daily_insight di on udi.dailyInsightId = di.id
where case when user.email='amine@appyventures.com' then user.activated=1
    when user.email='patricearcher@gmail.com' then user.activated =1
else false
end
group by user.id,user.email,udi.dailyInsightId,di.title,di.description;
select *
from user
left join user_daily_insight udi on user.id = udi.userId
inner join daily_insight di on udi.dailyInsightId = di.id
where CASE
          WHEN (di.alwaysVisible = 0) AND (di.publishedAt IS NOT NULL) AND (di.unpublishedAt IS NOT NULL)
              THEN di.publishedAt >= '2022-06-14 05:14:10.139000' AND di.unpublishedAt <= '2024-06-14 05:14:10.139000'
          WHEN (di.alwaysVisible = 0) AND (di.publishedAt IS NOT NULL) AND (di.unpublishedAt IS NULL)
              THEN di.publishedAt BETWEEN '2022-06-14 05:14:10.139000' AND '2024-06-14 05:14:10.139000'
          ELSE true
          END;

select *
from daily_insight
inner join user_daily_insight udi on daily_insight.id = udi.dailyInsightId
inner join user u on udi.userId = u.id
where daily_insight.id='9da6177f-d8fb-48c1-894b-93c258359952';
select *
from daily_insight
inner join user_daily_insight udi on daily_insight.id = udi.dailyInsightId
where daily_insight.id='d6efbf8e-c33d-45eb-b61b-2d898f53ffb7';

CREATE TABLE customers (
id BINARY(16) PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100),
  phone VARCHAR(20),
  UNIQUE(id)
);
ALTER TABLE customers
ADD COLUMN customer_email varchar(255) ;
ALTER TABLE customers
ADD CONSTRAINT fk_users_customers
FOREIGN KEY (customer_email)
REFERENCES user(activated);
select *
from tutorial
 right join attachment a on tutorial.videoAttachmentId = a.id

-- start a transaction
BEGIN Work;
INSERT INTO customers(id, first_name,last_name,email,phone)
VALUES('123e2','John', 'hello', 'johndoe@example.com', '555-555-5555'),
      ('143e60000','John', 'server', 'johndoe@example.com', '555-555-5555'),
      ('163460000','Mary Jane', 'Doe', 'johndoe@example.com', '555-555-5555');
-- other statements

-- commit the transaction
COMMIT;
ROLLBACK;
begin work;
select child_behaviour_trait.id, a.type,bt.type
from child_behaviour_trait
inner join attachment a on child_behaviour_trait.voiceAttachmentId = a.id
inner join behaviour_trait bt on child_behaviour_trait.behaviourTraitId = bt.id
where bt.type = 'PREDEFINED'
group by a.type , child_behaviour_trait.id,bt.type;
COMMIT;
ROLLBACK;

CREATE PROCEDURE add_employee (IN name VARCHAR(255), IN salary DECIMAL(10,2), OUT new_id INT)
BEGIN
  INSERT INTO user (fullName) VALUES (name);
  SET new_id = LAST_INSERT_ID();
END;

CREATE USER 'superAdmin2'@'localhost' IDENTIFIED BY 'adminpassword';
GRANT ALL PRIVILEGES ON *.* TO 'superAdmin2'@'localhost';
FLUSH PRIVILEGES;

DELETE FROM daily_insight
select *
from daily_insight
WHERE id IN (
  SELECT MIN(id) as minimumId
  FROM daily_insight as di
  GROUP BY di.title, di.type, di.alwaysVisible,di.description
  -- columns used to identify duplicates
);

CREATE TEMPORARY TABLE if not exists temp_table AS (
# get all dup rows
SELECT
    daily_insight.id,
    COUNT(daily_insight.id) as daily_insightCount
FROM
    daily_insight
GROUP BY
    daily_insight.id
HAVING
    COUNT(daily_insight.id) > 1
);
delete
from temp_table;

DELETE FROM daily_insight;
INSERT INTO daily_insight
SELECT *
FROM temp_table;



# get all dup rows
SELECT
    daily_insight.id,
    COUNT(daily_insight.id) as daily_insightCount
FROM
    daily_insight
GROUP BY
    daily_insight.id
HAVING
    COUNT(daily_insight.id) > 1;








WITH CTE(id, title,description
    DuplicateCount ) AS (SELECT id, title, description,
           ROW_NUMBER() OVER(PARTITION BY id,title,description
           ORDER BY ID) AS DuplicateCount
    FROM daily_insight)
DELETE FROM CTE
WHERE DuplicateCount > 1;

