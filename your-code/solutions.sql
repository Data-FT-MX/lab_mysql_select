-- Challenge 1:

SELECT au.au_id as 'author_ID',
au.au_lname as 'last_name',
au.au_fname as 'first_name',
ti.title, pu.pub_name
FROM publications.authors au
INNER JOIN publications.titleauthor ta ON au.au_id = ta.au_id
LEFT JOIN publications.titles ti ON ta.title_id = ti.title_id
LEFT JOIN publications.publishers pu ON ti.pub_id = pu.pub_id
ORDER BY author_ID ASC;

-- Challenge 2: