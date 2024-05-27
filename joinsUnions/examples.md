### Search multiple values with IN
```
SELECT
  *
FROM
  continent
WHERE
  code in(4, 5, 6)
```

### Union Table
Works similar to AND
```
SELECT
  *
FROM
  continent
WHERE
  code in(4, 5, 6)
UNION
SELECT
  *
FROM
  continent
WHERE
  name LIKE '%America%'
```

### JOIN using where

Country has continent relation so it is going to show a table with each country with the each continent explicit relation

**Before**
| name        | country   |
| :---------: | :-------: |
| Afghanistan | 3         |
| Albania     | 5         |
| Algeria     | 1         |

**After**

  | name        | continent |
  | :---------: | :-------: |
  | Afghanistan | Asia      |
  | Albania     | Europe    |
  | Algeria     | Africa    |

```
SELECT
  a.name AS country,
  b.name AS continent
FROM
  country a,
  continent b
WHERE
  a.continent = b.code
ORDER BY
  a.name ASC
```

### Inner Join
```
SELECT
  a.name AS country,
  b.name AS continent
FROM
  country a
  INNER JOIN continent b ON a.continent = b.code
ORDER BY
  a.name ASC;
```

### Alter Sequence
```
ALTER SEQUENCE continent_code_seq
  RESTART WITH 9
```

### Full Outer Join - Show all elements
```
SELECT
  a.name AS country,
  a.continent AS continent_code,
  b.name AS continent_name
FROM
  country a
  FULL OUTER JOIN continent b ON a.continent = b.code;
```

### Right Outer Join with exclusion
```
SELECT
  a.name AS country,
  a.continent AS continent_code,
  b.name AS continent_name
FROM
  country a
  RIGHT JOIN continent b ON a.continent = b.code
WHERE
  a.continent IS NULL
```

### Aggregates + Joins
```
SELECT
  count(*) AS count,
  b. "name"
FROM
  country a
  INNER JOIN continent b ON a.continent = b.code
GROUP BY
  b.name
UNION
SELECT
  0 AS count,
  b.name
FROM
  country a
  RIGHT JOIN continent b ON a.continent = b.code
WHERE
  a.continent IS NULL
GROUP BY
  b.name
ORDER BY
  count
```

### Get country with the highest amount of cities
```
SELECT
	count(*) AS "Cities Amount",
	a. "name" AS "Country"
FROM
	country a
	INNER JOIN city b ON a.code = b.countrycode
GROUP BY
	a. "name"
ORDER BY
	"Cities Amount" DESC
LIMIT 1
```

### Count amount of languages on each continent
```
SELECT
	count(*),
	continent
FROM ( SELECT DISTINCT
		a. "language",
		c. "name" AS continent
	FROM
		countrylanguage a
		INNER JOIN country b ON a.countrycode = b.code
		INNER JOIN continent c ON c.code = b.continent
	WHERE
		a.isofficial = TRUE) AS totales
GROUP BY
	continent
ORDER BY
	count(*)
```
