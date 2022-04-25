SELECT au.au_id, au.au_lname, au.au_fname, ti.title, pub.pub_name
FROM publications.authors au
LEFT JOIN publications.titleauthor ti_au
ON au.au_id = ti_au.au_id
INNER JOIN publications.titles ti
ON ti_au.title_id = ti.title_id
INNER JOIN publications.publishers pub
ON pub.pub_id = ti.pub_id;

SELECT COUNT(*)
FROM publications.titleauthor;

-- 
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title), publishers.pub_name 
FROM publications.authors
LEFT JOIN publications.titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN publications.titles
ON titleauthor.title_id = titles.title_id
INNER JOIN publications.publishers
ON publishers.pub_id = titles.pub_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname,publishers.pub_name 
ORDER BY authors.au_id DESC;



SELECT authors.au_id, authors.au_lname, authors.au_fname, SUM(sales.qty)
FROM publications.authors
LEFT JOIN publications.titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN publications.titles
ON titleauthor.title_id = titles.title_id
INNER JOIN publications.sales
ON sales.title_id = titles.title_id
GROUP BY authors.au_id
ORDER BY SUM(sales.qty) DESC
LIMIT 3;


SELECT au.au_id, au.au_lname, au.au_fname, IFNULL(sum(sal.qty), 0) as 'total' 
FROM publications.authors au
LEFT JOIN publications.titleauthor ti_a
ON au.au_id = ti_a.au_id
LEFT JOIN publications.titles ti
ON ti_a.title_id = ti.title_id
LEFT JOIN publications.sales sal
ON sal.title_id = ti.title_id
group by au.au_id, au.au_lname, au.au_fname
order by sum(sal.qty) desc;