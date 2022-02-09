USE publications;

SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, pub.pub_name
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.publishers pub
ON tis.pub_id = pub.pub_id;

-- -------------------------------------------------------------------------------
 

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

-- ------------------------------------------------------------------------------------------------------

SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, SUM(sal.qty) as 'total_titulos'
FROM publications.authors aut
INNER JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
INNER JOIN publications.titles tis
ON tit.title_id = tis.title_id
INNER JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY sal.qty
ORDER BY total_titulos DESC
LIMIT 3;

-- --------------------------------------------------------------------------------------------------

SELECT aut.au_id, aut.au_lname, aut.au_fname, tis.title, IFNULL(SUM(sal.qty),0) as 'total_titulos'
FROM publications.authors aut
LEFT JOIN publications.titleauthor tit
ON aut.au_id = tit.au_id
LEFT JOIN publications.titles tis
ON tit.title_id = tis.title_id
LEFT JOIN publications.sales sal
ON tis.title_id = sal.title_id
GROUP BY aut.au_id
ORDER BY total_titulos DESC;