
# challenge 1

CREATE TABLE lab_select.datos_author
select ti.au_id  ,au_lname,au_fname,tit.title,pub.pub_name
from lab_select.authors aut
INNER JOIN lab_select.titleauthor ti ON aut.au_id = ti.au_id
left join lab_select.titles tit ON ti.title_id = tit.title_id
left join lab_select.publishers pub ON tit.pub_id = pub.pub_id;

drop table lab_select.datos_author_count;

select ti.au_id as 'Author ID' ,au_lname As 'Last Name' ,au_fname as 'First Name' ,tit.title as 'Title',pub.pub_name as 'Publisher'
from lab_select.authors aut
left JOIN lab_select.titleauthor ti ON aut.au_id = ti.au_id
left join lab_select.titles tit ON ti.title_id = tit.title_id
inner join lab_select.publishers pub ON tit.pub_id = pub.pub_id;

# challenge 2

select ti.au_id as 'Author ID' ,au_lname As 'Last Name' ,au_fname as 'First Name' ,tit.title as 'Title',pub.pub_name as 'Publisher', 
count(tit.title) as 'Title_Count'
from lab_select.authors aut
left JOIN lab_select.titleauthor ti ON aut.au_id = ti.au_id
left join lab_select.titles tit ON ti.title_id = tit.title_id
inner join lab_select.publishers pub ON tit.pub_id = pub.pub_id
group by pub.pub_name,aut.au_id
order by Title_Count desc;

# challenge 3

select ti.au_id as 'Author ID' ,au_lname As 'Last Name' ,au_fname as 'First Name' ,tit.title as 'Title',
 sum(sa.qty) as sa_total
from lab_select.authors aut
left JOIN lab_select.titleauthor ti ON aut.au_id = ti.au_id
left join lab_select.titles tit ON ti.title_id = tit.title_id
inner join lab_select.publishers pub ON tit.pub_id = pub.pub_id
left join lab_select.sales sa on tit.title_id=sa.title_id
group by aut.au_id
order by sa_total desc
LIMIT 3;

# challenge 3

select ti.au_id as 'Author ID' ,au_lname As 'Last Name' ,au_fname as 'First Name' ,tit.title as 'Title',
 sum(sa.qty) as sa_total
from lab_select.authors aut
left JOIN lab_select.titleauthor ti ON aut.au_id = ti.au_id
left join lab_select.titles tit ON ti.title_id = tit.title_id
inner join lab_select.publishers pub ON tit.pub_id = pub.pub_id
left join lab_select.sales sa on tit.title_id=sa.title_id
group by aut.au_id
order by sa_total desc
LIMIT 3;

#challenge 4

select ti.au_id as 'Author ID' ,au_lname As 'Last Name' ,au_fname as 'First Name' ,tit.title as 'Title',
 sum(sa.qty) as sa_total
from lab_select.authors aut
left JOIN lab_select.titleauthor ti ON aut.au_id = ti.au_id
left join lab_select.titles tit ON ti.title_id = tit.title_id
inner join lab_select.publishers pub ON tit.pub_id = pub.pub_id
left join lab_select.sales sa on tit.title_id=sa.title_id
group by aut.au_id
order by sa_total desc
LIMIT 23;
