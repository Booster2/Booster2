drop database if exists TypeTest;
create database TypeTest;
 use TypeTest;
drop table if exists _Meta_Classes;
create table _Meta_Classes (id int   auto_increment primary key );
drop table if exists _Meta_Attributes;
create table _Meta_Attributes (id int   auto_increment primary key );
drop table if exists _Meta_Methods;
create table _Meta_Methods (id int   auto_increment primary key );
drop table if exists _Meta_Method_Params;
create table _Meta_Method_Params (id int   auto_increment primary key );
drop table if exists DaysOfWeek;
create table DaysOfWeek (DaysOfWeek varchar(100)  default "unassigned"  primary key );
drop table if exists mainClass;
create table mainClass (mainClassId int   auto_increment primary key );
drop table if exists secondaryClass;
create table secondaryClass (secondaryClassId int   auto_increment primary key );
drop table if exists mainClass_att5_secondaryClass_attA;
create table mainClass_att5_secondaryClass_attA (mainClass_att5_secondaryClass_attAId int   auto_increment primary key );
drop table if exists mainClass_att6_secondaryClass_attB;
create table mainClass_att6_secondaryClass_attB (mainClass_att6_secondaryClass_attBId int   auto_increment primary key );
drop table if exists mainClass_att7_secondaryClass_attC;
create table mainClass_att7_secondaryClass_attC (mainClass_att7_secondaryClass_attCId int   auto_increment primary key );
drop table if exists mainClass_att12_secondaryClass_attD;
create table mainClass_att12_secondaryClass_attD (mainClass_att12_secondaryClass_attDId int   auto_increment primary key );
drop table if exists mainClass_att13_secondaryClass_attE;
create table mainClass_att13_secondaryClass_attE (mainClass_att13_secondaryClass_attEId int   auto_increment primary key );
drop table if exists mainClass_att14_secondaryClass_attF;
create table mainClass_att14_secondaryClass_attF (mainClass_att14_secondaryClass_attFId int   auto_increment primary key );
drop table if exists mainClass_att15;
create table mainClass_att15 (mainClass_att15Id int   auto_increment primary key );
drop table if exists mainClass_att16;
create table mainClass_att16 (mainClass_att16Id int   auto_increment primary key );
drop table if exists mainClass_att17;
create table mainClass_att17 (mainClass_att17Id int   auto_increment primary key );
drop table if exists mainClass_att18;
create table mainClass_att18 (mainClass_att18Id int   auto_increment primary key );
drop table if exists mainClass_att19_secondaryClass_attG;
create table mainClass_att19_secondaryClass_attG (mainClass_att19_secondaryClass_attGId int   auto_increment primary key );
drop table if exists mainClass_att20_secondaryClass_attH;
create table mainClass_att20_secondaryClass_attH (mainClass_att20_secondaryClass_attHId int   auto_increment primary key );
drop table if exists mainClass_att21_secondaryClass_attI;
create table mainClass_att21_secondaryClass_attI (mainClass_att21_secondaryClass_attIId int   auto_increment primary key );

alter table mainClass_att21_secondaryClass_attI
	add column mainClass_att21 int     , add foreign key (mainClass_att21) references mainClass ( mainClassId);
alter table mainClass_att21_secondaryClass_attI
	add column secondaryClass_attI int     , add foreign key (secondaryClass_attI) references secondaryClass ( secondaryClassId);

alter table mainClass_att20_secondaryClass_attH
	add column mainClass_att20 int     , add foreign key (mainClass_att20) references mainClass ( mainClassId);
alter table mainClass_att20_secondaryClass_attH
	add column secondaryClass_attH int     , add foreign key (secondaryClass_attH) references secondaryClass ( secondaryClassId);

alter table mainClass_att19_secondaryClass_attG
	add column mainClass_att19 int     , add foreign key (mainClass_att19) references mainClass ( mainClassId);
alter table mainClass_att19_secondaryClass_attG
	add column secondaryClass_attG int     , add foreign key (secondaryClass_attG) references secondaryClass ( secondaryClassId);

alter table mainClass_att18
	add column mainClassId int     , add foreign key (mainClassId) references mainClass ( mainClassId);
alter table mainClass_att18
	add column att18 int     , add foreign key (att18) references secondaryClass ( secondaryClassId);

alter table mainClass_att17
	add column mainClassId int     , add foreign key (mainClassId) references mainClass ( mainClassId);
alter table mainClass_att17
	add column att17 varchar(500)     , add foreign key (att17) references DaysOfWeek ( DaysOfWeek);

alter table mainClass_att16
	add column mainClassId int     , add foreign key (mainClassId) references mainClass ( mainClassId);
alter table mainClass_att16
	add column att16 int     ;

alter table mainClass_att15
	add column mainClassId int     , add foreign key (mainClassId) references mainClass ( mainClassId);
alter table mainClass_att15
	add column att15 varchar(1000)     ;

alter table mainClass_att14_secondaryClass_attF
	add column mainClass_att14 int     , add foreign key (mainClass_att14) references mainClass ( mainClassId);
alter table mainClass_att14_secondaryClass_attF
	add column secondaryClass_attF int     , add foreign key (secondaryClass_attF) references secondaryClass ( secondaryClassId);

alter table mainClass_att13_secondaryClass_attE
	add column mainClass_att13 int     , add foreign key (mainClass_att13) references mainClass ( mainClassId);
alter table mainClass_att13_secondaryClass_attE
	add column secondaryClass_attE int     , add foreign key (secondaryClass_attE) references secondaryClass ( secondaryClassId);

alter table mainClass_att12_secondaryClass_attD
	add column mainClass_att12 int     , add foreign key (mainClass_att12) references mainClass ( mainClassId);
alter table mainClass_att12_secondaryClass_attD
	add column secondaryClass_attD int     , add foreign key (secondaryClass_attD) references secondaryClass ( secondaryClassId);

alter table mainClass_att7_secondaryClass_attC
	add column mainClass_att7 int     , add foreign key (mainClass_att7) references mainClass ( mainClassId);
alter table mainClass_att7_secondaryClass_attC
	add column secondaryClass_attC int     , add foreign key (secondaryClass_attC) references secondaryClass ( secondaryClassId);

alter table mainClass_att6_secondaryClass_attB
	add column mainClass_att6 int     , add foreign key (mainClass_att6) references mainClass ( mainClassId);
alter table mainClass_att6_secondaryClass_attB
	add column secondaryClass_attB int     , add foreign key (secondaryClass_attB) references secondaryClass ( secondaryClassId);

alter table mainClass_att5_secondaryClass_attA
	add column mainClass_att5 int     , add foreign key (mainClass_att5) references mainClass ( mainClassId);
alter table mainClass_att5_secondaryClass_attA
	add column secondaryClass_attA int     , add foreign key (secondaryClass_attA) references secondaryClass ( secondaryClassId);

alter table secondaryClass
	add column name varchar(1000)     ;

alter table mainClass
	add column att1 varchar(1000)     ;
alter table mainClass
	add column att2 int     ;
alter table mainClass
	add column att3 varchar(500)     , add foreign key (att3) references DaysOfWeek ( DaysOfWeek);
alter table mainClass
	add column att4 int     , add foreign key (att4) references secondaryClass ( secondaryClassId);
alter table mainClass
	add column att8 varchar(1000) null default null   ;
alter table mainClass
	add column att9 int null default null   ;
alter table mainClass
	add column att10 varchar(500) null default null   , add foreign key (att10) references DaysOfWeek ( DaysOfWeek);
alter table mainClass
	add column att11 int null default null   , add foreign key (att11) references secondaryClass ( secondaryClassId);
alter table mainClass
	add column att22 datetime     ;


alter table _Meta_Method_Params
	add column class varchar(500)     ;
alter table _Meta_Method_Params
	add column methodName varchar(500)     ;
alter table _Meta_Method_Params
	add column paramName varchar(500)     ;
alter table _Meta_Method_Params
	add column paramType varchar(500)     ;
alter table _Meta_Method_Params
	add column paramMultiplicity varchar(500)     ;
alter table _Meta_Method_Params
	add column paramInOut varchar(10)     ;
alter table _Meta_Method_Params
	add column paramClassName varchar(500)     ;
alter table _Meta_Method_Params
	add column paramSetName varchar(500)     ;

alter table _Meta_Methods
	add column class varchar(500)     ;
alter table _Meta_Methods
	add column methodName varchar(500)     ;
alter table _Meta_Methods
	add column isObjectMethod bit     ;

alter table _Meta_Attributes
	add column class varchar(500)     ;
alter table _Meta_Attributes
	add column attName varchar(500)     ;
alter table _Meta_Attributes
	add column primType varchar(500)     ;
alter table _Meta_Attributes
	add column typeMultiplicity varchar(500)     ;
alter table _Meta_Attributes
	add column className varchar(500)     ;
alter table _Meta_Attributes
	add column setName varchar(500)     ;
alter table _Meta_Attributes
	add column direction varchar(500)     ;
alter table _Meta_Attributes
	add column tableName varchar(500)     ;
alter table _Meta_Attributes
	add column oppAttName varchar(500)     ;
alter table _Meta_Attributes
	add column isId bit     ;

alter table _Meta_Classes
	add column className varchar(500)     ;
alter table _Meta_Classes
	add column tableName varchar(500)     ;

drop procedure if exists mainClass_changeName;
delimiter //
create procedure mainClass_changeName ( in a datetime, in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if true and true and true and true and true and true
  then update  mainClass
       set att22 = a
       where this = mainClassId
       
        ;
       
  
  end if ;
  
  commit;
	end //
delimiter ;


insert  
into
_Meta_Classes
(className, tablename)
values
('mainClass','mainClass')
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att1','String','Mandatory',null,'','','Uni','mainClass',1)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att2','Integer','Mandatory',null,'','','Uni','mainClass',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att3','SetValue','Mandatory',null,'','DaysOfWeek','Uni','mainClass',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att4','ClassRef','Mandatory',null,'secondaryClass','','Uni','mainClass',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att5','ClassRef','Mandatory','attA','secondaryClass','','Bi','mainClass_att5_secondaryClass_attA',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att6','ClassRef','Mandatory','attB','secondaryClass','','Bi','mainClass_att6_secondaryClass_attB',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att7','ClassRef','Mandatory','attC','secondaryClass','','Bi','mainClass_att7_secondaryClass_attC',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att8','String','Optional',null,'','','Uni','mainClass',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att9','Integer','Optional',null,'','','Uni','mainClass',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att10','SetValue','Optional',null,'','DaysOfWeek','Uni','mainClass',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att11','ClassRef','Optional',null,'secondaryClass','','Uni','mainClass',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att12','ClassRef','Optional','attD','secondaryClass','','Bi','mainClass_att12_secondaryClass_attD',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att13','ClassRef','Optional','attE','secondaryClass','','Bi','mainClass_att13_secondaryClass_attE',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att14','ClassRef','Optional','attF','secondaryClass','','Bi','mainClass_att14_secondaryClass_attF',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att15','String','Set',null,'','','Uni','mainClass_att15',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att16','Integer','Set',null,'','','Uni','mainClass_att16',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att17','SetValue','Set',null,'','DaysOfWeek','Uni','mainClass_att17',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att18','ClassRef','Set',null,'secondaryClass','','Uni','mainClass_att18',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att19','ClassRef','Set','attG','secondaryClass','','Bi','mainClass_att19_secondaryClass_attG',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att20','ClassRef','Set','attH','secondaryClass','','Bi','mainClass_att20_secondaryClass_attH',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att21','ClassRef','Set','attI','secondaryClass','','Bi','mainClass_att21_secondaryClass_attI',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('mainClass','att22','DateTime','Mandatory',null,'','','Uni','mainClass',0)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('mainClass','changeName',true)
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('mainClass','changeName','a','DateTime','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('mainClass','changeName','this','ClassRef','Mandatory','input','mainClass','')
 ;
insert  
into
_Meta_Classes
(className, tablename)
values
('secondaryClass','secondaryClass')
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('secondaryClass','name','String','Mandatory',null,'','','Uni','secondaryClass',1)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('secondaryClass','attA','ClassRef','Mandatory','att5','mainClass','','Bi','mainClass_att5_secondaryClass_attA',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('secondaryClass','attB','ClassRef','Optional','att6','mainClass','','Bi','mainClass_att6_secondaryClass_attB',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('secondaryClass','attC','ClassRef','Set','att7','mainClass','','Bi','mainClass_att7_secondaryClass_attC',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('secondaryClass','attD','ClassRef','Mandatory','att12','mainClass','','Bi','mainClass_att12_secondaryClass_attD',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('secondaryClass','attE','ClassRef','Optional','att13','mainClass','','Bi','mainClass_att13_secondaryClass_attE',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('secondaryClass','attF','ClassRef','Set','att14','mainClass','','Bi','mainClass_att14_secondaryClass_attF',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('secondaryClass','attG','ClassRef','Mandatory','att19','mainClass','','Bi','mainClass_att19_secondaryClass_attG',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('secondaryClass','attH','ClassRef','Optional','att20','mainClass','','Bi','mainClass_att20_secondaryClass_attH',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('secondaryClass','attI','ClassRef','Set','att21','mainClass','','Bi','mainClass_att21_secondaryClass_attI',0)
 ;
insert  
into
DaysOfWeek
(DaysOfWeek)
values
('Monday')
 ;
insert  
into
DaysOfWeek
(DaysOfWeek)
values
('Tuesday')
 ;
insert  
into
DaysOfWeek
(DaysOfWeek)
values
('Wednesday')
 ;
insert  
into
DaysOfWeek
(DaysOfWeek)
values
('Thursday')
 ;
insert  
into
DaysOfWeek
(DaysOfWeek)
values
('Friday')
 ;
insert  
into
DaysOfWeek
(DaysOfWeek)
values
('Saturday')
 ;
insert  
into
DaysOfWeek
(DaysOfWeek)
values
('Sunday')
 ;
insert  
into
DaysOfWeek
(DaysOfWeek)
values
('unassigned')
 ;

SET @@GLOBAL.max_sp_recursion_depth = 255;
SET @@session.max_sp_recursion_depth = 255; 

DELIMITER $$

CREATE PROCEDURE `COUNT_ALL_RECORDS_BY_TABLE`()
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE TNAME CHAR(255);

DECLARE table_names CURSOR for 
    SELECT tableName FROM _Meta_Classes;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN table_names;   

DROP TABLE IF EXISTS TCOUNTS;
CREATE TEMPORARY TABLE TCOUNTS 
  (
    TABLE_NAME CHAR(255),
    RECORD_COUNT INT,
	MIN_ID INT
  ) ENGINE = MEMORY; 


WHILE done = 0 DO

  FETCH NEXT FROM table_names INTO TNAME;

   IF done = 0 THEN
    SET @SQL_TXT = CONCAT("INSERT INTO TCOUNTS(SELECT '" , TNAME  , "' AS TABLE_NAME, COUNT(*) AS RECORD_COUNT, MIN(",TNAME,"Id) AS MIN_ID FROM ", TNAME, ")");

    PREPARE stmt_name FROM @SQL_TXT;
    EXECUTE stmt_name;
    DEALLOCATE PREPARE stmt_name;  
  END IF;

END WHILE;

CLOSE table_names;

SELECT * FROM TCOUNTS;

END
$$

CREATE PROCEDURE `GET_OBJECT_DESCRIPTION`( className_in VARCHAR(500), objectID INT, out objectDesc VARCHAR(100))
BEGIN

DROP TABLE IF EXISTS ATTRIBUTES_FOR_DESC;
CREATE TEMPORARY TABLE ATTRIBUTES_FOR_DESC 
  (
    ID INT PRIMARY KEY AUTO_INCREMENT,
	CALL_CLASS VARCHAR(500),
	CALL_OID INT,
    ATT_NAME VARCHAR(500),
    ATT_PRIM_TYPE VARCHAR(500),
    TYPE_MULT VARCHAR(500),
    INT_VALUE INT,
    STRING_VALUE VARCHAR(500),
    DATETIME_VALUE TIMESTAMP,
    SET_VALUE VARCHAR(500),
    OID_VALUE INT,
    CLASS_NAME VARCHAR(100)
  ) ENGINE = MEMORY; 

CALL `GET_OBJECT_DESCRIPTION_RECURSE`( className_in, objectID, objectDesc);

/*SELECT * FROM ATTRIBUTES_FOR_DESC; */
END
$$


DELIMITER $$

CREATE PROCEDURE `GET_OBJECT_DESCRIPTION_RECURSE`( className_in VARCHAR(500), objectID INT, out objectDesc VARCHAR(100))
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE ANAME CHAR(255);

DECLARE attribute_names CURSOR for 
    SELECT attName FROM _Meta_Attributes WHERE class = className_in and isId = 1;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN attribute_names;   



WHILE done = 0 DO

  FETCH NEXT FROM attribute_names INTO ANAME;
  SET @SQL_TXT = null;
   IF done = 0 THEN
    SET @primType = (SELECT primType FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @typeMult = (SELECT typeMultiplicity FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @direction = (SELECT direction FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @className = (SELECT _Meta_Attributes.className FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @tableName = (SELECT _Meta_Attributes.tableName FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @oppAttName = (SELECT _Meta_Attributes.oppAttName FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    
    IF @primType = 'String' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC 
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE) 
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'Integer' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'DateTime' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, DATETIME_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS DATETIME_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'SetValue' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Uni' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Bi' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",@className,"_",@oppAttName," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");

    

    END IF;

    IF(@SQL_TXT is not null ) THEN
        PREPARE stmt_name FROM @SQL_TXT;
        EXECUTE stmt_name;
        DEALLOCATE PREPARE stmt_name;
    END IF;
  END IF;

END WHILE;

CLOSE attribute_names;


BEGIN
DECLARE AID INT;
DECLARE OBJID INT;
DECLARE CNAME VARCHAR(500);

DECLARE attribute_values CURSOR for 
    SELECT ID, OID_VALUE, CLASS_NAME FROM ATTRIBUTES_FOR_DESC 
	WHERE OID_VALUE is not null
	AND CALL_CLASS = className_in
	AND CALL_OID = objectID;

SET done = 0;
OPEN attribute_values;  

WHILE done = 0 DO

  FETCH NEXT FROM attribute_values INTO AID, OBJID, CNAME;
   IF done = 0 THEN
    CALL `GET_OBJECT_DESCRIPTION_RECURSE`(CNAME, OBJID, @objDesc);
    UPDATE ATTRIBUTES_FOR_DESC SET STRING_VALUE = @objDesc WHERE ID = AID;
    
   END IF;

END WHILE;

CLOSE attribute_values;
END;

SET objectDesc = (SELECT group_concat(STRING_VALUE separator ', ') 
	FROM ATTRIBUTES_FOR_DESC 
	WHERE CALL_CLASS = className_in
	AND CALL_OID = objectID);

END
$$
DELIMITER $$

CREATE PROCEDURE `GET_OBJECT`( className_in VARCHAR(500), objectID INT)
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE ANAME CHAR(255);


DECLARE attribute_names CURSOR for 
    SELECT attName FROM _Meta_Attributes WHERE class = className_in;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN attribute_names;   

DROP TABLE IF EXISTS ATTRIBUTES;
CREATE TEMPORARY TABLE ATTRIBUTES 
  (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ATT_NAME VARCHAR(500),
    ATT_PRIM_TYPE VARCHAR(500),
    TYPE_MULT VARCHAR(500),
    INT_VALUE INT,
    STRING_VALUE VARCHAR(500),
    DATETIME_VALUE TIMESTAMP,
    SET_VALUE VARCHAR(500),
    OID_VALUE INT,
    CLASS_NAME VARCHAR(100),
    OBJ_DESC VARCHAR(500)
  ) ENGINE = MEMORY; 


WHILE done = 0 DO

  FETCH NEXT FROM attribute_names INTO ANAME;
  SET @SQL_TXT = null;
   IF done = 0 THEN
    SET @primType = (SELECT primType FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @typeMult = (SELECT typeMultiplicity FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @direction = (SELECT direction FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @className = (SELECT _Meta_Attributes.className FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @oppAttName = (SELECT _Meta_Attributes.oppAttName FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @tableName = (SELECT _Meta_Attributes.tableName FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    
    IF @primType = 'String' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'Integer' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, INT_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS INT_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'DateTime' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, DATETIME_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS DATETIME_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'SetValue' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, SET_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS SET_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Uni' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Bi' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",@className,"_",@oppAttName," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",className_in,"_",ANAME," = ", objectID, ")");

    ELSEIF @primType = 'String' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM ", @tableName," WHERE ",className_in,"Id = ", objectID, ")");
    ELSEIF @primType = 'Integer' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, INT_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS INT_VALUE FROM ", @tableName," WHERE ",className_in,"Id = ", objectID, ")");
    ELSEIF @primType = 'DateTime' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, DATETIME_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS DATETIME_VALUE FROM ", @tableName," WHERE ",className_in,"Id = ", objectID, ")");

    ELSEIF @primType = 'SetValue' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, SET_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS SET_VALUE FROM ", @tableName," WHERE ",className_in,"Id = ", objectID, ")");

   ELSEIF @primType = 'ClassRef' and @typeMult = 'Set' and @direction = 'Uni' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",className_in,"Id = ", objectID, ")");

    ELSEIF @primType = 'ClassRef' and @typeMult = 'Set' and @direction = 'Bi' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",@className,"_",@oppAttName," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",className_in,"_",ANAME," = ", objectID, ")");
 


    END IF;

    IF(@SQL_TXT is not null ) THEN
        PREPARE stmt_name FROM @SQL_TXT;
        EXECUTE stmt_name;
        DEALLOCATE PREPARE stmt_name;
    END IF;
  END IF;

END WHILE;

CLOSE attribute_names;


BEGIN
DECLARE AID INT;
DECLARE OBJID INT;
DECLARE CNAME VARCHAR(500);

DECLARE attribute_values CURSOR for 
    SELECT ID, OID_VALUE, CLASS_NAME FROM ATTRIBUTES WHERE OID_VALUE is not null;

SET done = 0;
OPEN attribute_values;  

WHILE done = 0 DO

  FETCH NEXT FROM attribute_values INTO AID, OBJID, CNAME;
   IF done = 0 THEN
    CALL `GET_OBJECT_DESCRIPTION`(CNAME, OBJID, @objDesc);
    UPDATE ATTRIBUTES SET OBJ_DESC = @objDesc WHERE ID = AID;
    
   END IF;

END WHILE;

CLOSE attribute_values;

SELECT * FROM ATTRIBUTES;
		
				END;
				
				END
				$$

			
CREATE PROCEDURE `GET_OBJECT_METHOD_NAMES` ( className_in VARCHAR(500))
	BEGIN
    SELECT * FROM _Meta_Methods WHERE class = className_in AND isObjectMethod = true;
  END;
$$

CREATE PROCEDURE `GET_CLASS_METHOD_NAMES` ( className_in VARCHAR(500))
	BEGIN
    SELECT * FROM _Meta_Methods WHERE class = className_in AND isObjectMethod = false;
  END;
$$

CREATE PROCEDURE `METHOD_PARAMS` ( className_in VARCHAR(500),  methodName_in VARCHAR(500))
	BEGIN
    SELECT * FROM _Meta_Method_Params WHERE class = className_in and methodName = methodName_in;
  END;
$$

DELIMITER ;
drop procedure if exists `GET_OBJECT_BROWSE_LOCATION`;
DELIMITER $$
CREATE PROCEDURE `GET_OBJECT_BROWSE_LOCATION` ( className_in VARCHAR(500), Id_in INT)
	BEGIN
		
		SET @tableName = (SELECT tableName FROM _Meta_Classes WHERE className = className_in);  
		SET @idName = CONCAT(@tableName, "ID");
		
		SET @SQL_TXT = CONCAT("select ", 
				"(select min(",@idName,") from ",@tableName," where ",@idName," > ", Id_in, ") as next,", 
				"(select max(",@idName,") from ",@tableName," where ",@idName," < ", Id_in, ") as prev,",
				"(select min(",@idName,") from ",@tableName,") as first,",
				"(select max(",@idName,") from ",@tableName,") as last"); 
    	
		IF(@SQL_TXT is not null ) THEN
        	PREPARE stmt_name FROM @SQL_TXT;
        	EXECUTE stmt_name;
        	DEALLOCATE PREPARE stmt_name;
    	END IF;
  	END;
 $$


