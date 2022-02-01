USE publications;

-- ---------------------------------------------------------------
#au_id authors
#au_lname authors
#au_fname authors

#title (titleauthor --- > titles
#pub_name (titles -----> publishers

SELECT au.au_id , au.au_lname, au.au_fname, ti.title, pub.pub_name
FROM publications.authors au
LEFT JOIN titleauthor ta ON au.au_id = ta.au_id
INNER JOIN titles ti ON ta.title_id  = ti.title_id
INNER JOIN publishers pub ON ti.pub_id = pub.pub_id;

-- -----------------------------------------------------------------
SELECT au.au_id , au.au_lname, au.au_fname, pub.pub_name,  COUNT(ti.title) AS 'TITLE_COUNT'
FROM publications.authors au
LEFT JOIN titleauthor ta ON au.au_id = ta.au_id
INNER JOIN titles ti ON ta.title_id  = ti.title_id
INNER JOIN publishers pub ON ti.pub_id = pub.pub_id
GROUP BY au.au_id , au.au_lname, au.au_fname, pub.pub_name 
ORDER BY au.au_id DESC;
-- -----------------------------------------------------------
SELECT au.au_id , au.au_lname, au.au_fname, SUM(sal.qty) AS 'title_sold'
FROM publications.authors au
LEFT JOIN titleauthor ta ON au.au_id = ta.au_id
INNER JOIN titles ti ON ta.title_id  = ti.title_id
INNER JOIN sales sal ON ti.title_id = sal.title_id
GROUP BY au.au_id , au.au_lname, au.au_fname
ORDER BY title_sold DESC
LIMIT 3;

-- ----------------------------------------------------------------
CREATE TEMPORARY TABLE publications.temp
SELECT au.au_id , au.au_lname, au.au_fname, SUM(sal.qty) AS 'title_sold'
FROM publications.authors au
LEFT JOIN titleauthor ta ON au.au_id = ta.au_id
LEFT JOIN titles ti ON ta.title_id  = ti.title_id
LEFT JOIN sales sal ON ti.title_id = sal.title_id
GROUP BY au.au_id , au.au_lname, au.au_fname
ORDER BY title_sold DESC;

SELECT fin.au_id, fin.au_lname, fin.au_fname, IFNULL(title_sold, 0) AS 'TOTAL'
FROM publications.temp fin; 

