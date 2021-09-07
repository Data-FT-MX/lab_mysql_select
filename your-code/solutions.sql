-- CHALLENGE #1 -----------------------------------------------
USE publications;

SELECT au.au_id as 'author_id', au.au_lname as 'last_name',
au.au_fname as 'first_name', ti.title, pu.pub_name as 'publisher_name'
FROM authors au
INNER JOIN titleauthor ta ON au.au_id = ta.au_id # Usamos INNER JOIN  ya que estamos pasando por una tabla sin datos ademas de los ID
LEFT JOIN titles ti ON ta.title_id = ti.title_id
LEFT JOIN publishers pu ON ti.pub_id = pu.pub_id
ORDER BY author_id ASC;

/*
Lo usamos como comprobacion
SELECT COUNT(au_id)
FROM titleauthor;
*/

-- CHALLENGE #2 -----------------------------------------------

SELECT au.au_id as 'author_id', au.au_lname as 'last_name',
au.au_fname as 'first_name', pu.pub_name as 'publisher_name',
COUNT(title) as 'title_count'
FROM authors au
INNER JOIN titleauthor ta ON au.au_id = ta.au_id # Usamos INNER JOIN  ya que estamos pasando por una tabla sin datos ademas de los ID
LEFT JOIN titles ti ON ta.title_id = ti.title_id
LEFT JOIN publishers pu ON ti.pub_id = pu.pub_id
GROUP BY publisher_name, author_id
ORDER BY author_id DESC, publisher_name DESC;

-- CHALLENGE #3 -----------------------------------------------

SELECT au.au_id as 'author_id', au.au_lname as 'last_name',
au.au_fname as 'first_name', SUM(sa.qty) as 'total'
FROM authors au
INNER JOIN titleauthor ta ON au.au_id = ta.au_id
LEFT JOIN titles ti ON ta.title_id = ti.title_id
LEFT JOIN sales sa ON ti.title_id = sa.title_id
GROUP BY author_id
ORDER BY total DESC
LIMIT 3;

-- CHALLENGE #4 -----------------------------------------------

# Tenemos 19 autores no 23. Esto es debido a que varios autores tienen libros publicados en varias editoriales.
# Si tomamos en cuenta el total de libros publicados y agrupamos el resultado por autores, entonces tenemos 19 autores unicos

SELECT au.au_id as 'author_id', au.au_lname as 'last_name',
au.au_fname as 'first_name', SUM(sa.qty) as 'total'
FROM authors au
INNER JOIN titleauthor ta ON au.au_id = ta.au_id
LEFT JOIN titles ti ON ta.title_id = ti.title_id
LEFT JOIN sales sa ON ti.title_id = sa.title_id
GROUP BY author_id
ORDER BY total DESC;

-- CHALLENGE #BONUS -----------------------------------------------

SELECT trta.author_id, trta.last_name, trta.first_name, SUM(trta.sum_per_title + trta.advance) as 'profit'
FROM (
	SELECT ra.title_id, ra.author_id, ra.last_name, ra.first_name, ra.advance, 
           SUM(ra.royalty_each_autor) AS 'sum_per_title'
	FROM (
		SELECT au.au_id as 'author_id', ti.title_id as 'title_id', au.au_lname as 'last_name',
		au.au_fname as 'first_name', ti.advance * (ta.royaltyper/100) as 'advance',
		ti.price * sa.qty * (ti.royalty/100) * (ta.royaltyper/100) as 'royalty_each_autor'
		FROM authors au
		INNER JOIN titleauthor ta ON au.au_id = ta.au_id
		LEFT JOIN titles ti ON ta.title_id = ti.title_id
		LEFT JOIN sales sa ON ti.title_id = sa.title_id
    ) as ra # royalty_autor
	GROUP BY ra.title_id, ra.author_id
) as trta #total_royalties_title_author
GROUP BY trta.author_id
ORDER BY profit DESC
LIMIT 3;