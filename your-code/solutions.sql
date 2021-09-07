/* Challenge 1 */

SELECT 
	au.au_id AS 'AUTHOR ID',
    au.au_lname AS 'LAST NAME',
    au.au_fname AS 'FIRST NAME',
    ti.title AS 'TITLE',
    pub.pub_name AS 'PUBLISHER'
FROM titles ti
INNER JOIN titleauthor ta ON ta.title_id = ti.title_id
INNER JOIN authors au ON au.au_id = ta.au_id
INNER JOIN publishers pub ON pub.pub_id = ti.pub_id;

/* Challenge 2 */

SELECT 
	au.au_id AS 'AUTHOR ID',
    au.au_lname AS 'LAST NAME',
    au.au_fname AS 'FIRST NAME',
    pub.pub_name AS 'PUBLISHER',
    count(ti.title_id) AS 'TITLE'
FROM titles ti
INNER JOIN titleauthor ta ON ta.title_id = ti.title_id
INNER JOIN authors au ON au.au_id = ta.au_id
INNER JOIN publishers pub ON pub.pub_id = ti.pub_id
GROUP BY au.au_id, pub.pub_id;

/* Challenge 3 */

SELECT 
	au.au_id AS 'AUTHOR ID',
    au.au_lname AS 'LAST NAME',
    au.au_fname AS 'FIRST NAME',
    sum(sa.qty) AS 'TOTAL'
FROM titles ti
INNER JOIN titleauthor ta ON ta.title_id = ti.title_id
INNER JOIN authors au ON au.au_id = ta.au_id
INNER JOIN sales sa ON sa.title_id = ti.title_id
GROUP BY au.au_id ORDER BY SUM(sa.qty) DESC 
LIMIT 3;

/* Challenge 4 */

SELECT 
	au.au_id AS 'AUTHOR ID',
    au.au_lname AS 'LAST NAME',
    au.au_fname AS 'FIRST NAME',
    IFNULL(SUM(sa.qty), 0) AS 'TOTAL'
FROM authors au
LEFT JOIN titleauthor ta ON au.au_id = ta.au_id
LEFT JOIN titles ti ON ta.title_id = ti.title_id
lEFT JOIN sales sa ON sa.title_id = ti.title_id
GROUP BY au.au_id ORDER BY SUM(sa.qty) DESC;