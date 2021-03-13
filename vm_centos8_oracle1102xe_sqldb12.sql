

--
CREATE OR REPLACE PROCEDURE userproc1
(
    pi_userid   IN  usertbl.userid%TYPE
)
AS
    v_uname     VARCHAR (10)    ;
BEGIN
    SELECT 
            username
      INTO  v_uname
      FROM  usertbl
     WHERE  1 = 1
       AND  userid = pi_userid
    ;
    
    DBMS_OUTPUT.PUT_LINE(v_uname) ;
END userproc1
;

--
SET SERVEROUTPUT ON ;

--
EXECUTE userproc1 ('JKW') ;

--
CREATE OR REPLACE PROCEDURE userproc2
(
    pi_byear    IN  usertbl.birthyear%TYPE
  , pi_height   IN  usertbl.height%TYPE
)
AS
    v_uname     VARCHAR(10) ;
BEGIN
    SELECT
            username
      INTO  v_uname
      FROM  usertbl
     WHERE  1 = 1
       AND  birthyear = pi_byear
       AND  height = pi_height
    ;
    
    DBMS_OUTPUT.PUT_LINE(v_uname) ;
END     userproc2
;

--
EXEC userproc2(1971, 177) ;

--
CREATE SEQUENCE userseq ;

--
CREATE TABLE testtbl
(
    userid  INT
  , txt     NCHAR   (10)
)
;

--
CREATE OR REPLACE PROCEDURE userproc3
(
    pi_txtvalue IN  NCHAR
  , po_outvalue OUT NUMBER
)
AS
    v_count     VARCHAR (10) ;
BEGIN
    INSERT INTO testtbl VALUES (userseq.NEXTVAL, pi_txtvalue) ;
    
    SELECT
            MAX(userid)
      INTO  po_outvalue
      FROM  testtbl
     WHERE  1 = 1
    ;
END     userproc3
;

--
DECLARE
    outdata NUMBER  ;
BEGIN
    userproc3('테스트값1', outdata) ;
    DBMS_OUTPUT.PUT_LINE(outdata) ;
END
;

--
SELECT 
        *
  FROM  testtbl
 WHERE  1 = 1
;

--
CREATE OR REPLACE PROCEDURE ifelseproc
(
    pi_username IN  usertbl.username%TYPE
)
AS
    v_byear NUMBER  ;
BEGIN
    SELECT 
            birthyear
      INTO  v_byear
      FROM  usertbl
     WHERE  1 = 1
       AND  username = pi_username
    ;
    
    IF  v_byear >= 1980 THEN
        DBMS_OUTPUT.PUT_LINE('아직은 젊은이시네요ㅋ') ;
    ELSE
        DBMS_OUTPUT.PUT_LINE('나이가 지긋하시네요ㅋ') ;
    END IF
    ;
END     ifelseproc
;

--
EXEC ifelseproc('김경호') ;

--
CREATE OR REPLACE PROCEDURE caseproc
(
    pi_username IN  usertbl.username%TYPE
)
AS
    v_byear     NUMBER      ;
    v_mod       NUMBER      ;
    v_tti       NCHAR(3)    ;
BEGIN
    SELECT 
            birthyear
      INTO  v_byear
      FROM  usertbl
     WHERE  1 = 1
       AND  username = pi_username
    ;
    
    v_mod := MOD(v_byear, 12) 
    ;
    
    CASE
        WHEN (v_mod = 0) THEN
            v_tti := '원숭이'  ;
        WHEN (v_mod = 1) THEN
            v_tti := '닭'  ;
        WHEN (v_mod = 2) THEN
            v_tti := '개'  ;
        WHEN (v_mod = 3) THEN
            v_tti := '돼지'  ;
        WHEN (v_mod = 4) THEN
            v_tti := '쥐'  ;
        WHEN (v_mod = 5) THEN
            v_tti := '소'  ;
        WHEN (v_mod = 6) THEN
            v_tti := '호랑이'  ;
        WHEN (v_mod = 7) THEN
            v_tti := '토끼'  ;
        WHEN (v_mod = 8) THEN
            v_tti := '용'  ;
        WHEN (v_mod = 9) THEN
            v_tti := '뱀'  ;
        WHEN (v_mod = 10) THEN
            v_tti := '말'  ;
        WHEN (v_mod = 11) THEN
            v_tti := '양'  ;
        ELSE
            v_tti := '에러'    ;
    END CASE
    ;
    
    DBMS_OUTPUT.PUT_LINE( pi_username || ' 의 띠 ==> ' || v_tti) ;

END     caseproc
;

--
EXEC caseproc('김경호') ;

--
DROP TABLE gugutbl ;
CREATE TABLE gugutbl
(
    txt VARCHAR (200)
)
;

--
CREATE OR REPLACE PROCEDURE whileproc
AS
    v_str   VARCHAR (200)   ;
    v_i     NUMBER          ;
    v_k     NUMBER          ;
BEGIN
    v_i :=  2   ;
    
    WHILE ( v_i < 10 )  LOOP
        v_str   :=  ''  ;
        v_k     :=  1   ;
        WHILE ( v_k < 10 )   LOOP
            v_str   :=  v_str || ' | ' || v_i || ' X ' || v_k || ' = ' || v_i * v_k   ;
            v_k     :=  v_k + 1 ;
        END LOOP
        ;
        v_i :=  v_i + 1  ;
        INSERT INTO gugutbl VALUES (v_str)  ;
    END LOOP
    ;
END     whileproc
;

--
EXEC whileproc() ;

--
SELECT
        *
  FROM  gugutbl
 WHERE  1 = 1
;

--
CREATE OR REPLACE PROCEDURE returnproc
(
    pi_username IN  usertbl.username%TYPE
  , po_retvalue OUT NVARCHAR2
)
AS
    v_userid    VARCHAR (10)    ;
BEGIN
    SELECT
            userid
      INTO  v_userid
      FROM  usertbl
     WHERE  1 = 1
       AND  username = pi_username
    ;
    
    IF v_userid IS NULL THEN
        po_retvalue :=  '그런 사람 없대유ㅠㅠ' ;
    ELSE
        po_retvalue :=  '회원이시네유 ~'      ;
    END IF
    ;
END     returnproc
;

--
DECLARE
    retvalue    NVARCHAR2   (30)    ;
BEGIN
    returnproc('은지원', retvalue) ;
    DBMS_OUTPUT.PUT_LINE('은지원 ==> ' || retvalue); 
END
;

--
DECLARE
    retvalue    NVARCHAR2   (30)    ;
BEGIN
    returnproc('최세훈', retvalue) ;
    DBMS_OUTPUT.PUT_LINE('최세훈 ==> ' || retvalue); 
END
;

--
CREATE OR REPLACE PROCEDURE errorproc
(
    pi_username IN  usertbl.username%TYPE
  , po_retvalue OUT NVARCHAR2
)
AS
    v_userid    VARCHAR (10)    ;
BEGIN
    SELECT
            userid
      INTO  v_userid
      FROM  usertbl
     WHERE  1 = 1
       AND  username = pi_username
    ;
    
    po_retvalue :=  '회원이시네유 ~'
    ;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            po_retvalue := '그런 사람 없대유ㅠㅠ' ;
END     errorproc
;

--
DECLARE
    retvalue    NVARCHAR2   (30)    ;
BEGIN
    errorproc('은지원', retvalue) ;
    DBMS_OUTPUT.PUT_LINE('은지원 ==> ' || retvalue); 
END
;

--
DECLARE
    retvalue    NVARCHAR2   (30)    ;
BEGIN
    errorproc('최세훈', retvalue) ;
    DBMS_OUTPUT.PUT_LINE('최세훈 ==> ' || retvalue); 
END
;

--
CREATE OR REPLACE PROCEDURE errorproc2
(
    pio_username    IN OUT  usertbl.username%TYPE
)
AS
    v_userid    VARCHAR (10)    ;
BEGIN
    SELECT
            userid
      INTO  v_userid
      FROM  usertbl
     WHERE  1 = 1
       AND  username = pio_username
    ;
    
    pio_username :=  '회원이시네유 ~'
    ;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pio_username := '그런 사람 없대유ㅠㅠ' ;
END     errorproc2
;

--
DECLARE
    retvalue    NVARCHAR2   (30)    ;
BEGIN
    retvalue    :=  '은지원'       ;
    errorproc2(retvalue) ;
    DBMS_OUTPUT.PUT_LINE('은지원 ==> ' || retvalue); 
END
;

--
DECLARE
    retvalue    NVARCHAR2   (30)    ;
BEGIN
    retvalue    :=  '최모씨'       ;
    errorproc2(retvalue) ;
    DBMS_OUTPUT.PUT_LINE('최모씨 ==> ' || retvalue); 
END
;

--
  SELECT
            *
    FROM    user_objects
   WHERE    1 = 1
     AND    object_type = 'PROCEDURE'
ORDER BY
            TIMESTAMP   DESC
;

--
  SELECT
            *
    FROM    user_source
   WHERE    1 = 1
     AND    name = 'USERPROC1'
ORDER BY
            LINE
;

--
CREATE OR REPLACE PROCEDURE encryptproc
(
    pi_userid   IN  usertbl.userid%TYPE
)
AS
    v_username  usertbl.username%TYPE   ;
    v_birthyear usertbl.birthyear%TYPE  ;
BEGIN
    SELECT
            SUBSTR(username, 1, 1) || '00'
          , birthyear
      INTO  v_username
          , v_birthyear
      FROM  usertbl
     WHERE  1 = 1
       AND  userid = pi_userid
    ;
    
    DBMS_OUTPUT.PUT_LINE(pi_userid || '==>' || v_username || '(' || v_birthyear || ')') ;
END     encryptproc
;

--
EXEC encryptproc('JYP') ;

--
  SELECT
            *
    FROM    user_source
   WHERE    1 = 1
     AND    name = 'ENCRYPTPROC'
ORDER BY
            LINE
;

--
DROP PROCEDURE ENCRYPTPROC ;

--
DECLARE
    v_source    VARCHAR2    (32767) ;
BEGIN
    v_source    := 'CREATE OR REPLACE PROCEDURE encryptproc
(
    pi_userid   IN  usertbl.userid%TYPE
)
AS
    v_username  usertbl.username%TYPE   ;
    v_birthyear usertbl.birthyear%TYPE  ;
BEGIN
    SELECT
            SUBSTR(username, 1, 1) || ''00''
          , birthyear
      INTO  v_username
          , v_birthyear
      FROM  usertbl
     WHERE  1 = 1
       AND  userid = pi_userid
    ;
    
    DBMS_OUTPUT.PUT_LINE(pi_userid || ''==>'' || v_username || ''('' || v_birthyear || '')'') ;
END     encryptproc
;'
    ;
--    DBMS_OUTPUT.PUT_LINE(v_source) ;
    EXECUTE IMMEDIATE DBMS_DDL.WRAP(DDL => v_source)    ;
END 
;

--
  SELECT
            *
    FROM    user_source
   WHERE    1 = 1
     AND    name = 'ENCRYPTPROC'
ORDER BY
            LINE
;

-- not available
CREATE OR REPLACE PROCEDURE tableproc
(
    pi_tablename    IN  VARCHAR2
)
AS
    v_count NUMBER  ;
BEGIN
    SELECT
            COUNT(*)
      INTO  v_count
      FROM  pi_tablename
     WHERE  1 = 1
    ;
    
    DBMS_OUTPUT.PUT_LINE(v_count) ;
END
;

--
CREATE OR REPLACE PROCEDURE tableproc
(
    pi_tablename    IN  VARCHAR2
)
AS
    v_count NUMBER              ;
    v_sql   VARCHAR2    (200)   ;
BEGIN
    v_sql   :=  
        'SELECT
        COUNT(*)
  FROM  ' || pi_tablename || chr(10) || ' WHERE  1 = 1'
    ;
    
    DBMS_OUTPUT.PUT_LINE(v_sql)     ;
    
    EXECUTE IMMEDIATE v_sql INTO v_count    ;
    DBMS_OUTPUT.PUT_LINE('RESULT ==> ' || v_count)   ;
END tableproc
;

--
EXEC tableproc('BUYTBL')    ;

--
CREATE OR REPLACE PROCEDURE rowtypeproc
(
    pi_userid   IN  usertbl.userid%TYPE
)
AS
    v_constant      CONSTANT    NCHAR   (3) :=  '-->'   ;
    v_userdata      usertbl%ROWTYPE                     ;
BEGIN
    SELECT
            username
          , addr
          , height
       INTO
            v_userdata.username
          , v_userdata.addr
          , v_userdata.height
      FROM  usertbl
     WHERE  1 = 1
       AND  userid = pi_userid
    ;
    
    DBMS_OUTPUT.PUT_LINE(pi_userid || v_constant || v_userdata.username || ' ' || v_userdata.addr || ' ' || v_userdata.height);
END     rowtypeproc
;

--
EXEC rowtypeproc('SSK') ;

--
CREATE OR REPLACE PROCEDURE recordproc
(
    pi_userid   IN  usertbl.userid%TYPE
)
AS
    v_constant      CONSTANT    NCHAR   (3) :=  '-->'   ;
    TYPE myrecordtype IS 
    RECORD 
    (
        r_username  NVARCHAR2(20)
      , r_addr      NCHAR(2)
      , r_height    NUMBER(3)
    )
    ;
    v_record    myrecordtype    ;
BEGIN
    SELECT
            username
          , addr
          , height
       INTO
            v_record.r_username
          , v_record.r_addr
          , v_record.r_height
      FROM  usertbl
     WHERE  1 = 1
       AND  userid = pi_userid
    ;
    
    DBMS_OUTPUT.PUT_LINE(pi_userid || v_constant || v_record.r_username || ' ' || v_record.r_addr || ' ' || v_record.r_height);
END     recordproc
;

--
EXEC recordproc('LSG') ;

--
CREATE OR REPLACE PROCEDURE collectionproc
AS
    TYPE    myVarrayType    IS  VARRAY(3)   OF  NUMBER      (10)    ;
    TYPE    myNestType      IS  TABLE       OF  NVARCHAR2   (10)    ;
    TYPE    myAssocType     IS  TABLE       OF  NUMBER      (5)     INDEX BY STRING(10) ;
    
    v_varray    myVarrayType            ;
    v_nest      myNestType              ;
    v_assoc     myAssocType             ;
    v_idx       VARCHAR2        (10)    ;
BEGIN
    v_varray    :=  myVarrayType(10, 20, 30)    ;
    v_nest      :=  myNestType('이것이', '오라클', '학습중') ;
    v_assoc('짜장')   :=  4500    ;
    v_assoc('피자')   :=  12000   ;
    v_assoc('치킨')   :=  19000   ;
    
    DBMS_OUTPUT.PUT_LINE('v_varray <-> v_next');
    FOR i IN 1 .. 3 LOOP
        DBMS_OUTPUT.PUT_LINE(v_varray(i) || '  ' || v_nest(i))  ;
    END LOOP
    ;
    
    v_idx   := v_assoc.FIRST    ;
    DBMS_OUTPUT.PUT_LINE('v_assoc');
    WHILE v_idx IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(v_idx || ' ' || v_assoc(v_idx));
        v_idx := v_assoc.NEXT(v_idx) ;
    END LOOP
    ;
    
    DBMS_OUTPUT.PUT_LINE('치킨' || ' ' || v_assoc('치킨'));
END     collectionproc
;

--
EXECUTE collectionproc() ;

