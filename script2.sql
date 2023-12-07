# DROP TABLE IF EXISTS departement;
# DROP TABLE IF EXISTS employe;
# DROP TABLE IF EXISTS employe_projet;
# DROP TABLE IF EXISTS projet;
# DROP TABLE IF EXISTS historique;
create table departement(
    num_dep INT PRIMARY KEY,
    nom_departement VARCHAR(130),
    site_departement VARCHAR(255)
);
CREATE TABLE employe(
    n_emp INT PRIMARY KEY,
    nom_employe VARCHAR(255),
    fonction_emp VARCHAR(255),
    sup_emp INT,
    salaire_emp FLOAT,
    num_dep INT,
    FOREIGN KEY (sup_emp) REFERENCES employe(n_emp),
    FOREIGN KEY (num_dep) REFERENCES departement(num_dep),
    UNIQUE(sup_emp,num_dep)
);
CREATE TABLE projet(
    code_proj INT PRIMARY KEY,
    nom_proj VARCHAR(255)
);

CREATE TABLE employe_projet(
    code_proj int PRIMARY KEY,
    n_emp int,
    FOREIGN KEY (code_proj) REFERENCES projet(code_proj),
    FOREIGN KEY (n_emp) REFERENCES employe(n_emp)
);

CREATE TABLE historique(
    n_emp INT,
    date_function DATETIME,
    fonction_emp VARCHAR(255),
    FOREIGN KEY (n_emp) REFERENCES employe(n_emp),
    FOREIGN KEY (fonction_emp) REFERENCES employe(fonction_emp)
);

INSERT INTO departement(num_dep,nom_departement,site_departement)
VALUES(1,'k2','site3'),
(2,'k3','site4');
INSERT INTO departement(num_dep,nom_departement,site_departement)
VALUES(3,'k4','site5');
INSERT INTO departement(num_dep,nom_departement,site_departement)
VALUES(4,'k5','site6');

INSERT INTO employe(n_emp,nom_employe,sup_emp,salaire_emp,num_dep)
VALUES(2,'karim',1,23000.45,2),
(1,'franky',2,23000.45,1),
(3,'franky',2,23000.45,3),
(4,'franky',2,23000.45,4);

INSERT INTO projet(code_proj,nom_proj)
VALUES(3,'easy delivery'),
(2,'big mac delivery');

INSERT INTO employe_projet(code_proj)
VALUES(4),
(6);

INSERT INTO historique(date_function)
VALUES('2333-12-12'),
('2333-12-12'),
('2333-12-12'),
('2333-12-12');



SELECT employe.n_emp,employe.nom_employe
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
WHERE departement.num_dep=2;

SELECT employe.n_emp,employe.nom_employe,departement.num_dep
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
GROUP BY departement.num_dep;


SELECT employe.nom_employe,departement.num_dep,employe.salaire_emp
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
WHERE departement.num_dep=2 AND employe.salaire_emp>'1500';

SELECT employe.nom_employe,employe.fonction_emp,employe.salaire_emp
FROM employe
WHERE employe.fonction_emp='directereur' OR employe.fonction_emp='president';

SELECT employe.nom_employe,employe.fonction_emp,employe.salaire_emp,
departement.num_dep
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
WHERE departement.num_dep=2 OR departement.num_dep=1
AND employe.fonction_emp='ouvrier';

SELECT employe.nom_employe,employe.fonction_emp,employe.salaire_emp,departement.num_dep
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
WHERE employe.fonction_emp !='ouvrier' AND employe.fonction_emp!='directereur'
GROUP BY employe.sup_emp;

SELECT employe.nom_employe,employe.fonction_emp,employe.salaire_emp
FROM employe
WHERE salaire_emp BETWEEN 23000 AND 25000
ORDER BY employe.nom_employe;


SELECT employe.nom_employe,employe.fonction_emp,departement.num_dep,departement.nom_departement
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
WHERE employe.fonction_emp ='ouvrier' OR employe.fonction_emp='employe'
ORDER BY employe.nom_employe;

UPDATE employe
SET num_dep= 4
WHERE employe.fonction_emp='president';

SELECT* FROM employe
WHERE employe.sup_emp is not NULL;

SELECT* FROM employe
ORDER by employe.fonction_emp ASC, employe.salaire_emp DESC;

SELECT avg(employe.salaire_emp)
FROM employe
WHERE employe.fonction_emp='ouvrier';

SELECT MAX(employe.salaire_emp),MIN(employe.salaire_emp),employe.fonction_emp
FROM employe
GROUP BY employe.fonction_emp
HAVING avg(salaire_emp)>0;

select count(employe.n_emp) as n_emp
from employe;
SELECT COUNT(employe.n_emp),employe.nom_employe
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
WHERE departement.num_dep=1 and employe.nom_employe = '';

SELECT COUNT(employe.fonction_emp)
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
WHERE departement.num_dep=4;

SELECT AVG(employe.salaire_emp),departement.num_dep,employe.nom_employe
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
GROUP BY employe.fonction_emp;


select *
from departement;
select *
from employe
inner join departement d on employe.num_dep = d.num_dep
where fonction_emp='' and d.nom_departement='k4';
UPDATE employe
SET salaire_emp = salaire_emp*12
WHERE employe.num_dep IN
(
    SELECT departement.num_dep
    FROM employe
    INNER JOIN departement ON departement.num_dep=employe.num_dep
    WHERE employe.fonction_emp!='directereur' AND employe.fonction_emp!='president'
    GROUP BY employe.fonction_emp
);
select *
from departement
left join employe e on departement.num_dep = e.num_dep
left join employe_projet ep on e.n_emp = ep.n_emp
where code_proj=2;
select *
from employe_projet;
SELECT departement.num_dep,employe.num_dep,AVG(employe.salaire_emp*12)
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
WHERE employe.fonction_emp NOT IN ('president','directereur')
GROUP BY employe.fonction_emp;

UPDATE employe
SET fonction_emp=''
WHERE employe.n_emp=3;

SELECT departement.num_dep,employe.nom_employe
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
WHERE employe.fonction_emp='president'
GROUP BY departement.num_dep
HAVING COUNT(employe.nom_employe)<2;

SELECT departement.site_departement AS ville_employe,employe.nom_employe
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
ORDER BY departement.site_departement;

SELECT departement.site_departement AS ville_employe,employe.nom_employe
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
WHERE employe.n_emp=4;

SELECT employe.nom_employe,employe.fonction_emp,departement.nom_departement
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep
WHERE departement.num_dep=2 OR departement.num_dep=3;

SELECT employe.nom_employe,employe.nom_employe as 'chef',employe.salaire_emp
FROM employe
INNER JOIN departement ON departement.num_dep=employe.num_dep;

SELECT e1.nom_employe,e2.nom_employe AS 'chef',e1.salaire_emp
FROM employe AS e1
INNER JOIN employe as e2 ON e2.n_emp=e1.n_emp;


SELECT e1.nom_employe,d.site_departement,e2.nom_employe AS 'chef',e1.salaire_emp
FROM employe as e1
INNER JOIN employe e2 ON e2.n_emp=e1.n_emp
INNER JOIN departement as d ON d.num_dep=e1.num_dep
WHERE e1.salaire_emp<=e2.salaire_emp;

SELECT e1.nom_employe,e2.nom_employe AS 'chef',e1.salaire_emp
FROM employe as e1
INNER JOIN employe e2 ON e2.n_emp=e1.n_emp
WHERE e1.salaire_emp> ( SELECT employe.salaire_emp FROM employe
WHERE employe.n_emp=2)
ORDER BY e1.nom_employe;

SELECT employe.nom_employe,employe.salaire_emp,employe.fonction_emp
From employe
WHERE  employe.salaire_emp> (SELECT employe.salaire_emp
FROM employe WHERE employe.n_emp=2)
ORDER by employe.nom_employe;

SELECT e1.nom_employe,e2.nom_employe AS 'chef'
FROM employe e1
LEFT JOIN employe e2 ON e2.n_emp=e1.sup_emp;

SELECT employe.nom_employe,projet.nom_proj,employe.fonction_emp
FROM employe_projet
INNER JOIN employe ON employe.n_emp=employe_projet.n_emp
INNER JOIN projet ON projet.code_proj=employe_projet.code_proj;

SELECT projet.nom_proj,employe.nom_employe
FROM employe_projet
INNER JOIN employe ON employe.n_emp=employe_projet.n_emp
INNER JOIN projet ON projet.code_proj=employe_projet.code_proj
WHERE employe.n_emp=2;

SELECT employe.nom_employe,projet.nom_proj,employe.fonction_emp
FROM employe_projet
INNER JOIN employe ON employe.n_emp=employe_projet.n_emp
INNER JOIN projet ON projet.code_proj=employe_projet.code_proj
WHERE employe.fonction_emp='directereur' AND projet.nom_proj='easy delivery';


SELECT employe.* ,projet.nom_proj
FROM employe
LEFT JOIN employe_projet ON employe.n_emp=employe_projet.n_emp
LEFT JOIN projet ON projet.code_proj=employe_projet.code_proj
GROUP BY employe.n_emp;

SELECT employe.* ,projet.nom_proj
FROM employe
LEFT JOIN employe_projet ON employe.n_emp=employe_projet.n_emp
LEFT JOIN projet ON projet.code_proj=employe_projet.code_proj
WHERE employe.fonction_emp='directereur'
GROUP BY employe.n_emp;


SELECT employe.nom_employe,employe.salaire_emp,employe.fonction_emp
From employe
WHERE  employe.salaire_emp> (SELECT employe.salaire_emp
FROM employe WHERE employe.nom_employe='karim')
ORDER by employe.nom_employe;


SELECT employe.nom_employe,employe.salaire_emp,employe.fonction_emp,departement.nom_departement
From employe
INNER JOIN departement on departement.num_dep=employe.num_dep
WHERE  employe.salaire_emp>'300000'
ORDER by employe.nom_employe;


SELECT employe.fonction_emp,AVG(employe.salaire_emp),departement.nom_departement
FROM employe
INNER JOIN departement on departement.num_dep=employe.num_dep
GROUP BY employe.n_emp
HAVING AVG(employe.salaire_emp)<(SELECT avg(employe.salaire_emp)
FROM employe
WHERE employe.fonction_emp='president');

SELECT employe.nom_employe,employe.fonction_emp
FROM employe
WHERE employe.fonction_emp='ouvrier' OR employe.fonction_emp='president'
GROUP BY employe.n_emp;

SELECT employe.nom_employe,employe.fonction_emp
FROM employe
WHERE employe.fonction_emp!='ouvrier'
GROUP BY employe.n_emp;

SELECT*
FROM employe
WHERE employe.n_emp NOT IN(SELECT historique.n_emp
FROM historique WHERE employe.fonction_emp='ouvrier');

SELECT projet.nom_proj,employe.fonction_emp
FROM employe_projet
LEFT JOIN employe ON employe_projet.n_emp=employe.n_emp
LEFT JOIN projet ON projet.code_proj=employe_projet.code_proj
WHERE projet.nom_proj=(SELECT employe.fonction_emp
FROM employe
WHERE employe.fonction_emp!='directereur');


SELECT DISTINCT projet.*
FROM projet
INNER JOIN employe_projet ON employe_projet.code_proj=projet.code_proj
WHERE employe_projet.code_proj  IN
(
    SELECT DISTINCT projet.code_proj
    FROM projet
    INNER JOIN employe_projet ON employe_projet.code_proj=projet.code_proj
    INNER JOIN employe ON employe_projet.n_emp=employe.n_emp
    WHERE employe.fonction_emp='directereur'
);


#
#