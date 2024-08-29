BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "service_billinfo" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"month_frm"	date NOT NULL,
	"month_to"	date NOT NULL,
	"meter_id"	integer NOT NULL,
	"prev_read"	integer NOT NULL,
	"new_read"	integer NOT NULL,
	"units"	integer NOT NULL,
	"amount"	integer NOT NULL,
	"status"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "service_paymentrecords" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"date"	date NOT NULL,
	"time"	time NOT NULL,
	"refid"	varchar(12) NOT NULL,
	"remark"	integer NOT NULL,
	"amount"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "service_service" (
	"id"	integer NOT NULL,
	"service_icons"	varchar(50) NOT NULL,
	"service_title"	varchar(50) NOT NULL,
	"service_des"	text NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_service','Can add service');
INSERT INTO "auth_permission" VALUES (26,7,'change_service','Can change service');
INSERT INTO "auth_permission" VALUES (27,7,'delete_service','Can delete service');
INSERT INTO "auth_permission" VALUES (28,7,'view_service','Can view service');
INSERT INTO "auth_permission" VALUES (29,9,'add_billinfo','Can add billinfo');
INSERT INTO "auth_permission" VALUES (30,9,'change_billinfo','Can change billinfo');
INSERT INTO "auth_permission" VALUES (31,9,'delete_billinfo','Can delete billinfo');
INSERT INTO "auth_permission" VALUES (32,9,'view_billinfo','Can view billinfo');
INSERT INTO "auth_permission" VALUES (33,8,'add_paymentrecords','Can add paymentrecords');
INSERT INTO "auth_permission" VALUES (34,8,'change_paymentrecords','Can change paymentrecords');
INSERT INTO "auth_permission" VALUES (35,8,'delete_paymentrecords','Can delete paymentrecords');
INSERT INTO "auth_permission" VALUES (36,8,'view_paymentrecords','Can view paymentrecords');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$720000$oOPa7w1wKKBzEsP8tZeMRF$wR6kBe2Xg3UtOpYbmI/ky0XbwQou/QpPVsdvPwtQUYw=','2024-07-25 05:44:05.250814',1,'admin','','testing@gmail.com',1,1,'2024-07-25 05:40:41.747531','');
INSERT INTO "django_admin_log" VALUES (1,'1','Service object (1)',1,'[{"added": {}}]',7,1,'2024-07-30 07:05:09.748540');
INSERT INTO "django_admin_log" VALUES (2,'1','paymentrecords object (1)',1,'[{"added": {}}]',8,1,'2024-07-31 13:22:44.546801');
INSERT INTO "django_admin_log" VALUES (3,'1','billinfo object (1)',1,'[{"added": {}}]',9,1,'2024-07-31 13:24:13.809225');
INSERT INTO "django_admin_log" VALUES (4,'2','paymentrecords object (2)',1,'[{"added": {}}]',8,1,'2024-08-01 05:56:50.856508');
INSERT INTO "django_admin_log" VALUES (5,'3','paymentrecords object (3)',1,'[{"added": {}}]',8,1,'2024-08-01 05:57:25.764172');
INSERT INTO "django_admin_log" VALUES (6,'2','billinfo object (2)',1,'[{"added": {}}]',9,1,'2024-08-01 05:58:06.952007');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'service','service');
INSERT INTO "django_content_type" VALUES (8,'service','paymentrecords');
INSERT INTO "django_content_type" VALUES (9,'service','billinfo');
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2024-07-24 05:33:47.017644');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2024-07-24 05:33:47.043075');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2024-07-24 05:33:47.059546');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2024-07-24 05:33:47.078641');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2024-07-24 05:33:47.087381');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2024-07-24 05:33:47.111373');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2024-07-24 05:33:47.116129');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2024-07-24 05:33:47.134842');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2024-07-24 05:33:47.150108');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2024-07-24 05:33:47.164390');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2024-07-24 05:33:47.164757');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2024-07-24 05:33:47.178609');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2024-07-24 05:33:47.187381');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2024-07-24 05:33:47.206069');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2024-07-24 05:33:47.222408');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2024-07-24 05:33:47.234127');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2024-07-24 05:33:47.248052');
INSERT INTO "django_migrations" VALUES (18,'sessions','0001_initial','2024-07-24 05:33:47.253839');
INSERT INTO "django_migrations" VALUES (19,'service','0001_initial','2024-07-30 06:42:53.374294');
INSERT INTO "django_migrations" VALUES (20,'service','0002_service_delete_faq','2024-07-30 06:42:53.388063');
INSERT INTO "django_migrations" VALUES (21,'service','0002_rename_service_ion_service_service_icon','2024-07-31 13:20:22.615860');
INSERT INTO "django_migrations" VALUES (22,'service','0003_billinfo_paymentrecords','2024-07-31 13:20:22.625443');
INSERT INTO "django_migrations" VALUES (23,'service','0004_rename_service_icon_service_service_icons','2024-07-31 13:20:22.635529');
INSERT INTO "django_session" VALUES ('4nilx5ltnyvlqzxjw9ekabbdqzbfsjo2','.eJxVjDsOwjAQBe_iGlnrdZxdU9LnDJZ_4ACypTipEHeHSCmgfTPzXsL5bS1u63lxcxJnocTpdws-PnLdQbr7emsytrouc5C7Ig_a5dRSfl4O9--g-F6-dTbMg-HIpAdUQApGA5RjsqzjaA2TUnhFDQia0KQMETAAkjU2BE7i_QGT4DX2:1sWrGn:RuxFAkpj8442hPcLz9BTQQGjInQ9rOtjZXeIXADYCAE','2024-08-08 05:44:05.265752');
INSERT INTO "service_billinfo" VALUES (1,1,'2024-03-14','2024-07-31',12,34,35,1,500,1);
INSERT INTO "service_billinfo" VALUES (2,6,'2024-07-01','2024-08-01',5,89,100,11,700,0);
INSERT INTO "service_paymentrecords" VALUES (1,1,'2024-07-31','13:22:32','123456789012',1,200);
INSERT INTO "service_paymentrecords" VALUES (2,5,'2024-08-01','05:56:25','234567890123',0,800);
INSERT INTO "service_paymentrecords" VALUES (3,2,'2024-08-01','05:57:04','456789012345',0,190);
INSERT INTO "service_service" VALUES (1,'demo','demo','IIP');
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
COMMIT;
