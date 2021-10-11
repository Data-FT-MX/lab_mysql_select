/* Challenge 1 */
USE publications;
SELECT 
au.au_id as 'author_id', 
au.au_lname as 'last_name',
au.au_fname as 'first_name', 
ti.title, pu.pub_name as 'publisher_name'
FROM authors au
INNER JOIN titleauthor ta ON au.au_id = ta.au_id 
LEFT JOIN titles ti ON ta.title_id = ti.title_id
LEFT JOIN publishers pu ON ti.pub_id = pu.pub_id
ORDER BY author_id ASC;
-------------------------------------------------------------------
/* Challenge 2 */

SELECT 
au.au_id as 'author_id', 
au.au_lname as 'last_name',
au.au_fname as 'first_name', 
pu.pub_name as 'publisher_name',
COUNT(title) as 'title_count'
FROM authors au
INNER JOIN titleauthor ta ON au.au_id = ta.au_id 
LEFT JOIN titles ti ON ta.title_id = ti.title_id
LEFT JOIN publishers pu ON ti.pub_id = pu.pub_id
GROUP BY publisher_name, author_id
ORDER BY author_id DESC, publisher_name DESC;

-------------------------------------------------------------------
/* Challenge 3 */
SELECT 
au.au_id as 'author_id', 
au.au_lname as 'last_name',
au.au_fname as 'first_name', 
SUM(sa.qty) as 'total'
FROM authors au
INNER JOIN titleauthor ta ON au.au_id = ta.au_id
LEFT JOIN titles ti ON ta.title_id = ti.title_id
LEFT JOIN sales sa ON ti.title_id = sa.title_id
GROUP BY author_id
ORDER BY total DESC
LIMIT 3;

-------------------------------------------------------------------
/* Challenge 4 */
SELECT 
au.au_id as 'author_id', 
au.au_lname as 'last_name',
au.au_fname as 'first_name', 
SUM(sa.qty) as 'total'
FROM authors au
INNER JOIN titleauthor ta ON au.au_id = ta.au_id
LEFT JOIN titles ti ON ta.title_id = ti.title_id
LEFT JOIN sales sa ON ti.title_id = sa.title_id
GROUP BY author_id
ORDER BY total DESC;