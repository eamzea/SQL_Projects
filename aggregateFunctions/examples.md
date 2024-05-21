### Math - Count / Min / Max / Round / Sum
```
SELECT
	count(*) AS total,
	min(followers) AS min_followers,
	max(followers) AS max_followers,
	round(AVG(followers)) AS avg_followers,
	sum(followers) / COUNT(*) as avg_manual
FROM
	users
```

### Group By
```
SELECT
	count(*), followers
FROM
	users
WHERE
	followers = 4
	OR followers = 4999
GROUP BY
	followers
```

### Having By
```
SELECT
	count(*),
	country
FROM
	users
GROUP BY
	country
HAVING
	count(*) > 5
ORDER BY
	country ASC
```

### Distinct
```
SELECT DISTINCT ---> List all values without repetition
	country
FROM
	USERS
ORDER BY country
	ASC
```

### Filter emails based on domains
```
SELECT
	count(*),
	SUBSTRING(email, POSITION('@' IN email) + 1) AS DOMAIN
FROM
	users
GROUP BY
	SUBSTRING(email, POSITION('@' IN email) + 1)
HAVING
	count(*) > 1
```
