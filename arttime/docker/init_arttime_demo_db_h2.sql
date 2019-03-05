SET LOCK_MODE 3;              
;             
CREATE USER IF NOT EXISTS SA SALT '0b66a7af15454c99' HASH 'd821f7ebde42c80c56e44889b8cbde79f5b9db1aee1781fc67769eafd69d8fe9' ADMIN;           
DROP TABLE IF EXISTS PUBLIC."Day" CASCADE;    
DROP TABLE IF EXISTS PUBLIC.EMPLOYEE CASCADE; 
DROP TABLE IF EXISTS PUBLIC.EMPLOYEE_ACCESSIBLEDEPARTMENTS CASCADE;           
DROP TABLE IF EXISTS PUBLIC.FILTER CASCADE;   
DROP TABLE IF EXISTS PUBLIC.FILTER_DEPARTMENTS CASCADE;       
DROP TABLE IF EXISTS PUBLIC.FILTER_EMPLOYEE CASCADE;          
DROP TABLE IF EXISTS PUBLIC.FILTER_HOURTYPE CASCADE;          
DROP TABLE IF EXISTS PUBLIC.FILTER_PROJECT CASCADE;           
DROP TABLE IF EXISTS PUBLIC.HOURS CASCADE;    
DROP TABLE IF EXISTS PUBLIC.HOURTYPE CASCADE; 
DROP TABLE IF EXISTS PUBLIC.PROJECT CASCADE;  
DROP TABLE IF EXISTS PUBLIC.PROJECT_EMPLOYEE CASCADE;         
DROP TABLE IF EXISTS PUBLIC.PROJECT_HOURTYPE CASCADE;         
DROP TABLE IF EXISTS PUBLIC.PROJECT_MANAGER CASCADE;          
DROP TABLE IF EXISTS PUBLIC.SETTING CASCADE;  
DROP TABLE IF EXISTS PUBLIC.WORKDAYSCALENDAR CASCADE;         
DROP TABLE IF EXISTS PUBLIC.WORKDAYSCALENDAR_DEPARTMENTS CASCADE;             
CREATE SEQUENCE PUBLIC.SYSTEM_SEQUENCE_0119AB20_CB18_4562_934A_068F6028F744 START WITH 11 BELONGS_TO_TABLE;   
CREATE SEQUENCE PUBLIC.SYSTEM_SEQUENCE_1A7C91D8_D5A2_4BA8_9014_2A4CDD2D4596 START WITH 1 BELONGS_TO_TABLE;    
CREATE SEQUENCE PUBLIC.SYSTEM_SEQUENCE_9DDF394E_7C88_4D3F_A0C4_FD2388218CC1 START WITH 4 BELONGS_TO_TABLE;    
CREATE SEQUENCE PUBLIC.SYSTEM_SEQUENCE_3CCC99DC_A067_45FA_98CE_F83B19374ECA START WITH 1 BELONGS_TO_TABLE;    
CREATE SEQUENCE PUBLIC.SYSTEM_SEQUENCE_D81824E1_0B53_49DB_8DA9_3CF2167D3BF6 START WITH 1 BELONGS_TO_TABLE;    
CREATE SEQUENCE PUBLIC.SYSTEM_SEQUENCE_5A2EB34B_96AD_408C_A0B7_D0871C8ED195 START WITH 5 BELONGS_TO_TABLE;    
CREATE CACHED TABLE PUBLIC."Day"(
    ID BIGINT DEFAULT (NEXT VALUE FOR PUBLIC.SYSTEM_SEQUENCE_3CCC99DC_A067_45FA_98CE_F83B19374ECA) NOT NULL NULL_TO_DEFAULT SEQUENCE PUBLIC.SYSTEM_SEQUENCE_3CCC99DC_A067_45FA_98CE_F83B19374ECA,
    "comment" VARCHAR(255),
    "date" DATE NOT NULL,
    HOLIDAY BOOLEAN,
    SHIFTEDFROM DATE,
    SHIFTEDTO DATE,
    WORKING BOOLEAN,
    WORKDAYSCALENDAR_ID BIGINT
);      
ALTER TABLE PUBLIC."Day" ADD CONSTRAINT PUBLIC.CONSTRAINT_1 PRIMARY KEY(ID);  
-- 0 +/- SELECT COUNT(*) FROM PUBLIC."Day";   
CREATE CACHED TABLE PUBLIC.EMPLOYEE(
    USERNAME VARCHAR(255) NOT NULL,
    DEPARTMENT VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255) NOT NULL,
    FIRSTNAME VARCHAR(255) NOT NULL,
    FORMER BOOLEAN NOT NULL,
    LASTNAME VARCHAR(255) NOT NULL,
    WORKLOAD INTEGER NOT NULL,
    CALENDAR_ID BIGINT
);       
ALTER TABLE PUBLIC.EMPLOYEE ADD CONSTRAINT PUBLIC.CONSTRAINT_7 PRIMARY KEY(USERNAME);         
-- 10 +/- SELECT COUNT(*) FROM PUBLIC.EMPLOYEE;               
INSERT INTO PUBLIC.EMPLOYEE(USERNAME, DEPARTMENT, EMAIL, FIRSTNAME, FORMER, LASTNAME, WORKLOAD, CALENDAR_ID) VALUES
('employee2', 'Warsaw', 'employee2@example.com', 'Employee', FALSE, '2', 100, 3),
('employee1', 'Warsaw', 'employee1@example.com', 'Employee', FALSE, '1', 100, 3),
('exec', 'Prague', 'exec@email.com', 'Exec', FALSE, '1', 100, 1),
('employee4', 'Prague', 'employee4@example.com', 'Employee', FALSE, '4', 100, 1),
('officemanager2', 'Warsaw', 'om2@example.com', 'Office', FALSE, 'Manager 2', 100, 3),
('accountant', 'Prague', 'accountant@email.com', 'Accountant', FALSE, '1', 100, 1),
('projectmanager', 'Minsk', 'pm@email.com', 'Project', FALSE, 'Manager', 100, 2),
('employee3', 'Minsk', 'employee3@example.com', 'Employee', FALSE, '3', 100, 2),
('officemanager', 'Minsk', 'om@email.com', 'Office', FALSE, 'Manager', 100, 2),
('admin', 'Minsk', 'admin@email.com', 'Admin', FALSE, '1', 100, 2);       
CREATE CACHED TABLE PUBLIC.EMPLOYEE_ACCESSIBLEDEPARTMENTS(
    EMPLOYEE_USERNAME VARCHAR(255) NOT NULL,
    ACCESSIBLEDEPARTMENTS VARCHAR(255)
);          
-- 3 +/- SELECT COUNT(*) FROM PUBLIC.EMPLOYEE_ACCESSIBLEDEPARTMENTS;          
INSERT INTO PUBLIC.EMPLOYEE_ACCESSIBLEDEPARTMENTS(EMPLOYEE_USERNAME, ACCESSIBLEDEPARTMENTS) VALUES
('officemanager2', 'Minsk'),
('officemanager', 'Prague'),
('officemanager', 'Warsaw');  
CREATE CACHED TABLE PUBLIC.FILTER(
    ID BIGINT DEFAULT (NEXT VALUE FOR PUBLIC.SYSTEM_SEQUENCE_1A7C91D8_D5A2_4BA8_9014_2A4CDD2D4596) NOT NULL NULL_TO_DEFAULT SEQUENCE PUBLIC.SYSTEM_SEQUENCE_1A7C91D8_D5A2_4BA8_9014_2A4CDD2D4596,
    NAME VARCHAR(255),
    OWNER VARCHAR(255)
);     
ALTER TABLE PUBLIC.FILTER ADD CONSTRAINT PUBLIC.CONSTRAINT_7B PRIMARY KEY(ID);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.FILTER;  
CREATE CACHED TABLE PUBLIC.FILTER_DEPARTMENTS(
    FILTER_ID BIGINT NOT NULL,
    DEPARTMENTS VARCHAR(255)
);              
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.FILTER_DEPARTMENTS;      
CREATE CACHED TABLE PUBLIC.FILTER_EMPLOYEE(
    FILTER_ID BIGINT NOT NULL,
    EMPLOYEES_USERNAME VARCHAR(255) NOT NULL
); 
ALTER TABLE PUBLIC.FILTER_EMPLOYEE ADD CONSTRAINT PUBLIC.CONSTRAINT_2 PRIMARY KEY(FILTER_ID, EMPLOYEES_USERNAME);             
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.FILTER_EMPLOYEE;         
CREATE CACHED TABLE PUBLIC.FILTER_HOURTYPE(
    FILTER_ID BIGINT NOT NULL,
    HOURTYPES_ID BIGINT NOT NULL
);             
ALTER TABLE PUBLIC.FILTER_HOURTYPE ADD CONSTRAINT PUBLIC.CONSTRAINT_D PRIMARY KEY(FILTER_ID, HOURTYPES_ID);   
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.FILTER_HOURTYPE;         
CREATE CACHED TABLE PUBLIC.FILTER_PROJECT(
    FILTER_ID BIGINT NOT NULL,
    PROJECTS_ID BIGINT NOT NULL
);               
ALTER TABLE PUBLIC.FILTER_PROJECT ADD CONSTRAINT PUBLIC.CONSTRAINT_E PRIMARY KEY(FILTER_ID, PROJECTS_ID);     
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.FILTER_PROJECT;          
CREATE CACHED TABLE PUBLIC.HOURS(
    ID BIGINT DEFAULT (NEXT VALUE FOR PUBLIC.SYSTEM_SEQUENCE_D81824E1_0B53_49DB_8DA9_3CF2167D3BF6) NOT NULL NULL_TO_DEFAULT SEQUENCE PUBLIC.SYSTEM_SEQUENCE_D81824E1_0B53_49DB_8DA9_3CF2167D3BF6,
    APPROVED BOOLEAN NOT NULL,
    "comment" VARCHAR(255),
    "date" DATE NOT NULL,
    QUANTITY DECIMAL(19, 2) CHECK (QUANTITY >= 0),
    EMPLOYEE_USERNAME VARCHAR(255) NOT NULL,
    PROJECT_ID BIGINT NOT NULL,
    TYPE_ID BIGINT NOT NULL
);              
ALTER TABLE PUBLIC.HOURS ADD CONSTRAINT PUBLIC.CONSTRAINT_4 PRIMARY KEY(ID);  
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.HOURS;   
CREATE CACHED TABLE PUBLIC.HOURTYPE(
    ID BIGINT DEFAULT (NEXT VALUE FOR PUBLIC.SYSTEM_SEQUENCE_5A2EB34B_96AD_408C_A0B7_D0871C8ED195) NOT NULL NULL_TO_DEFAULT SEQUENCE PUBLIC.SYSTEM_SEQUENCE_5A2EB34B_96AD_408C_A0B7_D0871C8ED195,
    ACTUALTIME BOOLEAN NOT NULL,
    PRIORITY INTEGER NOT NULL,
    TYPE VARCHAR(255) NOT NULL
); 
ALTER TABLE PUBLIC.HOURTYPE ADD CONSTRAINT PUBLIC.CONSTRAINT_20 PRIMARY KEY(ID);              
-- 4 +/- SELECT COUNT(*) FROM PUBLIC.HOURTYPE;
INSERT INTO PUBLIC.HOURTYPE(ID, ACTUALTIME, PRIORITY, TYPE) VALUES
(1, TRUE, 5, 'Regular time'),
(2, FALSE, 0, 'Overtime'),
(3, FALSE, -2, 'Sick Leave'),
(4, FALSE, 1, 'Days Off');      
CREATE CACHED TABLE PUBLIC.PROJECT(
    ID BIGINT DEFAULT (NEXT VALUE FOR PUBLIC.SYSTEM_SEQUENCE_0119AB20_CB18_4562_934A_068F6028F744) NOT NULL NULL_TO_DEFAULT SEQUENCE PUBLIC.SYSTEM_SEQUENCE_0119AB20_CB18_4562_934A_068F6028F744,
    ALLOWEMPLOYEEREPORTTIME BOOLEAN NOT NULL,
    CODE VARCHAR(255) NOT NULL,
    DESCRIPTION VARCHAR(1000),
    MASTERIDOREMPTYSTRING VARCHAR(255) NOT NULL,
    STATUS VARCHAR(255) NOT NULL,
    FILTERTYPE VARCHAR(255),
    VALUE VARCHAR(255),
    MASTER_ID BIGINT
);  
ALTER TABLE PUBLIC.PROJECT ADD CONSTRAINT PUBLIC.CONSTRAINT_18 PRIMARY KEY(ID);               
-- 10 +/- SELECT COUNT(*) FROM PUBLIC.PROJECT;
INSERT INTO PUBLIC.PROJECT(ID, ALLOWEMPLOYEEREPORTTIME, CODE, DESCRIPTION, MASTERIDOREMPTYSTRING, STATUS, FILTERTYPE, VALUE, MASTER_ID) VALUES
(1, FALSE, 'Developement', NULL, '', 'ACTIVE', 'DISABLED', NULL, NULL),
(2, TRUE, 'Mobile Application', NULL, '1', 'ACTIVE', 'BASED_ON_MASTER', NULL, 1),
(3, TRUE, 'Web Site', NULL, '1', 'ACTIVE', 'BASED_ON_MASTER', NULL, 1),
(4, TRUE, 'Management', NULL, '', 'ACTIVE', 'DISABLED', NULL, NULL),
(5, TRUE, 'Support', NULL, '', 'ACTIVE', 'DISABLED', NULL, NULL),
(6, FALSE, 'Days Off', NULL, '', 'ACTIVE', 'DISABLED', NULL, NULL),
(7, FALSE, 'Days Off Minsk', NULL, '6', 'ACTIVE', 'DEPARTMENTS', 'Minsk', 6),
(8, FALSE, 'Days off Prague', NULL, '6', 'ACTIVE', 'DEPARTMENTS', 'Prague', 6),
(9, FALSE, 'Days off Warsaw', NULL, '6', 'ACTIVE', 'DEPARTMENTS', 'Warsaw', 6),
(10, TRUE, 'Accounting', NULL, '', 'ACTIVE', 'DISABLED', NULL, NULL);     
CREATE CACHED TABLE PUBLIC.PROJECT_EMPLOYEE(
    PROJECT_ID BIGINT NOT NULL,
    TEAM_USERNAME VARCHAR(255) NOT NULL
);    
ALTER TABLE PUBLIC.PROJECT_EMPLOYEE ADD CONSTRAINT PUBLIC.CONSTRAINT_9 PRIMARY KEY(PROJECT_ID, TEAM_USERNAME);
-- 22 +/- SELECT COUNT(*) FROM PUBLIC.PROJECT_EMPLOYEE;       
INSERT INTO PUBLIC.PROJECT_EMPLOYEE(PROJECT_ID, TEAM_USERNAME) VALUES
(2, 'employee2'),
(2, 'employee1'),
(2, 'employee3'),
(3, 'projectmanager'),
(3, 'employee4'),
(3, 'employee3'),
(4, 'officemanager2'),
(4, 'projectmanager'),
(4, 'officemanager'),
(4, 'exec'),
(5, 'admin'),
(10, 'accountant'),
(8, 'accountant'),
(8, 'employee4'),
(8, 'exec'),
(9, 'officemanager2'),
(9, 'employee2'),
(9, 'employee1'),
(7, 'admin'),
(7, 'projectmanager'),
(7, 'employee3'),
(7, 'officemanager');     
CREATE CACHED TABLE PUBLIC.PROJECT_HOURTYPE(
    PROJECT_ID BIGINT NOT NULL,
    ACCOUNTABLEHOURS_ID BIGINT NOT NULL
);    
ALTER TABLE PUBLIC.PROJECT_HOURTYPE ADD CONSTRAINT PUBLIC.CONSTRAINT_43 PRIMARY KEY(PROJECT_ID, ACCOUNTABLEHOURS_ID);         
-- 19 +/- SELECT COUNT(*) FROM PUBLIC.PROJECT_HOURTYPE;       
INSERT INTO PUBLIC.PROJECT_HOURTYPE(PROJECT_ID, ACCOUNTABLEHOURS_ID) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(5, 1),
(5, 2),
(6, 3),
(7, 3),
(7, 4),
(8, 3),
(8, 4),
(9, 3),
(9, 4),
(10, 1),
(10, 2);      
CREATE CACHED TABLE PUBLIC.PROJECT_MANAGER(
    PROJECT_ID BIGINT NOT NULL,
    MANAGER_USERNAME VARCHAR(255) NOT NULL
);  
ALTER TABLE PUBLIC.PROJECT_MANAGER ADD CONSTRAINT PUBLIC.CONSTRAINT_E1 PRIMARY KEY(PROJECT_ID, MANAGER_USERNAME);             
-- 10 +/- SELECT COUNT(*) FROM PUBLIC.PROJECT_MANAGER;        
INSERT INTO PUBLIC.PROJECT_MANAGER(PROJECT_ID, MANAGER_USERNAME) VALUES
(2, 'projectmanager'),
(1, 'exec'),
(3, 'projectmanager'),
(4, 'exec'),
(5, 'exec'),
(6, 'exec'),
(7, 'exec'),
(8, 'exec'),
(9, 'exec'),
(10, 'exec');      
CREATE CACHED TABLE PUBLIC.SETTING(
    "key" VARCHAR(255) NOT NULL,
    VALUE VARCHAR(255)
);             
ALTER TABLE PUBLIC.SETTING ADD CONSTRAINT PUBLIC.CONSTRAINT_A PRIMARY KEY("key");             
-- 20 +/- SELECT COUNT(*) FROM PUBLIC.SETTING;
INSERT INTO PUBLIC.SETTING("key", VALUE) VALUES
('EMPLOYEE_TRACKING_SYSTEM_NAME', 'Keycloak'),
('KEYCLOAK_SERVER_URL', 'http://127.0.0.1:9080/auth'),
('KEYCLOAK_REALM', 'master'),
('KEYCLOAK_USERNAME', 'admin'),
('KEYCLOAK_PASSWORD', 'password'),
('KEYCLOAK_CLIENT_ID', 'arttime-demo'),
('KEYCLOAK_CACHE_REFRESH_INTERVAL_MINUTES', '1'),
('TEAM_TRACKING_SYSTEM_NAME', 'Keycloak'),
('DEPARTMENT_TRACKING_SYSTEM_NAME', 'Keycloak'),
('KEYCLOAK_USER_DEPARTMENT_ATTRIBUTE', 'department'),
('TIMER_HOURS_INTERVAL', '1'),
('EMPLOYEE_SYNCHRONIZATION_ENABLED', 'true'),
('TEAM_SYNCHRONIZATION_ENABLED', 'true'),
('SMTP_PORT_NUMBER', NULL),
('SMTP_USERNAME', 'admin'),
('SMTP_PASSWORD', 'admin'),
('SMTP_SENDER', NULL),
('SMTP_HOST_NAME', NULL),
('APPLICATION_BASE_URL', 'http://localhost:8080/arttime'),
('HELP_PAGE_URL', 'https://github.com/Artezio/ART-TIME');       
CREATE CACHED TABLE PUBLIC.WORKDAYSCALENDAR(
    ID BIGINT DEFAULT (NEXT VALUE FOR PUBLIC.SYSTEM_SEQUENCE_9DDF394E_7C88_4D3F_A0C4_FD2388218CC1) NOT NULL NULL_TO_DEFAULT SEQUENCE PUBLIC.SYSTEM_SEQUENCE_9DDF394E_7C88_4D3F_A0C4_FD2388218CC1,
    NAME VARCHAR(255) NOT NULL
);           
ALTER TABLE PUBLIC.WORKDAYSCALENDAR ADD CONSTRAINT PUBLIC.CONSTRAINT_99 PRIMARY KEY(ID);      
-- 3 +/- SELECT COUNT(*) FROM PUBLIC.WORKDAYSCALENDAR;        
INSERT INTO PUBLIC.WORKDAYSCALENDAR(ID, NAME) VALUES
(1, 'Czech'),
(2, 'Russia'),
(3, 'Poland');           
CREATE CACHED TABLE PUBLIC.WORKDAYSCALENDAR_DEPARTMENTS(
    WORKDAYSCALENDAR_ID BIGINT NOT NULL,
    DEPARTMENTS VARCHAR(255)
);          
-- 3 +/- SELECT COUNT(*) FROM PUBLIC.WORKDAYSCALENDAR_DEPARTMENTS;            
INSERT INTO PUBLIC.WORKDAYSCALENDAR_DEPARTMENTS(WORKDAYSCALENDAR_ID, DEPARTMENTS) VALUES
(2, 'Minsk'),
(1, 'Prague'),
(3, 'Warsaw');       
ALTER TABLE PUBLIC.HOURTYPE ADD CONSTRAINT PUBLIC.CONSTRAINT_UNIQUE_HOURTYPE_NAME UNIQUE(TYPE);               
ALTER TABLE PUBLIC.HOURS ADD CONSTRAINT PUBLIC.CONSTRAINT_UNIQUE_HOURS UNIQUE("date", EMPLOYEE_USERNAME, PROJECT_ID, TYPE_ID);
ALTER TABLE PUBLIC.FILTER ADD CONSTRAINT PUBLIC.UNIQUE_FILTER_NAME_FOR_OWNER UNIQUE(OWNER, NAME);             
ALTER TABLE PUBLIC.PROJECT ADD CONSTRAINT PUBLIC.UNIQUEPROJECTCODES UNIQUE(MASTERIDOREMPTYSTRING, CODE);      
ALTER TABLE PUBLIC.WORKDAYSCALENDAR ADD CONSTRAINT PUBLIC.CONSTRAINT_UNIQUE_CALENDAR_NAME UNIQUE(NAME);       
ALTER TABLE PUBLIC.FILTER_PROJECT ADD CONSTRAINT PUBLIC.FKGQM4SAKR2HMTXXNMWEX0SD9QB FOREIGN KEY(PROJECTS_ID) REFERENCES PUBLIC.PROJECT(ID) NOCHECK;           
ALTER TABLE PUBLIC.PROJECT_MANAGER ADD CONSTRAINT PUBLIC.FKBA30FVDEG7LENK7GLU04BX2DD FOREIGN KEY(MANAGER_USERNAME) REFERENCES PUBLIC.EMPLOYEE(USERNAME) NOCHECK;              
ALTER TABLE PUBLIC.FILTER_DEPARTMENTS ADD CONSTRAINT PUBLIC.FK6E6V9LUQMQ6TAM4IPX9SUB943 FOREIGN KEY(FILTER_ID) REFERENCES PUBLIC.FILTER(ID) NOCHECK;          
ALTER TABLE PUBLIC.FILTER_EMPLOYEE ADD CONSTRAINT PUBLIC.FK8VYDPTFD49BWJCJEH6SBI3RP4 FOREIGN KEY(FILTER_ID) REFERENCES PUBLIC.FILTER(ID) NOCHECK;             
ALTER TABLE PUBLIC.EMPLOYEE ADD CONSTRAINT PUBLIC.FKEDR7CIYE67QMIKJ8AU8CW3XUM FOREIGN KEY(CALENDAR_ID) REFERENCES PUBLIC.WORKDAYSCALENDAR(ID) NOCHECK;        
ALTER TABLE PUBLIC.PROJECT_HOURTYPE ADD CONSTRAINT PUBLIC.FKNMA6Y1H1C6EENO8GCGOT6UPAE FOREIGN KEY(PROJECT_ID) REFERENCES PUBLIC.PROJECT(ID) NOCHECK;          
ALTER TABLE PUBLIC.PROJECT_EMPLOYEE ADD CONSTRAINT PUBLIC.FK1VJ0WW7SOBVI366TM79DB478Y FOREIGN KEY(PROJECT_ID) REFERENCES PUBLIC.PROJECT(ID) NOCHECK;          
ALTER TABLE PUBLIC.PROJECT_HOURTYPE ADD CONSTRAINT PUBLIC.FKPK1QOM13DVGEPH318EFIY1D7C FOREIGN KEY(ACCOUNTABLEHOURS_ID) REFERENCES PUBLIC.HOURTYPE(ID) NOCHECK;
ALTER TABLE PUBLIC.PROJECT_EMPLOYEE ADD CONSTRAINT PUBLIC.FKBBSYR0AP9HGE71KHW6SV0BXDM FOREIGN KEY(TEAM_USERNAME) REFERENCES PUBLIC.EMPLOYEE(USERNAME) NOCHECK;
ALTER TABLE PUBLIC.FILTER_PROJECT ADD CONSTRAINT PUBLIC.FKQDJ18S1U6EG5G606VGT4YBOD2 FOREIGN KEY(FILTER_ID) REFERENCES PUBLIC.FILTER(ID) NOCHECK;              
ALTER TABLE PUBLIC."Day" ADD CONSTRAINT PUBLIC.FKGWXD43TWH8VY3CXB7OXD5QVI8 FOREIGN KEY(WORKDAYSCALENDAR_ID) REFERENCES PUBLIC.WORKDAYSCALENDAR(ID) NOCHECK;   
ALTER TABLE PUBLIC.PROJECT_MANAGER ADD CONSTRAINT PUBLIC.FKMH7DXMFK88JC2VNCJI4RI7JIV FOREIGN KEY(PROJECT_ID) REFERENCES PUBLIC.PROJECT(ID) NOCHECK;           
ALTER TABLE PUBLIC.HOURS ADD CONSTRAINT PUBLIC.FK25EG3TKQBS2CPTN7F74AMIVDV FOREIGN KEY(EMPLOYEE_USERNAME) REFERENCES PUBLIC.EMPLOYEE(USERNAME) NOCHECK;       
ALTER TABLE PUBLIC.FILTER_HOURTYPE ADD CONSTRAINT PUBLIC.FK31SSWKBA5Q453YK3PIL7TFLDS FOREIGN KEY(FILTER_ID) REFERENCES PUBLIC.FILTER(ID) NOCHECK;             
ALTER TABLE PUBLIC.PROJECT ADD CONSTRAINT PUBLIC.FKM6V85X353B3GRWAG6561Y8P31 FOREIGN KEY(MASTER_ID) REFERENCES PUBLIC.PROJECT(ID) NOCHECK;    
ALTER TABLE PUBLIC.FILTER_EMPLOYEE ADD CONSTRAINT PUBLIC.FK95LXD5JRR38OMUF61HME8U2VF FOREIGN KEY(EMPLOYEES_USERNAME) REFERENCES PUBLIC.EMPLOYEE(USERNAME) NOCHECK;            
ALTER TABLE PUBLIC.EMPLOYEE_ACCESSIBLEDEPARTMENTS ADD CONSTRAINT PUBLIC.FKHPMKJKIK9QBQRJ965XD66MJ5T FOREIGN KEY(EMPLOYEE_USERNAME) REFERENCES PUBLIC.EMPLOYEE(USERNAME) NOCHECK;              
ALTER TABLE PUBLIC.WORKDAYSCALENDAR_DEPARTMENTS ADD CONSTRAINT PUBLIC.FKP6UDUYVP0J8VIEXNCNP0811HR FOREIGN KEY(WORKDAYSCALENDAR_ID) REFERENCES PUBLIC.WORKDAYSCALENDAR(ID) NOCHECK;            
ALTER TABLE PUBLIC.HOURS ADD CONSTRAINT PUBLIC.FKF09X1Q446IVUTB73UTI65RWYM FOREIGN KEY(PROJECT_ID) REFERENCES PUBLIC.PROJECT(ID) NOCHECK;     
ALTER TABLE PUBLIC.FILTER_HOURTYPE ADD CONSTRAINT PUBLIC.FKIQXTWUKI6L2DL6EDATYUBPLCV FOREIGN KEY(HOURTYPES_ID) REFERENCES PUBLIC.HOURTYPE(ID) NOCHECK;        
ALTER TABLE PUBLIC.HOURS ADD CONSTRAINT PUBLIC.FKB6RH8NI4E9GKWU6XFJ97WWCNE FOREIGN KEY(TYPE_ID) REFERENCES PUBLIC.HOURTYPE(ID) NOCHECK;       
