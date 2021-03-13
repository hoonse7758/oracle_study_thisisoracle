
--
SELECT *
  FROM temptbl
 WHERE 1 = 1
;

--
CREATE GLOBAL TEMPORARY TABLE temptbl2
(
       id     CHAR      (8)
     , uname  NCHAR     (10)
)      ON COMMIT PRESERVE ROWS
;

--
DROP TABLE temptbl2 ;

--
INSERT INTO temptbl2 VALUES ('Arthur', '아서') ;
INSERT INTO temptbl2 VALUES ('Murdoch', '머독') ;

--
COMMIT ;

--
SELECT *
  FROM temptbl2
 WHERE 1 = 1
;

--
DROP TABLE temptbl ;
DROP TABLE temptbl2 ;

--
