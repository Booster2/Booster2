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
		MIN_ID VARCHAR(36)
  ) ENGINE = MEMORY; 


WHILE done = 0 DO

  FETCH NEXT FROM table_names INTO TNAME;

   IF done = 0 THEN
    SET @SQL_TXT = CONCAT("INSERT INTO TCOUNTS(SELECT '" , TNAME  , "' AS TABLE_NAME, COUNT(*) AS RECORD_COUNT, `",TNAME,"Id` AS MIN_ID FROM `", TNAME, "` order by `", TNAME, "_createdDate` limit 1)");

    PREPARE stmt_name FROM @SQL_TXT;
    EXECUTE stmt_name;
    DEALLOCATE PREPARE stmt_name;  
  END IF;

END WHILE;

CLOSE table_names;

SELECT * FROM TCOUNTS;

END
$$

CREATE PROCEDURE `GET_OBJECT_DESCRIPTION`( className_in VARCHAR(1000), objectID VARCHAR(36), out objectDesc VARCHAR(1000))
BEGIN

DROP TABLE IF EXISTS ATTRIBUTES_FOR_DESC;
CREATE TEMPORARY TABLE ATTRIBUTES_FOR_DESC 
  (
    ID INT PRIMARY KEY AUTO_INCREMENT,
	CALL_CLASS VARCHAR(1000),
	CALL_OID VARCHAR(36),
    ATT_NAME VARCHAR(1000),
    ATT_PRIM_TYPE VARCHAR(1000),
    TYPE_MULT VARCHAR(1000),
    INT_VALUE INT,
    DECIMAL_VALUE DECIMAL(65,30),
    STRING_VALUE VARCHAR(1000),
    DATETIME_VALUE TIMESTAMP NULL,
    SET_VALUE VARCHAR(1000),
    OID_VALUE VARCHAR(36),
    CLASS_NAME VARCHAR(100)
  ) ENGINE = MEMORY; 

CALL `GET_OBJECT_DESCRIPTION_RECURSE`( className_in, objectID, objectDesc);

/*SELECT * FROM ATTRIBUTES_FOR_DESC; */
END
$$


DELIMITER $$

CREATE PROCEDURE `GET_OBJECT_DESCRIPTION_RECURSE`( className_in VARCHAR(1000), objectID VARCHAR(36), out objectDesc VARCHAR(1000))
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
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Password' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC 
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE) 
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Integer' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Boolean' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Decimal' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, TRIM(`",ANAME,"`)+0 AS STRING_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'DateTime' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Date' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Time' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'SetValue' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Uni' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Bi' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",@className,"_",@oppAttName," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");

    

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
DECLARE OBJID VARCHAR(36);
DECLARE CNAME VARCHAR(1000);

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

CREATE PROCEDURE `GET_OBJECT`( className_in VARCHAR(1000), objectID VARCHAR(36))
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE ANAME CHAR(255);
DECLARE ACTUAL_CLASS VARCHAR(1000);
CALL `GET_OBJECT_ACTUAL_CLASS`( className_in, objectID, @ACTUAL_CLASS);
BEGIN
DECLARE attribute_names CURSOR for 
    SELECT attName FROM _Meta_Attributes WHERE class = @ACTUAL_CLASS;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN attribute_names;   

DROP TABLE IF EXISTS ATTRIBUTES;
CREATE TEMPORARY TABLE ATTRIBUTES 
  (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ATT_NAME VARCHAR(1000),
    ATT_PRIM_TYPE VARCHAR(1000),
    TYPE_MULT VARCHAR(1000),
    INT_VALUE INT,
    DECIMAL_VALUE DECIMAL(65,30),
    STRING_VALUE VARCHAR(1000),
    DATETIME_VALUE TIMESTAMP NULL,
    DATE_VALUE DATE NULL,
    TIME_VALUE TIME NULL,
    SET_VALUE VARCHAR(1000),
    OID_VALUE VARCHAR(36),
    CLASS_NAME VARCHAR(100),
    OBJ_DESC VARCHAR(1000)
  ) ENGINE = MEMORY; 


WHILE done = 0 DO

  FETCH NEXT FROM attribute_names INTO ANAME;
  SET @SQL_TXT = null;
   IF done = 0 THEN
    SET @primType = (SELECT primType FROM _Meta_Attributes WHERE attName = ANAME AND class = @ACTUAL_CLASS);
    SET @typeMult = (SELECT typeMultiplicity FROM _Meta_Attributes WHERE attName = ANAME AND class = @ACTUAL_CLASS);
    SET @direction = (SELECT direction FROM _Meta_Attributes WHERE attName = ANAME AND class = @ACTUAL_CLASS);
    SET @className = (SELECT _Meta_Attributes.className FROM _Meta_Attributes WHERE attName = ANAME AND class = @ACTUAL_CLASS);
    SET @oppAttName = (SELECT _Meta_Attributes.oppAttName FROM _Meta_Attributes WHERE attName = ANAME AND class = @ACTUAL_CLASS);
    SET @tableName = (SELECT _Meta_Attributes.tableName FROM _Meta_Attributes WHERE attName = ANAME AND class = @ACTUAL_CLASS);
    
    IF @primType = 'String' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS STRING_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Password' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS STRING_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Integer' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, INT_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS INT_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Boolean' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, INT_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS INT_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Decimal' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, DECIMAL_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS DECIMAL_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'DateTime' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, DATETIME_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS DATETIME_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Date' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, DATE_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS DATE_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'Time' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, TIME_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS TIME_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'SetValue' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, SET_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS SET_VALUE FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Uni' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Bi' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",@className,"_",@oppAttName,"` AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM `", @tableName,"` WHERE ",@tableName," = '", objectID, "')");

    ELSEIF @primType = 'String' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS STRING_VALUE FROM `", @tableName,"` WHERE ",@ACTUAL_CLASS,"Id = '", objectID, "')");
    ELSEIF @primType = 'Password' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS STRING_VALUE FROM `", @tableName,"` WHERE ",@ACTUAL_CLASS,"Id = '", objectID, "')");
    ELSEIF @primType = 'Integer' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, INT_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS INT_VALUE FROM `", @tableName,"` WHERE ",@ACTUAL_CLASS,"Id = '", objectID, "')");
    ELSEIF @primType = 'Boolean' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, INT_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS INT_VALUE FROM `", @tableName,"` WHERE ",@ACTUAL_CLASS,"Id = '", objectID, "')");
    ELSEIF @primType = 'Decimal' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, INT_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS DECIMAL_VALUE FROM `", @tableName,"` WHERE ",@ACTUAL_CLASS,"Id = '", objectID, "')");
    ELSEIF @primType = 'DateTime' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, DATETIME_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS DATETIME_VALUE FROM `", @tableName,"` WHERE ",@ACTUAL_CLASS,"Id = '", objectID, "')");
    ELSEIF @primType = 'Date' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, DATE_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS DATE_VALUE FROM `", @tableName,"` WHERE ",@ACTUAL_CLASS,"Id = '", objectID, "')");
    ELSEIF @primType = 'Time' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, TIME_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS TIME_VALUE FROM `", @tableName,"` WHERE ",@ACTUAL_CLASS,"Id = '", objectID, "')");

    ELSEIF @primType = 'SetValue' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, SET_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS SET_VALUE FROM `", @tableName,"` WHERE ",@ACTUAL_CLASS,"Id = '", objectID, "')");

   ELSEIF @primType = 'ClassRef' and @typeMult = 'Set' and @direction = 'Uni' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",ANAME,"` AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM `", @tableName,"` WHERE ",@tableName,"Id = '", objectID, "')");

    ELSEIF @primType = 'ClassRef' and @typeMult = 'Set' and @direction = 'Bi' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, `",@className,"_",@oppAttName,"` AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM `", @tableName,"` WHERE ",@tableName," = '", objectID, "')");
 


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
DECLARE OBJID VARCHAR(36);
DECLARE CNAME VARCHAR(1000);

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
				END;
				
				END
				$$

			
drop procedure if exists `GET_OBJECT_METHOD_NAMES`;
DELIMITER $$
CREATE PROCEDURE `GET_OBJECT_METHOD_NAMES` ( className_in VARCHAR(1000), OID_in VARCHAR(36), _currentUser VARCHAR(36))
	BEGIN
DROP TABLE IF EXISTS OBJECT_METHODS;
CREATE TEMPORARY TABLE OBJECT_METHODS 
  (
    ID INT PRIMARY KEY AUTO_INCREMENT,
	methodName VARCHAR(1000),
	methodAvailable BIT
  ) ENGINE = MEMORY; 
	BEGIN
	DECLARE MNAME CHAR(255);
	DECLARE done INT DEFAULT 0;

	DECLARE method_names CURSOR for
		SELECT methodName FROM _Meta_Methods WHERE class = className_in AND isObjectMethod = true;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = 1;
	OPEN method_names;

	WHILE done = 0 DO
		FETCH NEXT FROM method_names INTO MNAME;
		IF done = 0 THEN
			SET @SQL_TEXT = CONCAT("INSERT INTO OBJECT_METHODS (methodName, methodAvailable) VALUES ('", MNAME,"', ", className_in,"_",MNAME,"_available ('", OID_in, "','", _currentUser, "'));");
				PREPARE stmt_name FROM @SQL_TEXT;
				EXECUTE stmt_name;
				DEALLOCATE PREPARE stmt_name; 
		END IF;
	END WHILE;

CLOSE method_names;
	SELECT * from OBJECT_METHODS;
	END;
  END;
$$


CREATE PROCEDURE `GET_CLASS_METHOD_NAMES` ( className_in VARCHAR(1000))
	BEGIN
    SELECT * FROM _Meta_Methods WHERE class = className_in AND isObjectMethod = false;
  END;
$$

CREATE PROCEDURE `METHOD_PARAMS` ( className_in VARCHAR(1000),  methodName_in VARCHAR(1000))
	BEGIN
    SELECT * FROM _Meta_Method_Params WHERE class = className_in and methodName = methodName_in;
  END;
$$

DELIMITER ;
drop procedure if exists `GET_OBJECT_BROWSE_LOCATION`;
DELIMITER $$
CREATE PROCEDURE `GET_OBJECT_BROWSE_LOCATION` ( className_in VARCHAR(1000), Id_in VARCHAR(36))
	BEGIN
		
		SET @tableName = (SELECT tableName FROM _Meta_Classes WHERE className = className_in);  
		SET @idName = CONCAT(@tableName, "ID");
		SET @dcName = CONCAT(@tableName, "_createdDate");
		
		SET @SQL_TXT = CONCAT("select ", 
				"(select ",@idName," from `",@tableName,"` where ",@dcName," > (select ",@dcName," from ",@tableName," where ",@idName," = '",Id_in,"') order by ", @dcName, " asc limit 1) as next,", 
				"(select ",@idName," from `",@tableName,"` where ",@dcName," < (select ",@dcName," from ",@tableName," where ",@idName," = '",Id_in,"') order by ", @dcName, " desc limit 1) as prev,", 
				"(select ",@idName," from `",@tableName,"` order by ", @dcName, " asc limit 1) as first,",
				"(select ",@idName," from `",@tableName,"` order by ", @dcName, " desc limit 1) as last"); 

		IF(@SQL_TXT is not null ) THEN
        	PREPARE stmt_name FROM @SQL_TXT;
        	EXECUTE stmt_name;
        	DEALLOCATE PREPARE stmt_name;
    	END IF;
  	END;
 $$

DELIMITER ;

DROP PROCEDURE IF EXISTS `GET_OBJECT_DESCRIPTION_AS_TABLE`;

DELIMITER $$

CREATE PROCEDURE `GET_OBJECT_DESCRIPTION_AS_TABLE`( className_in VARCHAR(1000), orderBy_in VARCHAR(255), direction_in VARCHAR(10), start_in INT, limit_in INT, searchTerm_in VARCHAR(100), out total_out INT)
BEGIN
DECLARE thisTableName CHAR(255);
DECLARE idField CHAR(255);
if orderBy_in is null or orderBy_in = '' then
begin
	set orderBy_in = 'ID';
end;
end if;
set @thisTableName = (select tableName from _Meta_Classes where className = className_in);
set @idField = CONCAT(@thisTableName, 'Id');


DROP TABLE IF EXISTS ATTRIBUTES_FOR_DESC;
CREATE TEMPORARY TABLE ATTRIBUTES_FOR_DESC 
  (
    ID INT PRIMARY KEY AUTO_INCREMENT,
	CALL_CLASS VARCHAR(1000),
	CALL_OID VARCHAR(36),
    ATT_NAME VARCHAR(1000),
    ATT_PRIM_TYPE VARCHAR(1000),
    TYPE_MULT VARCHAR(1000),
    INT_VALUE INT,
    DECIMAL_VALUE DECIMAL(65,30),
    STRING_VALUE VARCHAR(1000),
    SET_VALUE VARCHAR(1000),
    OID_VALUE VARCHAR(36),
    CLASS_NAME VARCHAR(100)
  ) ENGINE = MEMORY; 

BEGIN


DROP TABLE IF EXISTS OBJECT_IDS;
CREATE TEMPORARY TABLE OBJECT_IDS 
  (
    ID VARCHAR(36) PRIMARY KEY 
  );

SET @SQL_TEXT = CONCAT('INSERT INTO `OBJECT_IDS` SELECT ', @idField, ' FROM ', @thisTableName, '');

PREPARE stmt_name FROM @SQL_TEXT;
EXECUTE stmt_name;
DEALLOCATE PREPARE stmt_name; 


/*SELECT * FROM OBJECT_IDS;*/


/*DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1; */
	

END;


BEGIN
DECLARE done INT DEFAULT 0;
DECLARE OID VARCHAR(36) ;

DECLARE object_ids CURSOR for 
    SELECT ID FROM OBJECT_IDS ;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


OPEN object_ids;   

WHILE done = 0 DO
	FETCH NEXT FROM object_ids INTO OID;
		IF done = 0 THEN
			SET @SQL_TEXT = CONCAT('CALL `GET_OBJECT_DESCRIPTION_RECURSE`( \'', className_in, '\',\'', OID, '\',@objectDesc)');
			PREPARE stmt_name5 FROM @SQL_TEXT;
			EXECUTE stmt_name5;
			DEALLOCATE PREPARE stmt_name5; 
		END IF;
END WHILE;

END;
/*SELECT * FROM ATTRIBUTES_FOR_DESC;
SELECT DISTINCT ATT_NAME, ATT_PRIM_TYPE FROM ATTRIBUTES_FOR_DESC WHERE CALL_CLASS = className_in; */

BEGIN

DECLARE done INT DEFAULT 0;
DECLARE ANAME CHAR(255);
DECLARE APT CHAR(20);

DECLARE WHERE_CLAUSE TEXT;


DECLARE attribute_names CURSOR for 
    SELECT DISTINCT ATT_NAME, ATT_PRIM_TYPE FROM ATTRIBUTES_FOR_DESC WHERE CALL_CLASS = className_in;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN attribute_names;   
SET @WHERE_CLAUSE = '';

WHILE done = 0 DO
	FETCH NEXT FROM attribute_names INTO ANAME, APT;
		IF done = 0 THEN
			IF(APT = 'String') THEN
				SET @SQL_TEXT1 = CONCAT('ALTER TABLE `OBJECT_IDS` ADD COLUMN `',ANAME, '` VARCHAR(1000);');
			ELSEIF(APT = 'Integer') THEN
				SET @SQL_TEXT1 = CONCAT('ALTER TABLE `OBJECT_IDS` ADD COLUMN `',ANAME, '` INT;');
			ELSEIF(APT = 'Decimal') THEN
				SET @SQL_TEXT1 = CONCAT('ALTER TABLE `OBJECT_IDS` ADD COLUMN `',ANAME, '` DECIMAL(65,30);');
			ELSEIF(APT = 'DateTime') THEN
				SET @SQL_TEXT1 = CONCAT('ALTER TABLE `OBJECT_IDS` ADD COLUMN `',ANAME, '` TIMESTAMP;');

			END IF;
			/* SELECT @SQL_TEXT1; */
			
			IF(@SQL_TEXT1 is not null ) THEN
				PREPARE stmt_name6 FROM @SQL_TEXT1;
				EXECUTE stmt_name6;
				DEALLOCATE PREPARE stmt_name6; 
				
			END IF;
			SET @WHERE_CLAUSE = CONCAT(@WHERE_CLAUSE, 'OR CAST(', ANAME, ' AS CHAR) LIKE "%', searchTerm_in, '%" ');
		END IF; 
END WHILE;
END;


BEGIN

DECLARE done INT DEFAULT 0;
DECLARE ANAME CHAR(255);
DECLARE OID VARCHAR(36);
DECLARE APT CHAR(20);
DECLARE STRV CHAR(255);
DECLARE INTV INT;

DECLARE attribute_rows CURSOR for 
    SELECT CALL_OID, ATT_NAME, ATT_PRIM_TYPE, INT_VALUE, STRING_VALUE
  FROM ATTRIBUTES_FOR_DESC WHERE CALL_CLASS = className_in;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN attribute_rows;   

/*SELECT * FROM ATTRIBUTES_FOR_DESC;*/
WHILE done = 0 DO
	FETCH NEXT FROM attribute_rows INTO OID, ANAME, APT, INTV, STRV;
		IF done = 0 THEN
		/*SELECT ANAME; */		

		SET @SQL_TEXT2 = null;
			SET @SQL_TEXT2 = CONCAT('INSERT INTO `OBJECT_IDS` (ID, ',ANAME,' ) VALUES (?,?) ON DUPLICATE KEY UPDATE ',ANAME,' = ?');
			/*SET @SQL_TEXT2 = CONCAT('INSERT INTO `OBJECT_IDS` (ID, ',ANAME, ') VALUES (',OID, ',', STRV, ') ON DUPLICATE KEY UPDATE ', ANAME, ' = ', STRV); */
		IF(@SQL_TEXT2 is not null ) THEN
			PREPARE stmt_name FROM @SQL_TEXT2;
			SET @OIDV = OID;
			SET @STRVV = STRV;
			EXECUTE stmt_name USING @OIDV, @STRVV, @STRVV;
			DEALLOCATE PREPARE stmt_name; 
		END IF; 
	END IF;
END WHILE;

CLOSE attribute_rows;
END;

SET @SQL_RESULT1 = CONCAT('SELECT * FROM OBJECT_IDS ',
							'WHERE false ', @WHERE_CLAUSE,
							'ORDER BY ', orderBy_in, ' ', direction_in, ' LIMIT ', start_in, ', ', limit_in, 
							';');
SET @SQL_RESULT2 = CONCAT('SELECT COUNT(*) INTO @total_rows FROM OBJECT_IDS ', 
							'WHERE false ', @WHERE_CLAUSE,
							';');

PREPARE stmt_result FROM @SQL_RESULT1;
EXECUTE stmt_result;
DEALLOCATE PREPARE stmt_result; 

PREPARE stmt_result FROM @SQL_RESULT2;
EXECUTE stmt_result;
DEALLOCATE PREPARE stmt_result; 

/* SELECT @WHERE_CLAUSE; */
SET total_out = @total_rows ;
/*SELECT * FROM ATTRIBUTES_FOR_DESC; */
END
$$

DELIMITER ;

DELIMITER ;
DROP PROCEDURE IF EXISTS `GET_NO_OBJECTS_FOR_CLASS` ;
DELIMITER $$
CREATE PROCEDURE `GET_NO_OBJECTS_FOR_CLASS`( className_in VARCHAR(100), out recordCount_out INT)
BEGIN
DECLARE done INT DEFAULT 0;


SELECT tableName INTO @TNAME FROM _Meta_Classes where className = className_in;

SET @SQL_TXT = CONCAT("SELECT COUNT(*) INTO @rc FROM ", @TNAME);

PREPARE stmt_name FROM @SQL_TXT;
EXECUTE stmt_name;
DEALLOCATE PREPARE stmt_name; 
SET recordCount_out = @rc;
END
$$

DELIMITER ;

DROP PROCEDURE IF EXISTS `GET_OBJECT_DESCRIPTION_ATTRIBUTES`;
DELIMITER $$

CREATE PROCEDURE `GET_OBJECT_DESCRIPTION_ATTRIBUTES`( className_in VARCHAR(1000))
BEGIN
    SELECT * FROM _Meta_Attributes WHERE class = className_in and isId = 1;
END 
$$

DELIMITER ;
DROP PROCEDURE IF EXISTS `GET_SET_VALUES`;
DELIMITER $$

CREATE PROCEDURE `GET_SET_VALUES`( setName_in VARCHAR(1000))
BEGIN
	DECLARE setTableName TEXT; 
	DECLARE setColumnName TEXT; 
    SELECT tableName, columnName  into @setTableName, @setColumnName 
		FROM _Meta_Sets WHERE setName = setName_in;

	SET @SQL_TXT = CONCAT('SELECT ',  @setColumnName, ' from ', @setTableName);
	PREPARE stmt_name FROM @SQL_TXT;
	EXECUTE stmt_name;
	DEALLOCATE PREPARE stmt_name; 
END 
$$

DELIMITER ;
DROP PROCEDURE IF EXISTS `GET_CLASS_VALUES`;
DELIMITER $$

CREATE PROCEDURE `GET_CLASS_VALUES`( className_in VARCHAR(1000), sp_in VARCHAR(1000), this VARCHAR(36))
BEGIN

DECLARE classTableName TEXT; 



DROP TABLE IF EXISTS CLASS_DESCS;
CREATE TEMPORARY TABLE CLASS_DESCS 
  (
    OBJECT_ID VARCHAR(36) PRIMARY KEY,
	DESCRIPTION VARCHAR(1000)
  ) ENGINE = MEMORY; 


	SELECT tableName  into @classTableName 
		FROM _Meta_Classes WHERE className = className_in;

	IF sp_in is not null and this is not null
	THEN
		SET @SQL_TXT = CONCAT('CALL `',sp_in,'`(''',this,''');');
	ELSE
		SET @SQL_TXT = CONCAT('INSERT INTO CLASS_DESCS (OBJECT_ID)  SELECT ',  @classTableName, 'Id from `', @classTableName, '`;');
	END IF;
	PREPARE stmt_name FROM @SQL_TXT;
	EXECUTE stmt_name;
	DEALLOCATE PREPARE stmt_name; 

BEGIN
	DECLARE done INT DEFAULT 0;
	DECLARE OID VARCHAR(36);

	DECLARE object_ids CURSOR for 
		SELECT OBJECT_ID FROM CLASS_DESCS;


	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

	OPEN object_ids;   



	WHILE done = 0 DO
		FETCH NEXT FROM object_ids INTO OID;
		IF done = 0 THEN
			CALL `GET_OBJECT_DESCRIPTION`(className_in, OID, @objDesc);
			UPDATE CLASS_DESCS SET DESCRIPTION = @objDesc WHERE OBJECT_ID = OID;    
		END IF;

	END WHILE;
END;

	SELECT * FROM CLASS_DESCS;
END 
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `GET_OBJECT_ACTUAL_CLASS`;
DELIMITER $$

CREATE PROCEDURE `GET_OBJECT_ACTUAL_CLASS`(IN className_in VARCHAR(1000), IN objectID_in VARCHAR(36), OUT actualClass_out varchar(1000))
BEGIN
	DECLARE ACTUAL_CLASS VARCHAR(36);
	SET @SQL_TXT = CONCAT("SELECT ",className_in,"_className into @ACTUAL_CLASS from ",className_in," where ",className_in,"Id = '",objectID_in,"';");

	PREPARE stmt_name FROM @SQL_TXT;
	EXECUTE stmt_name;
	DEALLOCATE PREPARE stmt_name;	
    SET actualClass_out = @ACTUAL_CLASS;
END 
$$
DELIMITER ;

CREATE TABLE `debug_log` (
    `debug_log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `methodName` varchar(1000) NOT NULL,
    `errcode` varchar(10) NOT NULL,
    `msg` varchar(512) NOT NULL,
    `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`debug_log_id`)
);

DROP PROCEDURE IF EXISTS `log_debug`;
DELIMITER $$

CREATE PROCEDURE `log_debug`(IN lastMethodName VARCHAR(1000), IN lastErrcode VARCHAR(10), IN lastMsg VARCHAR(512))

BEGIN
    INSERT INTO debug_log (methodName, errcode, msg)  VALUES (lastMethodName, lastErrcode, lastMsg);
END$$
DELIMITER ;


drop procedure if exists `validatePassword`;
delimiter $$
create procedure `validatePassword` (un varchar(4000), passwdIn varchar(4000))
begin

select username, UserId from User
			where (select Password(passwdIn)) = passwd and
			(LOWER(username) = LOWER(un) or LOWER(emailAddress) = LOWER(un)) and
			enabled = true;
end $$
delimiter ;

call User_Create(null, 'default', 'administrator','defaultadministrator',database(),database(), 'Administrator', @u_out);