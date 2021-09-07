/************lab_mysql_select************/
/*DB: publications*/

/*Challenge 1 - Who Have Published What At Where?*/

SELECT authors.au_id AS "AUTHOR", 
       authors.au_lname AS "LAST NAME", 
       authors.au_fname AS "FIRST NAME", 
       titles.title AS "TITLE", 
       publishers.pub_id AS "PUBLISHERS"
         FROM authors
           INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id
           INNER JOIN titles ON titles.title_id = titleauthor.title_id
           INNER JOIN publishers ON publishers.pub_id = titles.pub_id
           ;

/**********************************************/
/**********************************************/
/**********************************************/

/*Challenge 2 - Who Have Published How Many At Where?*/

 SELECT authors.au_id AS "AUTHOR", 
       authors.au_lname AS "LAST NAME", 
       authors.au_fname AS "FIRST NAME", 
       publishers.pub_id AS "PUBLISHERS",
       COUNT(titles.title) AS "TITLE COUNT"
         FROM authors
           INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id
           INNER JOIN titles ON titles.title_id = titleauthor.title_id
           INNER JOIN publishers ON publishers.pub_id = titles.pub_id
           GROUP BY titles.title;

/**********************************************/
/**********************************************/
/**********************************************/

/*Challenge 3 - Best Selling Authors*/

 SELECT authors.au_id AS "AUTHOR", 
       authors.au_lname AS "LAST NAME", 
       authors.au_fname AS "FIRST NAME", 
       SUM(sales.qty) AS "TOTAL"
         FROM authors
           INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id
           INNER JOIN titles ON titles.title_id = titleauthor.title_id
           INNER JOIN sales ON sales.title_id = titles.title_id
		   GROUP BY authors.au_id
           ORDER BY SUM(sales.qty) DESC
           LIMIT 3;

/**********************************************/
/**********************************************/
/**********************************************/


/*Challenge 4 - Best Selling Authors Ranking*/

 SELECT authors.au_id AS "AUTHOR", 
       authors.au_lname AS "LAST NAME", 
       authors.au_fname AS "FIRST NAME", 
       IFNULL(SUM(sales.qty),0) AS "TOTAL"
         FROM authors
           LEFT JOIN titleauthor ON titleauthor.au_id = authors.au_id
           LEFT JOIN titles ON titles.title_id = titleauthor.title_id
           LEFT JOIN sales ON sales.title_id = titles.title_id
		   GROUP BY authors.au_id
           ORDER BY SUM(sales.qty) DESC
           ;

/**********************************************/
/**********************************************/
/**********************************************/

/*Bonus Challenge - Most Profiting Authors*/

 SELECT authors.au_id AS "AUTHOR", 
       authors.au_lname AS "LAST NAME", 
       authors.au_fname AS "FIRST NAME", 
       ((IFNULL(titles.price, 0)*IFNULL(sales.qty, 0)*IFNULL(titles.royalty, 0)*IFNULL(titleauthor.royaltyper, 0)/10000)+IFNULL(titles.advance, 0)) AS "PROFIT"
         FROM authors
           LEFT JOIN titleauthor ON titleauthor.au_id = authors.au_id
           LEFT JOIN titles ON titles.title_id = titleauthor.title_id
           LEFT JOIN sales ON sales.title_id = titles.title_id
		   GROUP BY authors.au_id
           ORDER BY ((IFNULL(titles.price, 0)*IFNULL(sales.qty, 0)*IFNULL(titles.royalty, 0)*IFNULL(titleauthor.royaltyper, 0)/10000)+IFNULL(titles.advance, 0)) DESC  
           LIMIT 3;