
# Challenge 1 - Who Have Published What At Where?

SELECT au.au_id as 'AUTHOR ID', au.au_lname as 'LAST NAME',au.au_fname as 'FIRST NAME', ti.title as 'TITLE', pub.pub_name as 'PUBLISHER'
FROM publications.authors au
INNER JOIN publications.titleauthor ta ON au.au_id = ta.au_id
LEFT JOIN publications.titles ti ON ta.title_id = ti.title_id
LEFT JOIN publications.publishers pub ON ti.pub_id = pub.pub_id;

# Challenge 2 - Who Have Published How Many At Where?

SELECT au.au_id as 'AUTHOR ID', au.au_lname as 'LAST NAME',au.au_fname as 'FIRST NAME', pub.pub_name as 'PUBLISHER', COUNT(ti.title) as 'TITLE COUNT'
FROM publications.authors au
INNER JOIN publications.titleauthor ta ON au.au_id = ta.au_id
LEFT JOIN publications.titles ti ON ta.title_id = ti.title_id
LEFT JOIN publications.publishers pub ON ti.pub_id = pub.pub_id
GROUP BY au.au_lname, au.au_fname, pub.pub_name
ORDER BY COUNT(ti.title) DESC;

# Challenge 3 - Best Selling Authors

SELECT au.au_id as 'AUTHOR ID', au.au_lname as 'LAST NAME',au.au_fname as 'FIRST NAME', SUM(sa.qty) as 'TOTAL'
FROM publications.authors au
LEFT JOIN publications.titleauthor ta on au.au_id = ta.au_id
LEFT JOIN publications.titles ti on ta.title_id = ti.title_id
LEFT JOIN publications.sales sa on ti.title_id = sa.title_id
GROUP BY au.au_lname, au.au_fname
ORDER BY SUM(sa.qty) DESC
LIMIT 3;

# Challenge 4 - Best Selling Authors Ranking

SELECT au.au_id as 'AUTHOR ID', au.au_lname as 'LAST NAME',au.au_fname as 'FIRST NAME', IFNULL(SUM(sa.qty),0) as 'TOTAL'
FROM publications.authors au
LEFT JOIN publications.titleauthor ta on au.au_id = ta.au_id
LEFT JOIN publications.titles ti on ta.title_id = ti.title_id
LEFT JOIN publications.sales sa on ti.title_id = sa.title_id
GROUP BY au.au_lname, au.au_fname
ORDER BY SUM(sa.qty) DESC
LIMIT 23;

