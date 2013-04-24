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


