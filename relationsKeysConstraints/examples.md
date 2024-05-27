### Primary Key
```
ALTER TABLE country
	ADD PRIMARY KEY (code);
```

### Check Values
```
ALTER TABLE country
	ADD CHECK (surfacearea >= 0);
```

### Check with multiply valid values
```
ALTER TABLE country
	ADD CHECK ((continent = 'Asia')
			or(continent = 'South America')
				or(continent = 'North America')
					or(continent = 'Oceania')
						or(continent = 'Antarctica')
							or(continent = 'Africa')
								or(continent = 'Europe'));
```

### Create Table with Constraints
```
CREATE TABLE "public"."country" (
	"code" bpchar NOT NULL,
	"name" text NOT NULL,
	"continent" text NOT NULL CHECK ((continent = 'Asia'::text)
		OR(continent = 'South America'::text)
		OR(continent = 'North America'::text)
		OR(continent = 'Oceania'::text)
		OR(continent = 'Antarctica'::text)
		OR(continent = 'Africa'::text)
		OR(continent = 'Europe'::text)
		OR(continent = 'Central America'::text)),
	"region" text NOT NULL,
	"surfacearea" float4 NOT NULL CHECK (surfacearea >= (0)::double precision),
	"indepyear" int2,
	"population" int4 NOT NULL,
	"lifeexpectancy" float4,
	"gnp" numeric,
	"gnpold" numeric,
	"localname" text NOT NULL,
	"governmentform" text NOT NULL,
	"headofstate" text,
	"capital" int4,
	"code2" bpchar NOT NULL,
	PRIMARY KEY ("code")
);
```

### Create Unique Index
```
CREATE UNIQUE INDEX "unique_country_name" ON country (name);
```

### Create Index
```
CREATE INDEX "country_continent" ON country (continent);
```

### Foreign Key
```
ALTER TABLE city
	ADD CONSTRAINT fk_country_code FOREIGN KEY (countrycode) REFERENCES country (code);
```

### Remove Constraint
```
ALTER TABLE country DROP CONSTRAINT country_continent_check
```
