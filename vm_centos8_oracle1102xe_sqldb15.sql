

--
  SELECT
            *
    FROM    all_objects
   WHERE    1 = 1
     AND    object_type = 'PACKAGE'
ORDER BY
            owner
          , object_name
;

--
  SELECT
            *
    FROM    all_procedures
   WHERE    1 = 1
     AND    object_name = 'DBMS_OUTPUT'
--ORDER BY
--            owner
--          , object_name
;

--
  SELECT
            *
    FROM    all_source
   WHERE    1 = 1
     AND    owner = 'SYS'
     AND    name = 'DBMS_OUTPUT'
ORDER BY
            OWNER
          , NAME
          , TYPE
          , LINE
;

--
CREATE OR REPLACE PACKAGE totalpackage
AS
    v_age       NUMBER      ;
    v_byear     NUMBER      ;
    
    PROCEDURE   sampleproc
                (
                        pi_username IN  NCHAR
                )
    ;
    
    FUNCTION    samplefunc
                (
                        byear           NCHAR
                )
                RETURN  NUMBER
    ;
END totalpackage
;

--
SET SERVEROUTPUT ON ;

--
CREATE OR REPLACE PACKAGE BODY totalpackage
AS
        PROCEDURE   sampleproc
                    (
                        pi_username IN  NCHAR
                    )
                    AS
                    BEGIN
                        SELECT
                                birthyear
                          INTO  v_byear
                          FROM  usertbl
                         WHERE  1 = 1
                          AND   username = pi_username
                        ;
                        
                        DBMS_OUTPUT.PUT_LINE(v_byear)
--                        DBMS_OUTPUT.PUT_LINE('³ªÀÌ --> ' || samplefunc(v_byear))
                        ;
                    END sampleproc
        ;
        
        FUNCTION    samplefunc
                    (
                        byear       IN  NCHAR
                    )
                        RETURN  NUMBER
                    AS
                    BEGIN
                        v_age   :=  EXTRACT(YEAR FROM SYSDATE)  -   byear   ;
                        RETURN  v_age   ;
                    END samplefunc
        ;
END     totalpackage
;


--
EXECUTE totalpackage.sampleproc('±èº´¸¸')  ;

--
SELECT  
        birthyear
      , totalpackage.samplefunc(birthyear)
  FROM  usertbl
 WHERE  1 = 1
   AND  username = 'ÀÌ½Â±â'
;

--
SELECT
        totalpackage.samplefunc(1990)
        AS AGE
  FROM  DUAL
;
