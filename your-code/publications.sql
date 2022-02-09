#CHALLENGE 1

SELECT au.au_id as 'AUTHOR_ID', au.au_lname as 'LAST_NAME', au.au_fname as 'FISRT_NAME', ts.title as 'TITLES', pu.pub_name as 'PUBLISHER'
FROM publications.authors au
LEFT JOIN publications.titleauthor ti ON au.au_id = ti.au_id
LEFT JOIN publications.titles ts ON ti.title_id = ts.title_id
LEFT JOIN publications.publishers pu ON ts.pub_id = pu.pub_id;

#CHALLENGE 2

SELECT au.au_id as 'AUTHOR_ID', au.au_lname as 'LAST_NAME', au.au_fname as 'FISRT_NAME', pu.pub_name as 'PUBLISHER', ts.title as 'TITLES', COUNT(ts.title) as 'TITLE_COUNT'
FROM publications.authors au
LEFT JOIN publications.titleauthor ti ON au.au_id = ti.au_id
LEFT JOIN publications.titles ts ON ti.title_id = ts.title_id
LEFT JOIN publications.publishers pu ON ts.pub_id = pu.pub_id
GROUP BY au.au_id, pu.pub_name;

#CHALLENGE 3

SELECT au.au_id as 'AUTHOR_ID', au.au_lname as 'LAST_NAME', au.au_fname as 'FISRT_NAME',  SUM(sa.qty) as TOTAL
FROM publications.titleauthor ti
LEFT JOIN publications.authors au ON ti.au_id = au.au_id
LEFT JOIN publications.sales sa ON ti.title_id = sa.title_id 
GROUP BY sa.qty 
ORDER BY TOTAL DESC
LIMIT 3;

#CHALLENGE 4

SELECT au.au_id as 'AUTHOR_ID', au.au_lname as 'LAST_NAME', au.au_fname as 'FISRT_NAME',  IFNULL(SUM(sa.qty), 0) as TOTAL
FROM publications.authors au
LEFT JOIN publications.titleauthor ti ON au.au_id = ti.au_id
LEFT JOIN publications.sales sa ON ti.title_id = sa.title_id 
GROUP BY sa.qty
ORDER BY TOTAL DESC;





