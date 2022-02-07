
#Primer paso 
CREATE TEMPORARY TABLE publications.autores_nombres
SELECT au_id, au_lname, au_fname
FROM publications.authors;

SELECT *
FROM publications.autores_nombres;
-- -----------------
#Tercer paso 
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id;

-- -------------------------------

SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, pub.pub_name
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.publishers pub
ON tis.pub_id = pub.pub_id
ORDER BY au_lname DESC;

-- -----------------------------------
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, pub.pub_name, COUNT(tis.title) as 'TITLE_COUNT'
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.publishers pub
ON tis.pub_id = pub.pub_id
GROUP BY tis.title
ORDER BY au_lname DESC;

-- ------------------------------
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, pub.pub_name, COUNT(tis.title) as 'TITLE_COUNT'
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.publishers pub
ON tis.pub_id = pub.pub_id
GROUP BY tis.title
ORDER BY au_lname DESC;
-- --------------------------------
CREATE TEMPORARY TABLE publications.ventas
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, SUM(sal.qty) as 'total_de_titulos'
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.sales sal
ON tis.title_id = sal.title_id;

 DROP TABLE publications.ventas;
 
 CREATE TEMPORARY TABLE publications.ventas
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, SUM(sal.qty) as 'total_de_titulos'
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY sal.qty;

SELECT *
FROM publications.ventas;

DROP TABLE publications.ventas;

CREATE TEMPORARY TABLE publications.ventas
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, SUM(sal.qty) as 'total_de_titulos'
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY sal.qty;

DROP TABLE publications.ventas; 
-- ------------------------
CREATE TEMPORARY TABLE publications.ventas
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, SUM(sal.qty) as 'total_de_titulos'
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY sal.qty
ORDER BY total_de_titulos DESC;

DROP TABLE publications.ventas;

CREATE TEMPORARY TABLE publications.ventas
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, SUM(sal.qty) as 'total_de_titulos'
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY sal.qty
ORDER BY total_de_titulos DESC
LIMIT 3;

SELECT *
FROM publications.ventas;

-- --------------------------------------
CREATE TEMPORARY TABLE publications.nulos
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, SUM(sal.qty) as 'total_de_titulos'
FROM publications.authors aut
LEFT JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
LEFT JOIN publications.titles tis
ON tit.title_id = tis.title_id
LEFT JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY aut.au_id
ORDER BY total_de_titulos DESC;

SELECT *
FROM publications.nulos;

DROP TABLE publications.nulos;

CREATE TEMPORARY TABLE publications.nulos
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, SUM(sal.qty) as 'total_de_titulos'
FROM publications.authors aut
LEFT JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
LEFT JOIN publications.titles tis
ON tit.title_id = tis.title_id
LEFT JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY aut.au_id
ORDER BY total_de_titulos DESC;

SELECT *
FROM publications.nulos;

-- --------------------------------------------------
DROP TABLE publications.nulos;

CREATE TEMPORARY TABLE publications.nulos
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, ifnull(SUM(sal.qty), 0) as 'total_de_titulos'
FROM publications.authors aut
LEFT JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
LEFT JOIN publications.titles tis
ON tit.title_id = tis.title_id
LEFT JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY aut.au_id
ORDER BY total_de_titulos DESC;

SELECT *
FROM publications.nulos;

DROP TABLE publications.nulos;

CREATE TEMPORARY TABLE publications.nulos
SELECT aut.au_id, aut.au_lname, aut.au_fname, ifnull(tis.title, 0), ifnull(SUM(sal.qty), 0) as 'total_de_titulos'
FROM publications.authors aut
LEFT JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
LEFT JOIN publications.titles tis
ON tit.title_id = tis.title_id
LEFT JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY aut.au_id
ORDER BY total_de_titulos DESC;

SELECT *
FROM publications.nulos;

DROP TABLE publications.nulos;

CREATE TEMPORARY TABLE publications.nulos
SELECT aut.au_id, aut.au_lname, aut.au_fname, ifnull(tis.title, 0), ifnull(SUM(sal.qty), 0) as 'total_de_titulos'
FROM publications.authors aut
LEFT JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
LEFT JOIN publications.titles tis
ON tit.title_id = tis.title_id
LEFT JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY aut.au_id
ORDER BY total_de_titulos DESC;

SELECT *
FROM publications.nulos;
