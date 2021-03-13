

--
CREATE OR REPLACE FUNCTION userfunc 
(
    value1  INT
  , value2  INT
)
    RETURN  NUMBER
AS
BEGIN
    RETURN  value1 + value2 ;
END
;

--
SELECT
        userfunc(100, 200)
  FROM  DUAL
;

--
SET SERVEROUTPUT ON ;

--
DECLARE
    retval  NUMBER  ;
BEGIN
    retval := userfunc(100, 200)    ;
    DBMS_OUTPUT.PUT_LINE(retval) ;
END
;

--
VAR     retval  NUMBER  ;
EXECUTE :retval :=  userfunc(300, 400)  ;
PRINT   retval          ;

--
CREATE OR REPLACE FUNCTION getagefunc
(
    byear   NUMBER
)
    RETURN  NUMBER
AS
    v_age   NUMBER  ;
BEGIN
    v_age   :=  EXTRACT(YEAR FROM SYSDATE)  -   byear   ;
    RETURN  v_age   ;
END     getagefunc
;

--
SELECT
        getagefunc(1990)
  FROM  DUAL
;

--
VAR     retval  NUMBER  ;
EXECUTE :retval :=  getagefunc(1990)    ;
PRINT   retval          ;

--
SELECT
        userid
      , username
      , birthyear
      , getagefunc(birthyear)
        AS  age
  FROM  usertbl
 WHERE  1 = 1
;

--
CREATE OR REPLACE FUNCTION blindfunc
(
    ustring NCHAR
)
    RETURN  NCHAR
AS
    vstring NCHAR(20)   :=  ''  ;
BEGIN
    IF ustring = '-' THEN
        RETURN  vstring    ;
    END IF
    ;
    
    IF SUBSTR(ustring, 1, 1) = '0' THEN
        vstring    :=  CONCAT(SUBSTR(ustring, 1, 8), '-XXXX');
    ELSE
        vstring    :=  CONCAT(SUBSTR(ustring, 1, 1), '00');
    END IF
    ;
    
    RETURN  vstring    ;
END     blindfunc
;

--
SELECT
        username
      , mobile1
      , mobile2
      , blindfunc(mobile1 || '-' || mobile2)
        AS "연락처"
  FROM  usertbl
 WHERE  1 = 1
;

--
CREATE OR REPLACE TYPE  tablerowtype
                  AS OBJECT
                  (
                        uname   NCHAR(5)
                      , byear   NUMBER
                  )
;

--
CREATE OR REPLACE TYPE  tabletype
                  AS TABLE OF tablerowtype
;

--
CREATE OR REPLACE FUNCTION tablereturnfunc
(
    namestring  NVARCHAR2
  , birthstring NVARCHAR2
)
    RETURN  tabletype
    PIPELINED
AS
    v_namestring    NVARCHAR2   (500)   :=  namestring  ;
    v_birthstring   NVARCHAR2   (500)   :=  birthstring ;
    v_rowtype       tablerowtype                        ;
    v_nameidx       NUMBER                              ;
    v_birthidx      NUMBER                              ;
    v_name          NCHAR       (5)                     ;
    v_birth         NUMBER                              ;
BEGIN
    LOOP
        v_nameidx   :=  INSTR(v_namestring, ',')    ;
        v_birthidx  :=  INSTR(v_birthstring, ',')   ;
        
        IF  1 = 1 
        AND v_nameidx > 0
        AND v_birthidx > 0 
        THEN
            v_name      :=  SUBSTR(v_namestring, 1, v_nameidx - 1)  ;
            v_birth     :=  TO_NUMBER(SUBSTR(v_birthstring, 1, v_birthidx - 1))   ;
            v_rowtype   :=  tablerowtype(v_name, v_birth)   ;
            PIPE ROW(v_rowtype) ;
            
            v_namestring    :=  SUBSTR(v_namestring, v_nameidx + 1)     ;
            v_birthstring   :=  SUBSTR(v_birthstring, v_birthidx + 1)   ;
        ELSE
            v_rowtype   :=  tablerowtype(v_namestring, v_birthstring)   ;
            PIPE ROW(v_rowtype) ;
            EXIT    ;
        END IF
        ;
            
    END LOOP
    ;
    
    RETURN  ;
END     tablereturnfunc
;

--
SELECT  
        *
  FROM  TABLE
        (
            tablereturnfunc
            (
                '토마스,제임스,고든,에밀리'
              , '1990,1995,1993,1999'
            )
        )
 WHERE  1 = 1
;

-- 나중에 뭔가 방법이 있으려나...
CREATE OR REPLACE FUNCTION tablereturnfunc2
(
    namestring  NVARCHAR2
  , birthstring NVARCHAR2
)
    RETURN      tabletype2                
    PIPELINED
AS
    TYPE  tablerowtype2 IS  RECORD
                            (
                                uname   NCHAR(5)
                              , byear   NUMBER
                            )                           ;
    TYPE  tabletype2    IS  TABLE 
                            OF    tablerowtype2         ;
    v_namestring    NVARCHAR2   (500)   :=  namestring  ;
    v_birthstring   NVARCHAR2   (500)   :=  birthstring ;
    v_rowtype       tablerowtype2                       ;
    v_nameidx       NUMBER                              ;
    v_birthidx      NUMBER                              ;
    v_name          NCHAR       (5)                     ;
    v_birth         NUMBER                              ;
BEGIN
    LOOP
        v_nameidx   :=  INSTR(v_namestring, ',')    ;
        v_birthidx  :=  INSTR(v_birthstring, ',')   ;
        
        IF  1 = 1 
        AND v_nameidx > 0
        AND v_birthidx > 0 
        THEN
            v_name      :=  SUBSTR(v_namestring, 1, v_nameidx - 1)  ;
            v_birth     :=  TO_NUMBER(SUBSTR(v_birthstring, 1, v_birthidx - 1))   ;
            v_rowtype   :=  tablerowtype2(v_name, v_birth)  ;
            PIPE ROW(v_rowtype) ;
            
            v_namestring    :=  SUBSTR(v_namestring, v_nameidx + 1)     ;
            v_birthstring   :=  SUBSTR(v_birthstring, v_birthidx + 1)   ;
        ELSE
            v_rowtype   :=  tablerowtype2(v_namestring, v_birthstring)  ;
            PIPE ROW(v_rowtype) ;
            EXIT    ;
        END IF
        ;
            
    END LOOP
    ;
    
    RETURN  ;
END     tablereturnfunc2
;