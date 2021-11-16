SELECT ant.au_id as 'AUTHOR ID', ant.au_lname as 'LAST NAME', ant.au_fname as 'FIRST NAME', 
ant.title as 'TITLE', pub_name as 'PUBLISHER'
FROM(
	SELECT au.au_id, au.au_lname, au.au_fname, ti.title, ti.pub_id
	FROM publications.titles ti
	INNER JOIN publications.titleauthor ta ON ti.title_id = ta.title_id
	LEFT JOIN publications.authors au ON ta.au_id = au.au_id
	ORDER BY au.au_id
    ) as ant # author_name_title
LEFT JOIN  publications.publishers pub ON ant.pub_id = pub.pub_id
ORDER BY ant.au_id, pub.pub_name DESC;

SELECT ant.au_id as 'AUTHOR ID', ant.au_lname as 'LAST NAME', ant.au_fname as 'FIRST NAME', 
pub_name as 'PUBLISHER', COUNT(ant.title) as 'TITLE COUNT'
FROM(
	SELECT au.au_id, au.au_lname, au.au_fname, ti.title, ti.pub_id
	FROM publications.titles ti
	INNER JOIN publications.titleauthor ta ON ti.title_id = ta.title_id
	LEFT JOIN publications.authors au ON ta.au_id = au.au_id
	ORDER BY au.au_id
    ) as ant # author_name_title
LEFT JOIN  publications.publishers pub ON ant.pub_id = pub.pub_id
GROUP BY ant.title
ORDER BY ant.au_id DESC, pub.pub_name;

SELECT au.au_id as 'AUTHOR ID', au.au_lname as 'LAST NAME', au.au_fname as 'FIRST NAME', 
SUM(sal.qty) as 'TOTAL'
FROM publications.authors au
LEFT JOIN publications.titleauthor ta ON au.au_id = ta.au_id
LEFT JOIN publications.titles ti ON ta.title_id = ti.title_id
LEFT JOIN publications.sales sal ON ti.title_id = sal.title_id
GROUP BY au.au_id
ORDER BY TOTAL DESC
LIMIT 3;

SELECT au.au_id as 'AUTHOR ID', au.au_lname as 'LAST NAME', au.au_fname as 'FIRST NAME', 
SUM(sal.qty) as 'TOTAL'
FROM publications.authors au
LEFT JOIN publications.titleauthor ta ON au.au_id = ta.au_id
LEFT JOIN publications.titles ti ON ta.title_id = ti.title_id
LEFT JOIN publications.sales sal ON ti.title_id = sal.title_id
GROUP BY au.au_id
ORDER BY TOTAL DESC;


SELECT spt.au_id, SUM(spt.sum_per_title) as 'sum_total'
FROM(
 	SELECT spa.au_id, spa.au_lname, spa.au_fname, spa.title_id, 
    SUM(spa.sales_rty) as 'sum_per_title'
 	FROM(
		SELECT au.au_id , au.au_lname, au.au_fname, ti.title_id,
		ti.price * sal.qty * ti.royalty / 100 * ta.royaltyper / 100 as 'sales_rty'
		FROM publications.authors au
		LEFT JOIN publications.titleauthor ta ON au.au_id = ta.au_id
		LEFT JOIN publications.titles ti ON ta.title_id = ti.title_id
		LEFT JOIN publications.sales sal ON ti.title_id = sal.title_id
		LEFT JOIN publications.roysched roy ON ta.title_id = roy.title_id
 	 	GROUP BY au.au_id
	 	ORDER BY sales_rty DESC
 		) as spa # Sales_per_author
 	GROUP BY spa.title_id
 	ORDER BY sum_per_title DESC
    ) as spt #sales_per_title
 GROUP BY spt.title_id
 ORDER BY sum_total DESC;