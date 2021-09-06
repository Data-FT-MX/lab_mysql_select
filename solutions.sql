
# CHALLENGE 1
SELECT aut.au_id as 'AUTHOR ID', aut.au_lname as'LAST NAME',
aut.au_fname as'FIRST NAME' , tit.title as 'TITLE' , publi.pub_name as 'PUBLISHER'
FROM publications.authors aut
LEFT JOIN publications.titleauthor titau ON aut.au_id = titau.au_id
LEFT JOIN publications.titles tit ON titau.title_id = tit.title_id
LEFT JOIN publications.publishers publi ON tit.pub_id =publi.pub_id;

-- -------------
#CHALLENGE 2
SELECT aut.au_id as 'AUTHOR ID', aut.au_lname as'LAST NAME',
aut.au_fname as'FIRST NAME' , publi.pub_name as 'PUBLISHER',
COUNT(tit.title_id) as 'TITLE COUNT'
FROM publications.authors aut
LEFT JOIN publications.titleauthor titau ON aut.au_id = titau.au_id
LEFT JOIN publications.titles tit ON titau.title_id = tit.title_id
LEFT JOIN publications.publishers publi ON tit.pub_id =publi.pub_id
GROUP BY tit.title_id;

-- ----------------------
#SOPORTE DE CHALLENGE 3 Y 4
CREATE TABLE publications.ventas_por_autor
SELECT aut.au_id as 'AUTHOR_ID', aut.au_lname as'LAST_NAME',
aut.au_fname as'FIRST_NAME',
sum(sal.qty) as 'TOTAL'
FROM publications.authors aut 
LEFT JOIN publications.titleauthor titau ON aut.au_id = titau.au_id
LEFT JOIN publications.titles tit ON titau.title_id = tit.title_id
LEFT JOIN publications.sales sal ON tit.title_id = sal.title_id
GROUP BY aut.au_id
ORDER BY TOTAL DESC;

#CHALLENGE 3
SELECT *
FROM publications.ventas_por_autor
LIMIT 3;

-- --------------------------------
#CHALLENGE 4
SELECT vau.AUTHOR_ID, vau.LAST_NAME, vau.FIRST_NAME, IFNULL(TOTAL,0) AS 'TOTAL'
FROM publications.ventas_por_autor vau;