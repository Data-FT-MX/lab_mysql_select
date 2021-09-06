#Challenge 1
select c1.au_id as 'Author ID',c1.au_lname as 'Last Name',c1.au_fname as 'First Name',c1.title as 'Title',c1.pub_name as 'Publisher'
from(
select tia.au_id,au.au_lname,au.au_fname,ti.title,pu.pub_name
from publications.titleauthor tia
left join publications.authors au on tia.au_id=au.au_id
left join publications.titles ti on tia.title_id=ti.title_id
inner join publications.publishers pu on ti.pub_id=pu.pub_id
order by tia.au_id
)as c1;
-- ----------------------------------------------------------
#Challenge 2
select c2.au_id as 'Author ID',c2.au_lname as 'Last Name',c2.au_fname as 'First Name',c2.pub_name as 'Publisher',c2.ti_count as 'Title Count'
from(
select tia.au_id,au.au_lname,au.au_fname,pu.pub_name,count(ti.title) as ti_count
from publications.titleauthor tia
left join publications.authors au on tia.au_id=au.au_id
left join publications.titles ti on tia.title_id=ti.title_id
inner join publications.publishers pu on ti.pub_id=pu.pub_id
group by pu.pub_name,au.au_id
order by ti_count desc
)as c2;
-- -------------------------------------------------------------------------------
# Challenge 3
select c3.au_id as 'Author ID',c3.au_lname as 'Last Name',c3.au_fname as 'First Name',c3.Total
from(
select tia.au_id,au.au_lname,au.au_fname,sum(sa.qty) as Total
from publications.titleauthor tia
left join publications.authors au on tia.au_id=au.au_id
left join publications.sales sa on tia.title_id=sa.title_id
group by tia.au_id
order by Total desc
limit 3
)as c3;
-- ----------------------------------------------------------------------------------------------
# Challenge 4
select c3.au_id as 'Author ID',c3.au_lname as 'Last Name',c3.au_fname as 'First Name',c3.Total
from(
select tia.au_id,au.au_lname,au.au_fname,sum(sa.qty) as Total
from publications.titleauthor tia
left join publications.authors au on tia.au_id=au.au_id
left join publications.sales sa on tia.title_id=sa.title_id
group by tia.au_id
order by Total desc
)as c3;
-- ------------------------------------------------------------------------------------------------
# Bonus
select query2.au_id as 'Author ID',query2.au_lname as 'Last Name',query2.au_fname as 'First Name',sum(query2.advance*query2.royaltyper/100+query2.royalties) as Profit
from(
	select query1.title_id,query1.au_id,query1.au_lname,query1.au_fname,sum(query1.sales_royalty) as royalties,query1.advance,query1.royaltyper
	from(
		select ti.title_id,au.au_id,au.au_lname,au.au_fname,ti.price*sa.qty*ti.royalty/100*tia.royaltyper/100 as sales_royalty,ti.advance,tia.royaltyper
		from publications.titleauthor tia
		left join publications.authors au on tia.au_id=au.au_id
		left join publications.titles ti on tia.title_id=ti.title_id
		left join publications.sales sa on ti.title_id=sa.title_id
	)as query1
	group by query1.title_id,query1.au_id
) as query2
group by query2.au_id
order by profit desc
limit 3;