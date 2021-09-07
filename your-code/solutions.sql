/* BONUS */

SELECT
	au.au_id AS 'AUTHOR ID',
	au.au_lname AS 'LAST NAME',
    au.au_fname AS 'FIRST NAME',
    SUM(sa.qty * ti.price * ti.royalty/100 * ta.royaltyper/100 + ti.advance * ta.royaltyper/100) as 'PROFIT'
FROM authors au 
JOIN titleauthor ta ON ta.au_id = au.au_id
JOIN titles ti ON ti.title_id = ta.title_id
JOIN sales sa ON sa.title_id = ti.title_id
GROUP BY au.au_id
ORDER BY PROFIT DESC;