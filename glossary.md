### Query Order
```
SELECT
WHERE
JOINS
GROUP BY
HAVING
ORDER BY
LIMIT
OFFSET
```

### DDL - Data Definition Language
Create / Alter / Drop / Truncate

### DML - Data Manipulation Language
Insert / Delete / Update

### TCl - Transaction Control Language
Commit / Rollback

### DQL - Data Query Language
Select

### Keys
- Primary Key -----> employee_id inside employee
- Super Key -------> employee_id + full_name / mix of keys
- Foreign Key -----> department_id / key inside employee but primary key of department table
- Candidate Key ---> passport_number/license_number inside employee / unique key
- Composite Key ---> employee_id, role, project_id multiple keys to build primary key

### Unions
Should have the same amount of columns and those should have the same type
> Good ✅
```
SELECT
	name,
	code
FROM
	continent
WHERE
	code in(4, 5, 6)
UNION
SELECT
	name,
	code
FROM
	continent
WHERE
	name LIKE '%America%'
```
> Bad ❌
```
SELECT
	code, -> this is an integer
	name
FROM
	continent
WHERE
	code in(4, 5, 6)
UNION
SELECT
	name, -> this is a string
	code
FROM
	continent
WHERE
	name LIKE '%America%'
```
