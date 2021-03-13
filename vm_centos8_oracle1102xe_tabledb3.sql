

--
CREATE GLOBAL TEMPORARY TABLE temptbl (
       id     CHAR      (8)
     , uname  NCHAR     (10)
)
;

--
SELECT table_name
     , temporary
  FROM user_tables
 WHERE 1 = 1
;

--
INSERT INTO temptbl VALUES ('Thomas', '토마스') ;
INSERT INTO temptbl VALUES ('James', '제임스') ;

--
SELECT *
  FROM temptbl
 WHERE 1 = 1
;

--
COMMIT ;

--
SELECT *
  FROM temptbl
 WHERE 1 = 1
;