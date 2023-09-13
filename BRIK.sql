/*
 Navicat Premium Data Transfer

 Source Server         : POSTGRES LOCAL
 Source Server Type    : PostgreSQL
 Source Server Version : 150000 (150000)
 Source Host           : localhost:5433
 Source Catalog        : brik
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 150000 (150000)
 File Encoding         : 65001

 Date: 14/09/2023 02:14:35
*/


-- ----------------------------
-- Sequence structure for category_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."category_id_seq";
CREATE SEQUENCE "public"."category_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for migrations_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."migrations_id_seq";
CREATE SEQUENCE "public"."migrations_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for personal_access_tokens_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."personal_access_tokens_id_seq";
CREATE SEQUENCE "public"."personal_access_tokens_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for products_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."products_id_seq";
CREATE SEQUENCE "public"."products_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for roles_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."roles_id_seq";
CREATE SEQUENCE "public"."roles_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_id_seq";
CREATE SEQUENCE "public"."users_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS "public"."category";
CREATE TABLE "public"."category" (
  "id" int8 NOT NULL DEFAULT nextval('category_id_seq'::regclass),
  "nama" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO "public"."category" VALUES (1, 'Cemilan', '2023-09-13 22:23:16', '2023-09-13 22:23:16');
INSERT INTO "public"."category" VALUES (2, 'Bumbu Dapur', '2023-09-13 22:23:16', '2023-09-13 22:23:16');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS "public"."migrations";
CREATE TABLE "public"."migrations" (
  "id" int4 NOT NULL DEFAULT nextval('migrations_id_seq'::regclass),
  "migration" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "batch" int4 NOT NULL
)
;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO "public"."migrations" VALUES (16, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO "public"."migrations" VALUES (17, '2023_09_12_203600_create_roles_table', 1);
INSERT INTO "public"."migrations" VALUES (18, '2023_09_12_223600_create_users_table', 1);
INSERT INTO "public"."migrations" VALUES (19, '2023_09_12_233321_create_category_table', 1);
INSERT INTO "public"."migrations" VALUES (20, '2023_09_12_262800_create_products_table', 1);

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS "public"."personal_access_tokens";
CREATE TABLE "public"."personal_access_tokens" (
  "id" int8 NOT NULL DEFAULT nextval('personal_access_tokens_id_seq'::regclass),
  "tokenable_type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "tokenable_id" int8 NOT NULL,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "token" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "abilities" text COLLATE "pg_catalog"."default",
  "last_used_at" timestamp(0),
  "expires_at" timestamp(0),
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS "public"."products";
CREATE TABLE "public"."products" (
  "id" int8 NOT NULL DEFAULT nextval('products_id_seq'::regclass),
  "userId" int8 NOT NULL,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "sku" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "CategoryId" int8 NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "price" float8 NOT NULL,
  "weight" int4 NOT NULL,
  "width" int4 NOT NULL,
  "length" int4 NOT NULL,
  "height" int4 NOT NULL,
  "image" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO "public"."products" VALUES (1, 1, 'Ciki Ciki', 'RYAVCE', 1, 'Ciki ciki yang super enak, hanya di toko klontong kami', 50000, 500, 5, 5, 5, 'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b', '2023-09-13 22:23:17', '2023-09-13 22:23:17');
INSERT INTO "public"."products" VALUES (3, 1, 'Terasi ABC', 'QCYAXC', 2, 'Terasi dengan bahan teri pilihan dan terbaik se-Indonesia', 30000, 500, 5, 5, 5, 'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b', '2023-09-14 01:35:28', '2023-09-14 01:35:28');
INSERT INTO "public"."products" VALUES (4, 1, 'Mentega Blue Band', 'IVVLCA', 2, 'Mentega yang dapat diminum', 30000, 500, 5, 5, 5, 'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b', '2023-09-14 01:39:10', '2023-09-14 01:39:10');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS "public"."roles";
CREATE TABLE "public"."roles" (
  "id" int8 NOT NULL DEFAULT nextval('roles_id_seq'::regclass),
  "nama" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO "public"."roles" VALUES (1, 'Administrator', '2023-09-13 22:23:16', '2023-09-13 22:23:16');
INSERT INTO "public"."roles" VALUES (2, 'Customer', '2023-09-13 22:23:16', '2023-09-13 22:23:16');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
  "id" int8 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
  "firstName" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "lastName" varchar(255) COLLATE "pg_catalog"."default",
  "phoneNum" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "roleId" int8 NOT NULL,
  "email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO "public"."users" VALUES (1, 'Administrator', NULL, '081182019089', 1, 'admin@gmail.com', '$2y$10$HLhC7NaWxD9hjRoardjI/.rx61ObXnfeJ4Yd4KXvNbclH8aj.Ba1y', '2023-09-13 22:23:16', '2023-09-13 22:23:16');
INSERT INTO "public"."users" VALUES (2, 'Daniel', 'Eka Putra', '081283927810', 2, 'danetra05@gmail.com', '$2y$10$R/YvN27cJrPviZvgTAG86.hJZzhfSeFZ8CrZ239CtN5uKpohbPm0K', '2023-09-13 22:23:17', '2023-09-13 22:23:17');
INSERT INTO "public"."users" VALUES (3, 'Alex', 'Al Munjabi', '081287987023', 2, 'alex@gmail.com', '$2a$10$qaXMJvDCVl9hfM2jLTndJ.SlIC3vtAeYEt9m1EjFdQSa7/ZpRauou', '2023-09-13 22:41:11', '2023-09-13 22:41:11');

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."category_id_seq"
OWNED BY "public"."category"."id";
SELECT setval('"public"."category_id_seq"', 2, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."migrations_id_seq"
OWNED BY "public"."migrations"."id";
SELECT setval('"public"."migrations_id_seq"', 20, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."personal_access_tokens_id_seq"
OWNED BY "public"."personal_access_tokens"."id";
SELECT setval('"public"."personal_access_tokens_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."products_id_seq"
OWNED BY "public"."products"."id";
SELECT setval('"public"."products_id_seq"', 4, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."roles_id_seq"
OWNED BY "public"."roles"."id";
SELECT setval('"public"."roles_id_seq"', 2, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."users_id_seq"
OWNED BY "public"."users"."id";
SELECT setval('"public"."users_id_seq"', 3, true);

-- ----------------------------
-- Uniques structure for table category
-- ----------------------------
ALTER TABLE "public"."category" ADD CONSTRAINT "category_nama_unique" UNIQUE ("nama");

-- ----------------------------
-- Primary Key structure for table category
-- ----------------------------
ALTER TABLE "public"."category" ADD CONSTRAINT "category_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table migrations
-- ----------------------------
ALTER TABLE "public"."migrations" ADD CONSTRAINT "migrations_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table personal_access_tokens
-- ----------------------------
CREATE INDEX "personal_access_tokens_tokenable_type_tokenable_id_index" ON "public"."personal_access_tokens" USING btree (
  "tokenable_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "tokenable_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table personal_access_tokens
-- ----------------------------
ALTER TABLE "public"."personal_access_tokens" ADD CONSTRAINT "personal_access_tokens_token_unique" UNIQUE ("token");

-- ----------------------------
-- Primary Key structure for table personal_access_tokens
-- ----------------------------
ALTER TABLE "public"."personal_access_tokens" ADD CONSTRAINT "personal_access_tokens_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table products
-- ----------------------------
ALTER TABLE "public"."products" ADD CONSTRAINT "products_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table roles
-- ----------------------------
ALTER TABLE "public"."roles" ADD CONSTRAINT "roles_nama_unique" UNIQUE ("nama");

-- ----------------------------
-- Primary Key structure for table roles
-- ----------------------------
ALTER TABLE "public"."roles" ADD CONSTRAINT "roles_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_email_unique" UNIQUE ("email");

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table products
-- ----------------------------
ALTER TABLE "public"."products" ADD CONSTRAINT "products_categoryid_foreign" FOREIGN KEY ("CategoryId") REFERENCES "public"."category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."products" ADD CONSTRAINT "products_userid_foreign" FOREIGN KEY ("userId") REFERENCES "public"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_roleid_foreign" FOREIGN KEY ("roleId") REFERENCES "public"."roles" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
