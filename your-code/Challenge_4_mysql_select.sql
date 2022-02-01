SELECT *
FROM publications.authors;

CREATE TEMPORARY TABLE publications.autores_nombres
SELECT au_id, au_lname, au_fname
FROM publications.authors;

SELECT *
FROM publications.autores_nombres;

-- ------------------------------------------------------------------------------------------------
#CREATE TEMPORARY TABLE publications.autores_identificacion
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, pub.pub_name, COUNT(tis.title) as 'Conteo_Titulos'
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.publishers pub
ON tis.pub_id = pub.pub_id
GROUP BY tis.title
ORDER BY au_lname DESC;

-- ------------------------------------------------------------------------------------------------
CREATE TEMPORARY TABLE publications.ventas
SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, SUM(sal.qty) as 'Total_titulos'
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY sal.qty
ORDER BY Total_titulos DESC
LIMIT 3;

SELECT *
FROM publications.ventas;

#DROP TABLE publications.ventas;

-- ------------------------------------------------------------------------------------------------
CREATE TEMPORARY TABLE publications.ventas23
SELECT aut.au_id, aut.au_lname, aut.au_fname, ifnull(tis.title, 'Sin_titulo'), ifnull(SUM(sal.qty), 0) as 'Total_titulos'
FROM publications.authors aut
LEFT JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
LEFT JOIN publications.titles tis
ON tit.title_id = tis.title_id
LEFT JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY aut.au_id
ORDER BY Total_titulos DESC;

SELECT *
FROM publications.ventas23;

DROP TABLE publications.ventas23;

