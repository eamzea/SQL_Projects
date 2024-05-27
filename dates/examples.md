### Filter using dates
```
SELECT
  *
FROM
  employees
WHERE
  hire_date > '1998-02-05'
ORDER BY
  hire_date;
```

### Aggregate Fns - max / min
```
SELECT
  max(hire_date) AS "new",
  min(hire_date) AS old
FROM
  employees
```

### Range
```
SELECT
  *
FROM
  employees
WHERE
  hire_date BETWEEN '1990-01-01'
  AND '2000-01-01'
```

### Intervals
```
SELECT
  max(hire_date),
  max(hire_date) + INTERVAL '1 days' AS days,
  max(hire_date) + INTERVAL '1 month' AS months,
  max(hire_date) + INTERVAL '1 year' AS years,
  max(hire_date) + INTERVAL '1 day' + INTERVAL '1 month' + INTERVAL '1 year' AS complete,
  date_part('year', now()) AS get_year,
  MAKE_INTERVAL (YEARS := date_part('year', now())::integer) as gen_interval,
  max(hire_date) + MAKE_INTERVAL (YEARS:= 23)
FROM
  employees;
```

### Get Diff
```
SELECT
  hire_date,
  MAKE_INTERVAL (YEARS := date_part('year', now())::integer - EXTRACT(YEARS FROM hire_date)::INTEGER) AS diff
FROM
  employees
ORDER BY
  diff DESC
```

### Update with interval
```
UPDATE
  employees
SET
  hire_date = hire_date + INTERVAL '24 years'
```

### Setting Ranges
```
SELECT
  first_name,
  last_name,
  hire_date,
  CASE WHEN hire_date > now() - INTERVAL '1 year' THEN
    'Range A'
  WHEN hire_date > now() - INTERVAL '3 year' THEN
    'Range B'
  WHEN hire_date > now() - INTERVAL '6 year' THEN
    'Range C'
  ELSE
    'Range D'
  END AS antiquiety
FROM
  employees
```
