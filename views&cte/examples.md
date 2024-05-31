### Create View
```
CREATE VIEW comments_per_week AS
SELECT
  date_trunc(
    'week', posts.created_at) AS weeks,
  count(
    DISTINCT posts.post_id) AS number_of_posts,
  sum(
    claps.counter) AS total_claps
FROM
  posts
  INNER JOIN claps ON claps.post_id = posts.post_id
GROUP BY
  weeks
ORDER BY
  weeks DESC;
```

### Rename View
```
ALTER VIEW comments_per_week RENAME TO posts_per_week;
```

### Create Materialized View
```
CREATE MATERIALIZED VIEW comments_per_week_mat AS
SELECT
  date_trunc(
    'week', posts.created_at) AS weeks,
  count(
    DISTINCT posts.post_id) AS number_of_posts,
  sum(
    claps.counter) AS total_claps
FROM
  posts
  INNER JOIN claps ON claps.post_id = posts.post_id
GROUP BY
  weeks
ORDER BY
  weeks DESC;
```

### Update Materialized View
```
REFRESH MATERIALIZED VIEW comments_per_week_mat
```

### Rename Materialized View
```
ALTER MATERIALIZED VIEW comments_per_week_mat RENAME TO posts_per_week_mat;
```

### Common Table Expressions - Table memoized
```
WITH posts_week_2024 AS (
  SELECT
    date_trunc('week',
      posts.created_at) AS weeks,
    count(DISTINCT posts.post_id) AS number_of_posts,
    sum(claps.counter) AS total_claps
  FROM
    posts
    INNER JOIN claps ON claps.post_id = posts.post_id
  GROUP BY
    weeks
  ORDER BY
    weeks DESC
)
SELECT
  *
FROM
  posts_week_2024
WHERE
  weeks BETWEEN '2024-01-01'
  AND '2024-12-31'
  AND total_claps >= 600;
```

### Multiple CTE
```
WITH claps_per_post AS (
  SELECT
    post_id,
    sum(counter)
  FROM
    claps
  GROUP BY
    post_id
),
posts_from_2023 AS (
  SELECT
    *
  FROM
    posts
  WHERE
    created_at BETWEEN '2023-01-02'
    AND '2023-12-31'
)
SELECT
  *
FROM
  claps_per_post
WHERE
  claps_per_post.post_id in(
    SELECT
      post_id FROM posts_from_2023);
```

### Recursive Query
```
WITH RECURSIVE countdown (
  val
) AS (
  SELECT
    5 AS val
  UNION
  SELECT
    val - 1
  FROM
    countdown
  WHERE
    val > 1
)
SELECT
  *
FROM
  countdown
```

### Recursive Query N n times
```
WITH RECURSIVE mult (
  base, val, result
) AS (
  SELECT
    5 AS base, 1 as val, 5 as result
  UNION
  SELECT
    5 as base, val + 1, (val + 1) * base
  FROM
    mult
  WHERE
    val < 10
)
SELECT
  *
FROM
  mult
```

### Recursive -> Reports to example
```
CREATE TABLE employees (
	"id" serial NOT NULL,
	"name" VARCHAR,
	"reports_to" int
);

INSERT INTO employees (name, reports_to)
		values('Jefe Carlos', NULL), ('SubJefe Susana', 1), ('SubJefe Juan', 1), ('Gerente Pedro', 3), ('Gerente Melissa', 3), ('Gerente Carmen', 2), ('SubGerente Ramiro', 5), ('Programador Fernando', 7), ('Programador Eduardo', 7), ('Presidente Karla', NULL);

SELECT
	*
FROM
	employees;

WITH RECURSIVE bosses AS (
	SELECT
		id,
		name,
		reports_to
	FROM
		employees
	WHERE
		id = 1
	UNION
	SELECT
		employees.id,
		employees.name,
		employees.reports_to
	FROM
		employees
		INNER JOIN bosses ON bosses.id = employees.reports_to
)
SELECT
	*
FROM
	bosses;
```

### Recursive Query with depth
```
SELECT
	*
FROM
	employees;

WITH RECURSIVE bosses AS (
	SELECT
		id,
		name,
		reports_to,
		1 AS depth
	FROM
		employees
	WHERE
		id = 1
	UNION
	SELECT
		employees.id,
		employees.name,
		employees.reports_to,
		depth + 1
	FROM
		employees
		INNER JOIN bosses ON bosses.id = employees.reports_to
	WHERE
		depth < 4
)
SELECT
	*
FROM
	bosses;
```
