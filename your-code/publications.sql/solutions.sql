/* Challenge 1*/

SELECT a.au_id, a.au_fname, a.au_lname, ti.title, p.pub_name
FROM publications.authors a 
INNER JOIN publications.titleauthor t ON a.au_id = t.au_id
INNER JOIN publications.titles ti ON t.title_id = ti.title_id
INNER JOIN publicattions.publishers p ON ti.pub_id = p.pub_name;

/* Challenge 2 */


SELECT a.au_id, a.au_fname, a.au_lname, ti.title, p.pub_name, COUNT(ti.title) as count
FROM publications.authors a 
INNER JOIN publications.titleauthor t ON a.au_id = t.au_id
INNER JOIN publications.titles ti ON t.title_id = ti.title_id
INNER JOIN publicattions.publishers p ON ti.pub_id = p.pub_name
GROUP BY p.pub_name;

/* Challenge 3 */

SELECT a.au_id, a.au_fname, a.au_lname, sum(s.qty) as total
FROM publications.authors a 
INNER JOIN publications.titleauthor t ON a.au_id = t.au_id
LEFT JOIN publications.sales s ON t.title_id = s.title_id
GROUP BY t.tile_id
ORDER BY total
LIMIT 3; 

/* Challenge 4 */

SELECT a.au_id, a.au_fname, a.au_lname, sum(s.qty) as total
FROM publications.authors a 
INNER JOIN publications.titleauthor t ON a.au_id = t.au_id
LEFT JOIN publications.sales s ON t.title_id = s.title_id
GROUP BY t.tile_id
ORDER BY total;