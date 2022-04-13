-- Challenge 1

CREATE TEMPORARY TABLE publications.info
SELECT
au.au_id as 'Author_ID', 
au.au_lname AS 'Last_Name', 
au.au_fname AS 'First_Name', 
ttl.title AS 'Title', 
pub.pub_name AS 'Publisher'
FROM publications.titles AS ttl
INNER JOIN publications.titleauthor AS ttlau
ON ttl.title_id = ttlau.title_id
INNER JOIN publications.publishers AS pub
ON ttl.pub_id = pub.pub_id
INNER JOIN publications.authors AS au
ON ttlau.au_id = au.au_id;

SELECT
COUNT(title_id)
FROM publications.titleauthor;

SELECT
COUNT(Title)
FROM publications.info;

-- Challenge 2

SELECT Author_ID, Last_Name, First_Name, Publisher, 
COUNT(Title) AS 'Title_Count'
FROM publications.info
GROUP BY Author_ID, Publisher
ORDER BY Author_ID DESC;

-- Challenge 3

SELECT 
au.au_id AS 'Author_ID', 
au.au_lname AS 'Last_Name', 
au.au_fname AS 'First_Name',
SUM(sa.qty) AS 'Total'
FROM publications.titles AS ttl
INNER JOIN publications.titleauthor AS ttlau
ON ttl.title_id = ttlau.title_id
INNER JOIN publications.authors AS au
ON ttlau.au_id = au.au_id
INNER JOIN publications.sales AS sa
ON ttl.title_id = sa.title_id
GROUP BY Author_ID
ORDER BY Total DESC
LIMIT 3;

-- Challenge 4
SELECT 
au.au_id AS 'Author_ID', 
au.au_lname AS 'Last_Name', 
au.au_fname AS 'First_Name',
IFNULL(SUM(sa.qty),0) AS 'Total' 
FROM publications.titles AS ttl
RIGHT JOIN publications.titleauthor AS ttlau
ON ttl.title_id = ttlau.title_id
RIGHT JOIN publications.authors AS au
ON ttlau.au_id = au.au_id
LEFT JOIN publications.sales AS sa
ON ttl.title_id = sa.title_id
GROUP BY Author_ID
ORDER BY Total DESC;
