CREATE TABLE "users" (
  "user_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "username" varchar UNIQUE NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "name" varchar NOT NULL,
  "role" varchar NOT NULL,
  "gender" varchar(10) NOT NULL,
  "avatar" varchar,
  "created_at" timestamp DEFAULT 'now()'
);

CREATE TABLE "posts" (
  "post_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "title" varchar(200) DEFAULT '',
  "body" text DEFAULT '',
  "og_image" varchar,
  "slug" varchar UNIQUE NOT NULL,
  "published" boolean,
  "created_by" integer
);

CREATE TABLE "claps" (
  "clap_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "post_id" integer,
  "user_id" integer,
  "counter" integer DEFAULT 0,
  "created_at" timestamp
);

CREATE TABLE "comments" (
  "comment_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "post_id" integer,
  "user_id" integer,
  "content" text,
  "comment_parent_id" integer,
  "created_at" timestamp,
  "visible" boolean
);

CREATE TABLE "user_lists" (
  "user_list_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "user_id" integer,
  "title" varchar(100)
);

CREATE TABLE "user_list_entry" (
  "user_list_entry" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "user_list_id" integer,
  "post_id" integer
);

CREATE UNIQUE INDEX ON "claps" ("post_id", "user_id");

CREATE INDEX ON "claps" ("post_id");

CREATE INDEX ON "comments" ("post_id");

CREATE INDEX ON "comments" ("visible");

CREATE UNIQUE INDEX ON "user_lists" ("user_id", "title");

CREATE INDEX ON "user_lists" ("user_id");

ALTER TABLE "comments" ADD FOREIGN KEY ("comment_parent_id") REFERENCES "comments" ("comment_id");

ALTER TABLE "claps" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "comments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "posts" ADD FOREIGN KEY ("created_by") REFERENCES "users" ("user_id");

ALTER TABLE "user_lists" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "user_list_entry" ADD FOREIGN KEY ("user_list_id") REFERENCES "user_lists" ("user_list_id");

ALTER TABLE "claps" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("post_id");

ALTER TABLE "comments" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("post_id");

ALTER TABLE "user_list_entry" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("post_id");
