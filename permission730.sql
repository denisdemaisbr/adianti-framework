--
-- adianti template, 7.3
-- sqlite3 dump -> mysql 5.7
--
-- revisao, 2021-09-04
--
-- breaks: 
-- - all models change 'max'  to 'serial'
-- - md5 to sha256
-- admin: 8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
--

SET FOREIGN_KEY_CHECKS=0;

BEGIN;

drop TABLE if exists system_group;
drop TABLE if exists system_program;
drop TABLE if exists system_unit;
drop TABLE if exists system_preference;
drop TABLE if exists system_user;
drop TABLE if exists system_user_unit;
drop TABLE if exists system_user_group;
drop TABLE if exists system_user_program;
drop table if exists system_group_program;

--
--
--

CREATE TABLE system_group (
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name varchar(128)
);

CREATE TABLE system_unit (
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name varchar(128),
    connection_name varchar(128)
);

-- CREATE TABLE system_preference (id text,value text);

CREATE TABLE system_program (
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name varchar(128),
    controller varchar(128)
);

CREATE TABLE system_user (
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name varchar(128),
    login varchar(128),
    password varchar(64),
	-- TODO: add salt
    email varchar(128),
    frontpage_id int,
	system_unit_id int references system_unit(id),
	-- TODO: change field type to tinyint ('Y'/'N' -> 1/0)
	active char(1),
    FOREIGN KEY(frontpage_id) REFERENCES system_program(id)
);

CREATE TABLE system_user_unit (
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    system_user_id int,
    system_unit_id int,
    FOREIGN KEY(system_user_id) REFERENCES system_user(id),
    FOREIGN KEY(system_unit_id) REFERENCES system_unit(id)
);

CREATE TABLE system_user_group (
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    system_user_id int,
    system_group_id int,
    FOREIGN KEY(system_user_id) REFERENCES system_user(id),
    FOREIGN KEY(system_group_id) REFERENCES system_group(id)
);


CREATE TABLE system_group_program (
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    system_group_id int,
    system_program_id int,
    FOREIGN KEY(system_group_id) REFERENCES system_group(id),
    FOREIGN KEY(system_program_id) REFERENCES system_program(id)
);


CREATE TABLE system_user_program (
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    system_user_id int,
    system_program_id int,
    FOREIGN KEY(system_user_id) REFERENCES system_user(id),
    FOREIGN KEY(system_program_id) REFERENCES system_program(id)
);

--
--
--

INSERT INTO system_group VALUES(1, 'Admin');

INSERT INTO system_group VALUES(2, '1-Empresa');
INSERT INTO system_group VALUES(3, '2-GERENTE');
INSERT INTO system_group VALUES(4, '3-SUPERVISOR');
INSERT INTO system_group VALUES(5, '4-VENDEDOR');

INSERT INTO system_program VALUES(1,'System Group Form','SystemGroupForm');
INSERT INTO system_program VALUES(2,'System Group List','SystemGroupList');
INSERT INTO system_program VALUES(3,'System Program Form','SystemProgramForm');
INSERT INTO system_program VALUES(4,'System Program List','SystemProgramList');
INSERT INTO system_program VALUES(5,'System User Form','SystemUserForm');
INSERT INTO system_program VALUES(6,'System User List','SystemUserList');
INSERT INTO system_program VALUES(7,'Common Page','CommonPage');
INSERT INTO system_program VALUES(8,'System PHP Info','SystemPHPInfoView');
INSERT INTO system_program VALUES(9,'System ChangeLog View','SystemChangeLogView');
INSERT INTO system_program VALUES(10,'Welcome View','WelcomeView');
INSERT INTO system_program VALUES(11,'System Sql Log','SystemSqlLogList');
INSERT INTO system_program VALUES(12,'System Profile View','SystemProfileView');
INSERT INTO system_program VALUES(13,'System Profile Form','SystemProfileForm');
INSERT INTO system_program VALUES(14,'System SQL Panel','SystemSQLPanel');
INSERT INTO system_program VALUES(15,'System Access Log','SystemAccessLogList');
INSERT INTO system_program VALUES(16,'System Message Form','SystemMessageForm');
INSERT INTO system_program VALUES(17,'System Message List','SystemMessageList');
INSERT INTO system_program VALUES(18,'System Message Form View','SystemMessageFormView');
INSERT INTO system_program VALUES(19,'System Notification List','SystemNotificationList');
INSERT INTO system_program VALUES(20,'System Notification Form View','SystemNotificationFormView');
INSERT INTO system_program VALUES(21,'System Document Category List','SystemDocumentCategoryFormList');
INSERT INTO system_program VALUES(22,'System Document Form','SystemDocumentForm');
INSERT INTO system_program VALUES(23,'System Document Upload Form','SystemDocumentUploadForm');
INSERT INTO system_program VALUES(24,'System Document List','SystemDocumentList');
INSERT INTO system_program VALUES(25,'System Shared Document List','SystemSharedDocumentList');
INSERT INTO system_program VALUES(26,'System Unit Form','SystemUnitForm');
INSERT INTO system_program VALUES(27,'System Unit List','SystemUnitList');
INSERT INTO system_program VALUES(28,'System Access stats','SystemAccessLogStats');
INSERT INTO system_program VALUES(29,'System Preference form','SystemPreferenceForm');
INSERT INTO system_program VALUES(30,'System Support form','SystemSupportForm');
INSERT INTO system_program VALUES(31,'System PHP Error','SystemPHPErrorLogView');
INSERT INTO system_program VALUES(32,'System Database Browser','SystemDatabaseExplorer');
INSERT INTO system_program VALUES(33,'System Table List','SystemTableList');
INSERT INTO system_program VALUES(34,'System Data Browser','SystemDataBrowser');
INSERT INTO system_program VALUES(35,'System Menu Editor','SystemMenuEditor');
INSERT INTO system_program VALUES(36,'System Request Log','SystemRequestLogList');
INSERT INTO system_program VALUES(37,'System Request Log View','SystemRequestLogView');
INSERT INTO system_program VALUES(38,'System Administration Dashboard','SystemAdministrationDashboard');
INSERT INTO system_program VALUES(39,'System Log Dashboard','SystemLogDashboard');
INSERT INTO system_program VALUES(40,'System Session dump','SystemSessionDumpView');


INSERT INTO system_unit VALUES(1,'Filial A','unit_a');
INSERT INTO system_unit VALUES(2,'Filial B','unit_b');

INSERT INTO system_user VALUES(1,'Administrator','admin','21232f297a57a5a743894a0e4a801fc3','admin@localhost',38,NULL,'Y');
INSERT INTO system_user VALUES(2,'Empresa','empresa','ee11cbb19052e40b07aac0ca060c23ee','empresa@localhost',38,NULL,'N');

INSERT INTO system_user_unit VALUES(1, 1, 1);
INSERT INTO system_user_unit VALUES(2, 1, 2);
INSERT INTO system_user_unit VALUES(3, 2, 1);
INSERT INTO system_user_unit VALUES(4, 2, 2);

INSERT INTO system_user_group VALUES(1, 1, 1);
INSERT INTO system_user_group VALUES(2, 2, 2);
INSERT INTO system_user_group VALUES(3, 1, 2);

INSERT INTO system_group_program VALUES(1,1,1);
INSERT INTO system_group_program VALUES(2,1,2);
INSERT INTO system_group_program VALUES(3,1,3);
INSERT INTO system_group_program VALUES(4,1,4);
INSERT INTO system_group_program VALUES(5,1,5);
INSERT INTO system_group_program VALUES(6,1,6);
INSERT INTO system_group_program VALUES(7,1,8);
INSERT INTO system_group_program VALUES(8,1,9);
INSERT INTO system_group_program VALUES(9,1,11);
INSERT INTO system_group_program VALUES(10,1,14);
INSERT INTO system_group_program VALUES(11,1,15);
INSERT INTO system_group_program VALUES(12,2,10);
INSERT INTO system_group_program VALUES(13,2,12);
INSERT INTO system_group_program VALUES(14,2,13);
INSERT INTO system_group_program VALUES(15,2,16);
INSERT INTO system_group_program VALUES(16,2,17);
INSERT INTO system_group_program VALUES(17,2,18);
INSERT INTO system_group_program VALUES(18,2,19);
INSERT INTO system_group_program VALUES(19,2,20);
INSERT INTO system_group_program VALUES(20,1,21);
INSERT INTO system_group_program VALUES(21,2,22);
INSERT INTO system_group_program VALUES(22,2,23);
INSERT INTO system_group_program VALUES(23,2,24);
INSERT INTO system_group_program VALUES(24,2,25);
INSERT INTO system_group_program VALUES(25,1,26);
INSERT INTO system_group_program VALUES(26,1,27);
INSERT INTO system_group_program VALUES(27,1,28);
INSERT INTO system_group_program VALUES(28,1,29);
INSERT INTO system_group_program VALUES(29,2,30);
INSERT INTO system_group_program VALUES(30,1,31);
INSERT INTO system_group_program VALUES(31,1,32);
INSERT INTO system_group_program VALUES(32,1,33);
INSERT INTO system_group_program VALUES(33,1,34);
INSERT INTO system_group_program VALUES(34,1,35);
INSERT INTO system_group_program VALUES(36,1,36);
INSERT INTO system_group_program VALUES(37,1,37);
INSERT INTO system_group_program VALUES(38,1,38);
INSERT INTO system_group_program VALUES(39,1,39);
INSERT INTO system_group_program VALUES(40,1,40);

CREATE INDEX sys_user_program_idx ON system_user(frontpage_id);
CREATE INDEX sys_user_group_group_idx ON system_user_group(system_group_id);
CREATE INDEX sys_user_group_user_idx ON system_user_group(system_user_id);
CREATE INDEX sys_group_program_program_idx ON system_group_program(system_program_id);
CREATE INDEX sys_group_program_group_idx ON system_group_program(system_group_id);
CREATE INDEX sys_user_program_program_idx ON system_user_program(system_program_id);
CREATE INDEX sys_user_program_user_idx ON system_user_program(system_user_id);

COMMIT;

SET FOREIGN_KEY_CHECKS=1;
