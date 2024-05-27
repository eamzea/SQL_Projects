-- ¿Cuál es el idioma (y código del idioma) oficial más hablado por diferentes países en Europa?;
SELECT
	count(*),
	b.languagecode,
	b. "language"
FROM
	country a
	INNER JOIN countrylanguage b ON a.code = b.countrycode
WHERE
	continent = 5
	AND b.isofficial = TRUE
GROUP BY
	b.languagecode,
	b. "language"
ORDER BY
	count(*)
	DESC
LIMIT 1;

-- Listado de todos los países cuyo idioma oficial es el más hablado de Europa
-- (no hacer subquery, tomar el código anterior)

SELECT
	*
FROM
	country a
	INNER JOIN countrylanguage b ON a.code = b.countrycode
WHERE
	a.continent = 5
	AND b.isofficial = TRUE
	AND b.languagecode = 135;