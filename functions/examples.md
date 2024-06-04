### Create function
```
  CREATE OR REPLACE FUNCTION greet_employee (employee_name VARCHAR)
    RETURNS varchar
    AS $$
  BEGIN
    RETURN 'Hola ' || employee_name;
  END;
--$$
  LANGUAGE plpgsql;

  select first_name, greet_employee(first_name) from employees;
```

### Function with Params
```
CREATE OR REPLACE FUNCTION max_raise (empl_id int)
  RETURNS numeric(
    8, 2)
  AS $$
DECLARE
  possible_raise numeric(8, 2);
BEGIN
  SELECT
    max_salary - salary INTO possible_raise
  FROM
    employees
    INNER JOIN jobs ON jobs.job_id = employees.job_id
  WHERE
    employee_id = empl_id;
  RETURN possible_raise;
END
-- $$
LANGUAGE plpgsql;

SELECT
  employee_id,
  first_name,
  max_raise (employee_id)
FROM
  employees;
```

### Split Query in multiple queries
```
CREATE OR REPLACE FUNCTION max_raise2 (empl_id int)
	RETURNS numeric(
		8, 2)
	AS $$
DECLARE
	employee_job_id int;
	current_salary numeric(8, 2);
	job_max_salary NUMERIC(8, 2);
	possible_raise numeric(8, 2);
BEGIN
	SELECT
		job_id,
		salary INTO employee_job_id,
		current_salary
	FROM
		employees WHERE employee_id = empl_id;
	SELECT
		max_salary INTO job_max_salary
	FROM
		jobs
	WHERE
		job_id = employee_job_id;
	possible_raise = job_max_salary - current_salary;
	RETURN possible_raise;
END
--$$
LANGUAGE plpgsql;
```

### Conditionals and errors
```
CREATE OR REPLACE FUNCTION max_raise2 (empl_id int)
	RETURNS numeric(
		8, 2)
	AS $$
DECLARE
	employee_job_id int;
	current_salary numeric(8, 2);
	job_max_salary NUMERIC(8, 2);
	possible_raise numeric(8, 2);
BEGIN
	SELECT
		job_id,
		salary INTO employee_job_id,
		current_salary
	FROM
		employees
	WHERE
		employee_id = empl_id;
	SELECT
		max_salary INTO job_max_salary
	FROM
		jobs
	WHERE
		job_id = employee_job_id;
	possible_raise = job_max_salary - current_salary;
	if(possible_raise < 0) THEN
		possible_raise = 0;
	ELSif (possible_raise > 1000) THEN
		raise exception 'Person unavailable for raise: %', empl_id;
	END IF;
	RETURN possible_raise;
END
--$$
LANGUAGE plpgsql;

```

### Row Type
```
CREATE OR REPLACE FUNCTION max_raise2 (empl_id int)
	RETURNS numeric(
		8, 2)
	AS $$
DECLARE
	selected_employee employees % rowtype;
	selected_job jobs % rowtype;
	possible_raise numeric(8, 2);
BEGIN
	SELECT
		*
	FROM
		employees INTO selected_employee
	WHERE
		employee_id = empl_id;
	SELECT
		*
	FROM
		jobs INTO selected_job
	WHERE
		job_id = selected_employee.job_id;
	possible_raise = selected_job.max_salary - selected_employee.salary;
	if(possible_raise < 0) THEN
		possible_raise = 0;
	ELSif (possible_raise > 1000) THEN
		raise exception 'Person unavailable for raise: id:%, %', selected_employee.employee_id, selected_employee.first_name;
	END IF;
	RETURN possible_raise;
END
-$$
LANGUAGE plpgsql;
```
