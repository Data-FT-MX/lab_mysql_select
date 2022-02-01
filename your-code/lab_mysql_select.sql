use publications;

select au.au_id, au.au_lname, au.au_fname, ti.title, pub.pub_name
from publications.authors au
left join titleauthor ta 
on au.au_id = ta.au_id
inner join titles ti 
on ta.title_id = ti.title_id
inner join publishers pub
on ti.pub_id = pub.pub_id;




-- ---------------------------------------------------------------------------
select au.au_id, au.au_lname, au.au_fname, pub.pub_name, count(ti.title) as 'Title count'
from publications.authors au
left join titleauthor ta 
on au.au_id = ta.au_id
inner join titles ti 
on ta.title_id = ti.title_id
inner join publishers pub
on ti.pub_id = pub.pub_id
group by au.au_id, au.au_lname, au.au_fname, pub.pub_name
order by au.au_id desc;


-- ------------------------------------------------------------
select au.au_id, au.au_lname, au.au_fname, ti.title, sum(sal.qty) as 'title_sold'
from publications.authors au
left join titleauthor ta 
on au.au_id = ta.au_id
inner join titles ti 
on ta.title_id = ti.title_id
inner join sales sal
on ti.title_id = sal.title_id
group by au.au_id, au.au_lname, au.au_fname
order by title_sold desc
limit 3;
-- --------------------------------------------------------------------
create temporary table publications.temp
SELECT au.au_id , au.au_lname, au.au_fname, SUM(sal.qty) AS 'title_sold'
FROM publications.authors au
LEFT JOIN titleauthor ta ON au.au_id = ta.au_id
left JOIN titles ti ON ta.title_id  = ti.title_id
left JOIN sales sal ON ti.title_id = sal.title_id
GROUP BY au.au_id , au.au_lname, au.au_fname
ORDER BY title_sold DESC;

select fin.au_id, fin.au_lname, fin.au_fname, ifnull(title_sold,0) as 'total'
from publications.temp fin;

