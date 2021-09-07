-- Challenge 1 -----------------------------
select au.au_id as 'Author_ID',
au.au_lname as 'Last_Name',
au.au_fname as 'First_Name',
tl.title as 'Title_ID', 
pb.pub_name as 'Publisher'
from publishers.authors au 
inner join publishers.titleauthor tau on au.au_id = tau.au_id
left join  publishers.titles tl on tau.title_id = tl.title_id
left join  publishers.publishers pb on  tl.pub_id = pb.pub_id 
order by Author_ID asc;

-- Challenge 2 -----------------------------
select au.au_id as 'Author_ID',
au.au_lname as 'Last_Name',
au.au_fname as 'First_Name',
pb.pub_name as 'Publisher',
count(tl.title_id) as 'Count_Title'
from publishers.authors au 
inner join publishers.titleauthor tau on au.au_id = tau.au_id
left join  publishers.titles tl on tau.title_id = tl.title_id
left join  publishers.publishers pb on  tl.pub_id = pb.pub_id
group by Author_ID , pb.pub_name
order by Author_ID desc;

-- Challenge 3----------------------------------------------
select 
au.au_id as 'Author_ID',
au.au_lname as 'Last_Name',
au.au_fname as 'First_Name',
sum(qty) as 'Total'
from publishers.authors au 
inner join publishers.titleauthor tau on au.au_id = tau.au_id
left join  publishers.titles tl on tau.title_id = tl.title_id
left join  publishers.sales sl on  tl.title_id = sl.title_id
group by Author_ID
order by Total desc
limit 3;

-- Challenge 4----------------------------------------------
select 
au.au_id as 'Author_ID',
au.au_lname as 'Last_Name',
au.au_fname as 'First_Name',
sum(qty) as 'Total'
from publishers.authors au 
inner join publishers.titleauthor tau on au.au_id = tau.au_id
left join  publishers.titles tl on tau.title_id = tl.title_id
left join  publishers.sales sl on  tl.title_id = sl.title_id
group by Author_ID
order by Total desc
;

