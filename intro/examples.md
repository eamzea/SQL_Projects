### Create Table
```
CREATE TABLE users (
	name VARCHAR(10) UNIQUE
);
```

### Insert Multiple Rows
```
INSERT INTO users
		(name)
	values
		('Edgar'),
		('Arturo'),
		('Gyda'),
		('Goddard');
```

### Update Rows
```
UPDATE
	users
SET
	name = 'Gyda'
WHERE
	name = 'Gordita'
```

### Select
```
SELECT
	*
FROM
	users
LIMIT 2 <--- Limit to show
OFFSET 2 <-- Skip X amount
```

### Like
```
-- Nombre inicie con J mayúscula
WHERE "name" LIKE 'J%';

-- Nombre inicie con Jo
WHERE "name" LIKE 'Jo%';

-- Nombre termine con hn
WHERE "name" LIKE '%hn';

-- Nombre tenga 3 letras y las últimas 2 tienen que ser "om"
WHERE "name" LIKE '_om'; // Tom

-- Puede iniciar con cualquier letra seguido de "om" y cualquier cosa después
WHERE "name" LIKE '_om%'; // Tomas
```

### Delete
```
DELETE FROM users
WHERE name = 'Edgar';
```

### Clear Out
```
TRUNCATE table users
```

### Modifiers
```
SELECT
	upper(name) AS upper_name, -------> Uppercase ---> EDGAR MORA
	lower(name) AS lower_name, -------> Lowercase ---> edgar mora
	length(name) AS length_name, -----> Length ------> 10
	concat(name, '-', id) as Concat, -> Join --------> Edgar Mora-1
	name||'-'||id as barcode ---------> Join --------> Edgar Mora-1
FROM
	users
```

### Create subColumns
```
SELECT
	SUBSTRING(name, 0, POSITION(' ' in name)) as firstName, ---> Split 'Edgar Mora' by space an return 'Edgar'
	SUBSTRING(name, POSITION(' ' in name) + 1) as lastName ---> Split 'Edgar Mora' by space an return 'Mora'
	TRIM(SUBSTRING(name, POSITION(' ' in name) + 1)) as trimmedLastName ---> Split 'Edgar Mora' by space an return 'Mora'
FROM
	users
```

### Update Rows with Other row values
```
UPDATE
	users
SET
	first_name = SUBSTRING(name, 0, POSITION(' ' IN name)),
	last_name = TRIM(SUBSTRING(name, POSITION(' ' IN name) + 1));
```

### Create table and insert
```
CREATE TABLE users (
    "id" varchar(36) NOT NULL DEFAULT gen_random_uuid(),
    "first_name" varchar(100) NOT NULL,
    "last_name" varchar(100) NOT NULL,
    "email" varchar(100) NOT NULL UNIQUE,
    "last_connection" varchar(100) NOT NULL,
    "country" varchar(100) NOT NULL,
    "website" varchar(100) NOT NULL,
    "username" varchar(100) NOT NULL UNIQUE,
    "followers" int4 NOT NULL,
    "following" int4 NOT NULL,
    PRIMARY KEY ("id")
);
insert into users
( first_name,last_name,email,last_connection,country,website,username, followers, following )
values
('Winnie','Peterson','winnie.peterson@bokegop.id','179.183.141.53','Falkland Islands','http://leni.ar/ma','brush99',108,17380),
```

### Between
```
SELECT
	first_name,
	last_connection,
	followers
FROM
	users
WHERE
	-- followers > 4600 AND followers < 4700
	followers BETWEEN 4600 and 4700
ORDER BY
	followers ASC
```
