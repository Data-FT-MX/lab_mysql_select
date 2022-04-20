SELECT au.au_id, au.au_lname, au.au_fname, ti.title, pub.pub_name
FROM publications.authors au
LEFT JOIN publications.titleauthor ti_a
ON au.au_id = ti_a.au_id
INNER JOIN publications.titles ti
ON ti_a.title_id = ti.title_id
INNER JOIN publications.publishers pub
ON pub.pub_id = ti.pub_id;

SELECT COUNT(*)
FROM publications.titleauthor;

SELECT COUNT(*)
FROM(
SELECT au.au_id, au.au_lname, au.au_fname, ti.title, pub.pub_name
FROM publications.authors au
LEFT JOIN publications.titleauthor ti_a
ON au.au_id = ti_a.au_id
INNER JOIN publications.titles ti
ON ti_a.title_id = ti.title_id
INNER JOIN publications.publishers pub
ON pub.pub_id = ti.pub_id) as Piloto; 

# CHALENGE 1
#--------------------------------------------------------------------------------------------------------------
SELECT au.au_id, au.au_lname, au.au_fname, COUNT(ti.title), pub.pub_name
FROM publications.authors au
LEFT JOIN publications.titleauthor ti_a
ON au.au_id = ti_a.au_id
INNER JOIN publications.titles ti
ON ti_a.title_id = ti.title_id
INNER JOIN publications.publishers pub
ON pub.pub_id = ti.pub_id
GROUP BY pub.pub_name, au.au_id, au.au_lname, au.au_fname
ORDER BY au.au_id desc;

# CHALENGE 2
#--------------------------------------------------------------------------------------------------------------

SELECT au.au_id, au.au_lname, au.au_fname, sum(sal.qty)
FROM publications.authors au
LEFT JOIN publications.titleauthor ti_a
ON au.au_id = ti_a.au_id
INNER JOIN publications.titles ti
ON ti_a.title_id = ti.title_id
INNER JOIN publications.sales sal
ON sal.title_id = ti.title_id
group by au.au_id, au.au_lname, au.au_fname
order by sum(sal.qty) desc
Limit 3;

#Chalenge 3
#-----------------------------------------------------------------------------------------------------------
#SELECT IFNULL(total, 0) 
#FROM (
SELECT au.au_id, au.au_lname, au.au_fname, IFNULL(sum(sal.qty),0) as 'total' 
FROM publications.authors au
LEFT JOIN publications.titleauthor ti_a
ON au.au_id = ti_a.au_id
LEFT JOIN publications.titles ti
ON ti_a.title_id = ti.title_id
LEFT JOIN publications.sales sal
ON sal.title_id = ti.title_id
group by au.au_id, au.au_lname, au.au_fname
order by sum(sal.qty) desc; #) as Piloto_2;

#CHALLENGE 4 
#--------------------------------------------------------------------------------------------------------------------------------------

