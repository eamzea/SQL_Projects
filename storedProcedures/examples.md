### Create Function that returns table
```
CREATE OR REPLACE FUNCTION country_region ()
  RETURNS TABLE (
    id CHARACTER (2), name varchar(40), region varchar(25))
  AS $$
BEGIN
  RETURN query
  SELECT
    country_id,
    country_name,
    region_name
  FROM
    countries
    INNER JOIN regions ON countries.region_id = regions.region_id;
END;
-$$
LANGUAGE plpgsql;

select * from country_region();
```

### Create SP without parameters name
```
CREATE OR REPLACE PROCEDURE insert_region_proc (int, varchar)
AS $$
BEGIN
  INSERT INTO regions (region_id, region_name)
    values($1, $2);
END;
-$$
LANGUAGE plpgsql;

CALL insert_region_proc (5, 'Central America');

SELECT
  *
FROM
  regions;
```

### SP wit Rollback
```
CREATE OR REPLACE PROCEDURE insert_region_proc (int, varchar)
AS $$
BEGIN
  INSERT INTO regions (region_id, region_name)
    values($1, $2);
  raise notice 'Variable 1: % ', $1;
  ROLLBACK;
END;
-$$
LANGUAGE plpgsql;

CALL insert_region_proc (6, 'Central America 1');

SELECT
  *
FROM
  regions;
```

### SP modifying table
```
CREATE OR REPLACE PROCEDURE controlled_raised (percentage NUMERIC)
AS $$
DECLARE
	real_percentage numeric(8, 2);
	total_employees int;
BEGIN
	real_percentage = percentage / 100;
	INSERT INTO raise_history (date, employee_id, base_salary, amount, percentage)
SELECT
	CURRENT_DATE AS "date",
	employee_id,
	 salary,
	max_raise (employee_id) * real_percentage AS amount,
	percentage
FROM
	employees;
		UPDATE
			employees
		SET
			salary = (max_raise (employee_id) * real_percentage) + salary;
		COMMIT;
		SELECT
			count(*) INTO total_employees
		FROM
			employees;
		raise notice 'Afectado % empleados', total_employees;
END;
-$$
LANGUAGE plpgsql;
```
