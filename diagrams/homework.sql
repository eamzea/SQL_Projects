-- 1. Cuantos Post hay - 1050
SELECT
	count(*)
FROM
	posts;

-- 2. Cuantos Post publicados hay - 543

SELECT
	COUNT(*)
FROM
	posts
WHERE
	published = TRUE;


-- 3. Cual es el Post mas reciente
-- 544 - nisi commodo officia...2024-05-30 00:29:21.277

SELECT
	*
FROM
	posts
ORDER BY
	created_at DESC
LIMIT 1;



-- 4. Quiero los 10 usuarios con más post, cantidad de posts, id y nombre
/*
4	1553	Jessie Sexton
3	1400	Prince Fuentes
3	1830	Hull George
3	470	Traci Wood
3	441	Livingston Davis
3	1942	Inez Dennis
3	1665	Maggie Davidson
3	524	Lidia Sparks
3	436	Mccoy Boone
3	2034	Bonita Rowe
 */
SELECT
	count(*) AS posts_amount,
	users.user_id,
	users. "name"
FROM
	posts
	INNER JOIN users ON posts.created_by = users.user_id
GROUP BY
	users.user_id
ORDER BY
	posts_amount DESC
LIMIT 10;




-- 5. Quiero los 5 post con más "Claps" sumando la columna "counter"
/*
692	sit excepteur ex ipsum magna fugiat laborum exercitation fugiat
646	do deserunt ea
542	do
504	ea est sunt magna consectetur tempor cupidatat
502	amet exercitation tempor laborum fugiat aliquip dolore
 */
SELECT
	sum(claps.counter),
	posts.title
FROM
	claps
	INNER JOIN posts ON posts.post_id = claps.post_id
GROUP BY
	posts.post_id
ORDER BY
	sum(claps.counter)
	DESC
LIMIT 5;



-- 6. Top 5 de personas que han dado más claps (voto único no acumulado ) *count
/*
7	Lillian Hodge
6	Dominguez Carson
6	Marva Joyner
6	Lela Cardenas
6	Rose Owen
 */
SELECT
	count(*),
	users."name"
FROM
	claps
	INNER JOIN users ON claps.user_id = users.user_id
GROUP BY
	users."name"
ORDER BY
	count(*)
	DESC
LIMIT 5;
 
-- 7. Top 5 personas con votos acumulados (sumar counter)
/*
437	Rose Owen
394	Marva Joyner
386	Marquez Kennedy
379	Jenna Roth
364	Lillian Hodge
 */
SELECT
	sum(counter),
	users. "name"
FROM
	claps
	INNER JOIN users ON claps.user_id = users.user_id
GROUP BY
	users. "name"
ORDER BY
	sum(counter)
	DESC
LIMIT 5;
 
-- 8. Cuantos usuarios NO tienen listas de favoritos creada
-- 329

SELECT
	count(*)
FROM
	users
	LEFT JOIN user_lists ON users.user_id = user_lists.user_id
WHERE
	user_list_id IS NULL;



-- 9. Quiero el comentario con id
-- Y en el mismo resultado, quiero sus respuestas (visibles e invisibles)
-- Tip: union

/*
1	    648	1905	elit id...
3058	583	1797	tempor mollit...
4649	51	1842	laborum mollit...
4768	835	1447	nostrud nulla...
 */
SELECT
	*
FROM
	"comments"
WHERE
	comment_id = 1
UNION
SELECT
	*
FROM
	"comments"
WHERE
	comment_parent_id = 1;



-- ** 10. Avanzado
-- Investigar sobre el json_agg y json_build_object
-- Crear una única linea de respuesta, con las respuestas
-- del comentario con id 1 (comment_parent_id = 1)
-- Mostrar el user_id y el contenido del comentario
-- Salida esperada:

/*
"[{""user"" : 1797, ""comment"" : ""tempor mollit aliqua dolore cupidatat dolor tempor""}, {""user"" : 1842, ""comment"" : ""laborum mollit amet aliqua enim eiusmod ut""}, {""user"" : 1447, ""comment"" : ""nostrud nulla duis enim duis reprehenderit laboris voluptate cupidatat""}]"
 */
SELECT
	json_agg(json_build_object('user', comments.user_id, 'comment', comments. "content"))
FROM
	comments
WHERE
	comment_parent_id = 1;

-- ** 11. Avanzado
-- Listar todos los comentarios principales (no respuestas)
-- Y crear una columna adicional "replies" con las respuestas en formato JSON

SELECT
	a.*,
	(
		SELECT
			json_agg(json_build_object('user', b.user_id, 'comment', b. "content"))
		FROM
			comments b
		WHERE
			comment_parent_id = a.comment_id) AS replies
	FROM
		comments a
	WHERE
		comment_parent_id IS NULL;


-- With Function;

CREATE OR REPLACE FUNCTION comment_replies (id INTEGER)
	RETURNS json
	AS $$
DECLARE
	result json;
BEGIN
	SELECT
		json_agg(json_build_object('user', b.user_id, 'comment', b. "content")) INTO result
	FROM
		comments b
	WHERE
		comment_parent_id = id;
	RETURN result;
END;
$$
LANGUAGE plpgsql;

SELECT
	a.*,
	comment_replies (a.post_id) AS replies
FROM
	comments a
WHERE
	comment_parent_id IS NULL;

