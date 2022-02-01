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
