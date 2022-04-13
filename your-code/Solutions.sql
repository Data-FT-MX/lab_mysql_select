#Challenge 1 - Who Have Published What At Where?

CREATE TABLE publications.Who_Published 
SELECT au.au_id, au.au_lname, au.au_fname, ti.title, pub.pub_name
FROM publications.authors au
LEFT JOIN titleauthor ta 
ON au.au_id = ta.au_id
INNER JOIN titles ti 
ON ta.title_id = ti.title_id
LEFT JOIN publishers pub
ON ti.pub_id = pub.pub_id;

#Challenge 2 - Who Have Published How Many At Where?

CREATE TABLE publications.Frecuencia_Titulos
SELECT au.au_id, au.au_lname, au.au_fname, pub.pub_name, COUNT(ti.title) as 'Conteo de Titulo'
FROM publications.authors au
LEFT JOIN titleauthor ta 
ON au.au_id = ta.au_id
INNER JOIN titles ti 
ON ta.title_id = ti.title_id
LEFT JOIN publishers pub
ON ti.pub_id = pub.pub_id
GROUP BY au.au_id, au.au_lname, au.au_fname, pub.pub_name
ORDER BY au.au_id desc;

#Challenge 3 - Best Selling Authors

CREATE TABLE publications.Best_Selling_Authors
SELECT au.au_id, au.au_lname, au.au_fname, ti.title, SUM(sa.qty) as 'titulos_vendidos'
FROM publications.authors au
LEFT JOIN titleauthor ta 
ON au.au_id = ta.au_id
INNER JOIN titles ti 
ON ta.title_id = ti.title_id
LEFT JOIN sales sa
ON ti.title_id = sa.title_id
GROUP BY au.au_id, au.au_lname, au.au_fname
ORDER BY au.au_id desc
limit 3;

#Challenge 4 - Best Selling Authors Ranking

CREATE TEMPORARY TABLE publications.Best_Selling_All_Author
SELECT au.au_id, au.au_lname, au.au_fname, ti.title, SUM(sa.qty) as 'titulos_vendidos'
FROM publications.authors au
LEFT JOIN titleauthor ta 
ON au.au_id = ta.au_id
INNER JOIN titles ti 
ON ta.title_id = ti.title_id
LEFT JOIN sales sa
ON ti.title_id = sa.title_id
GROUP BY au.au_id, au.au_lname, au.au_fname
ORDER BY titulos_vendidos DESC;

SELECT be.au_id, be.au_lname, be.au_fname, ifnull(titulos_vendidos,0) as 'TOTAL'
FROM publications.Best_Selling_All_Author be


