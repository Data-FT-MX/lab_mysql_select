#CHALLENGE 1 what titles each author has published at which publishers.
CREATE TEMPORARY TABLE publications.autor_temporal
SELECT pau.au_id, pau.au_fname, pau.au_lname, ptit.title, ptit.pub_id
FROM publications.authors pau
INNER JOIN publications.titleauthor pti
ON pau.au_id = pti.au_id
LEFT JOIN publications.titles ptit
ON pti.title_id = ptit.title_id;

SELECT *
FROM publications.autor_temporal;



SELECT paut.au_id, paut.au_fname, paut.au_lname, paut.title, pp.pub_id, pp.pub_name
FROM publications.autor_temporal paut
LEFT JOIN publications.publishers pp
ON paut.pub_id = pp.pub_id;

# Challenge 2 - Who Have Published How Many At Where?

SELECT paut.au_id, paut.au_lname, paut.au_fname, pp.pub_name, COUNT(paut.title) as 'count_title'
FROM publications.autor_temporal paut
LEFT JOIN publications.publishers pp
ON paut.pub_id = pp.pub_id
GROUP BY paut.au_id;


SELECT sum(count_title)
FROM(
	SELECT paut.au_id, paut.au_lname, paut.au_fname, pp.pub_name, COUNT(paut.title) as 'count_title'
	FROM publications.autor_temporal paut
	LEFT JOIN publications.publishers pp
	ON paut.pub_id = pp.pub_id
	GROUP BY paut.au_id
    ) AS suma_titles;

SELECT COUNT(title_id)
FROM publications.titleauthor;
		
#Challenge 3 - Best Selling Authors
SELECT tas.au_id, tas.au_lname, tas.au_fname, tas.qty AS 'Total'
FROM(
	SELECT ta.au_id, ta.au_lname, ta.au_fname, ta.title_id, ps.qty, ps.payterms
	FROM(
		SELECT pau.au_id, pau.au_fname, pau.au_lname, ptit.title, ptit.pub_id, ptit.title_id
		FROM publications.authors pau
		INNER JOIN publications.titleauthor pti
		ON pau.au_id = pti.au_id
		LEFT JOIN publications.titles ptit
		ON pti.title_id = ptit.title_id
		) AS ta
	LEFT JOIN publications.sales ps
	ON ta.title_id = ps.title_id
    ) AS tas
WHERE tas.qty >= 50
GROUP BY tas.au_id
ORDER BY Total DESC;

#Challenge 4 - Best Selling Authors Ranking
SELECT tas.au_id, tas.au_lname, tas.au_fname, tas.qty AS 'Total'
FROM(
	SELECT ta.au_id, ta.au_lname, ta.au_fname, ta.title_id, ps.qty, ps.payterms
	FROM(
		SELECT pau.au_id, pau.au_fname, pau.au_lname, ptit.title, ptit.pub_id, ptit.title_id
		FROM publications.authors pau
		INNER JOIN publications.titleauthor pti
		ON pau.au_id = pti.au_id
		LEFT JOIN publications.titles ptit
		ON pti.title_id = ptit.title_id
		) AS ta
	LEFT JOIN publications.sales ps
	ON ta.title_id = ps.title_id
    ) AS tas
GROUP BY tas.au_id
ORDER BY Total DESC;

#Bonus Challenge - Most Profiting Authors
SELECT ta.au_id, ta.au_lname, ta.au_fname, ta.advance + ta.royalty AS 'profit'
FROM(
    SELECT pau.au_id, pau.au_fname, pau.au_lname, ptit.title, ptit.pub_id, ptit.advance, ptit.royalty
	FROM publications.authors pau
	INNER JOIN publications.titleauthor pti
	ON pau.au_id = pti.au_id
	LEFT JOIN publications.titles ptit
	ON pti.title_id = ptit.title_id
    ) AS ta
WHERE ta.advance + ta.royalty > 8010
GROUP BY ta.au_id
ORDER BY profit DESC;
