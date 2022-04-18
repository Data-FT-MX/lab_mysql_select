-- -----------------------------------------------------------------------------
# CHALLENGE 1. Who Have Published What At Where?
-- -----------------------------------------------------------------------------
CREATE TEMPORARY TABLE publications.info
SELECT 
pa.au_id AS  'Author_ID',
pa.au_lname AS 'Last_Name',
pa.au_fname AS 'First_Name',
pt.title AS 'Title',
pp.pub_name AS 'Publisher'	
FROM publications.titles AS pt
INNER JOIN publications.titleauthor AS pta
ON pt.title_id = pta.title_id
INNER JOIN publications.publishers AS pp 
ON pt.pub_id = pp.pub_id
INNER JOIN publications.authors as pa
ON pta.au_id= pa.au_id;

# Verificacion de resultados
SELECT *   #count(Title)
From publications.info
ORDER BY Author_ID;

-- -----------------------------------------------------------------------------
# CHALLENGE 2. Who Have Published How Many At Where?
-- -----------------------------------------------------------------------------
SELECT Author_ID, Last_Name, First_Name, Publisher, 
COUNT(Title) AS 'Title_Count'
FROM publications.info
GROUP BY Author_ID, Publisher 
ORDER BY Author_ID desc;

-- -----------------------------------------------------------------------------
# CHALLENGE 3. Best Selling Authors.
-- -----------------------------------------------------------------------------
SELECT
pa.au_id AS 'Author_ID',
pa.au_lname AS 'Last_Name',
pa.au_fname AS 'First_Name',
sum(ps.qty) AS 'Total'
FROM publications.authors AS pa
LEFT JOIN publications.titleauthor AS ta 
ON pa.au_id = ta.au_id
INNER JOIN publications.titles as pt
ON ta.title_id = pt.title_id
INNER JOIN publications.sales as ps
ON pt.title_id = ps.title_id
GROUP BY Author_id
ORDER BY Total DESC
limit 3;

#Este ejercicio se resolvio en pareja, sin embargo tengo mis dudas al respecto:

SELECT
pt.title AS 'titulo',
sum(ps.qty) AS 'vendido'
FROM publications.sales ps
RIGHT JOIN publications.titles pt
ON ps.title_id=pt.title_id
GROUP BY titulo
ORDER BY vendido DESC;

/*si miramos el total de ventas en publications.sales.qty, veremos que solamente hay 493 ventas, el codigo de arriba muestra el ejemplar
y la cantidad vendida sin autor; ahora, cuando añadimos mas tablas para dar nombre a los autores de los libros, esas cifras empiezan 
a multiplicarse y dan valores incorrectos y tengo entendido que es porque al juntarse las tablas los id se repiten y por ende se repite
el valor de ventas vendidas, resultando en la primera respuesta.   
*/
-- -----------------------------------------------
# Challengue 4. Best Selling Authors Ranking
-- -----------------------------------------------
SELECT
pa.au_lname as 'apellido',
pa.au_fname as 'nombre',
count(ps.qty) as 'Total' 
FROM publications.titleauthor ta
left join publications.titles pt
on ta.title_id=pt.title_id
left join publications.sales ps
on pt.title_id=ps.title_id
right join publications.authors pa
on ta.au_id=pa.au_id
group by apellido, nombre
order by total DESC
