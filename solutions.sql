
-- Challenge 1 - Who Have Published What At Where?  ¿Quién ha publicado qué y dónde?

SELECT ta.au_id "AUTHOR ID", a.au_lname "LAST NAME", a.au_fname "FIRST NAME", t.title "TITLE", p.pub_name "PUBLISHER"
FROM titleauthor ta
INNER JOIN authors a on ta.au_id = a.au_id
INNER JOIN titles t on ta.title_id = t.title_id
INNER JOIN publishers p on t.pub_id = p.pub_id;

-- Challenge 2 - Who Have Published How Many At Where?  ¿Quién ha publicado cuántas en dónde?

SELECT ta.au_id "AUTHOR ID", a.au_lname "LAST NAME", a.au_fname "FIRST NAME", p.pub_name "PUBLISHER", count(t.title) "TITLE COUNT"
FROM titleauthor ta
INNER JOIN authors a on ta.au_id = a.au_id
INNER JOIN titles t on ta.title_id = t.title_id
INNER JOIN publishers p on t.pub_id = p.pub_id
GROUP BY ta.au_id, p.pub_id
ORDER BY count(t.title) desc;

-- Challenge 3 - Best Selling Authors  Autores más vendidos

SELECT a.au_id "AUTHOR ID", a.au_lname "LAST NAME", a.au_fname "FIRST NAME", sum(s.qty) "TOTAL"
FROM authors a
INNER JOIN titleauthor ta on a.au_id = ta.au_id
INNER JOIN sales s on ta.title_id = s.title_id
GROUP BY a.au_id
ORDER BY sum(s.qty) DESC
LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking    Ranking de autores más vendidos 

SELECT a.au_id "AUTHOR ID", a.au_lname "LAST NAME", a.au_fname "FIRST NAME", COALESCE(sum(s.qty), 0) "TOTAL"
FROM authors a
LEFT JOIN titleauthor ta on a.au_id = ta.au_id
LEFT JOIN sales s on ta.title_id = s.title_id
GROUP BY a.au_id
ORDER BY sum(s.qty) DESC;

-- Challenge 5 - Bonus Challenge - Most Profiting Authors   Los autores más lucrativos

SELECT titleauthor.au_id as 'AUTHOR ID', authors.au_lname as 'LAST NAME', authors.au_fname as 'FIRST NAME',
(titles.price * sales.qty) as 'TOTAL DE VENTAS', ((titles.price * sales.qty) * (titles.royalty/100)+ titles.advance) as 'PROFIT'
FROM titles
JOIN titleauthor on titleauthor.title_id = titles.title_id
JOIN authors on authors.au_id = titleauthor.au_id
LEFT JOIN sales on sales.title_id = titles.title_id 
ORDER BY Profit DESC
LIMIT 3
