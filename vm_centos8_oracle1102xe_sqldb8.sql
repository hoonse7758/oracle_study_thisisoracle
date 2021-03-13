
--
SET SERVEROUTPUT    ON ;

--
DECLARE
    var1    NUMBER(5) ;
BEGIN
    var1 := 100 ;
    
    IF var1 = 100 THEN
        DBMS_OUTPUT.PUT_LINE('var1 == 100') ;
    ELSE
        DBMS_OUTPUT.PUT_LINE('var1 <> 100') ;
    END IF
    ;
END
;

--
DECLARE
    hireDate    DATE            ;   -- 1) hireDate
    curDate     DATE            ;   -- 2) curDate
    wDays       NUMBER(5)       ;   -- 3) wDays
    wYears      NUMBER(5, 3)    ;   -- 4) wYears
BEGIN

    -- 1) hireDate
    SELECT  hire_date
      INTO  hireDate
      FROM  hr.employees
     WHERE  1 = 1
       AND  employee_id = 200       ;
    DBMS_OUTPUT.PUT_LINE('hireDate = ' || hireDate) ;
    
    -- 2) curDate
    curDate :=  CURRENT_DATE()      ;
    DBMS_OUTPUT.PUT_LINE('curDate = ' || curDate) ;
    
    -- 3) wDays, 4) wYears
    wDays   :=  curDate - hireDate  ;
    wYears  := (wDays / 365)        ;
    DBMS_OUTPUT.PUT_LINE('wDays = ' || wDays) ;
    DBMS_OUTPUT.PUT_LINE('wYears = ' || wYears) ;
    
    -- PRINT OUTPUT
    IF  wYears >= 5    THEN
        DBMS_OUTPUT.PUT_LINE('입사하신 지 5년 넘으셨어요 ! ' || wDays || ' 일이나 지났습니다 ^-^')  ;
    ELSE
        DBMS_OUTPUT.PUT_LINE('입사하신 지 ' || wDays || ' 일이 지났습니다 ^-^')  ;
    END IF
    ;

END
;

--
DECLARE
    pNumber     NUMBER(3)   ;
    credit      CHAR(1)     ;
BEGIN
    pNumber     :=  77      ;
    
    IF      pNumber >= 90   THEN
        credit  :=  'A'     ;
    ELSIF   pNumber >= 80   THEN
        credit  :=  'B'     ;
    ELSIF   pNumber >= 70   THEN
        credit  :=  'C'     ;
    ELSIF   pNumber >= 60   THEN
        credit  :=  'D'     ;
    ELSE
        credit  :=  'F'     ;
    END IF 
    ;
    
    DBMS_OUTPUT.PUT_LINE('취득점수 : ' || credit || '(' || pNumber || ')') ;
END
;

--
DECLARE
    pNumber     NUMBER(3)   ;
    credit      CHAR(1)     ;
BEGIN
    pNumber     :=  54      ;
    
    CASE
        WHEN    pNumber >= 90   THEN
            credit  :=  'A' ;
        WHEN    pNumber >= 80   THEN
            credit  :=  'B' ;
        WHEN    pNumber >= 70   THEN
            credit  :=  'C' ;
        WHEN    pNumber >= 60   THEN
            credit  :=  'D' ;
        ELSE
            credit  :=  'F' ;
    END CASE
    ;
    
    DBMS_OUTPUT.PUT_LINE('취득점수 : ' || credit || '(' || pNumber || ')') ;
END
;

--
SELECT userid
     , SUM(price * amount)
        AS user_total
FROM buytbl
WHERE 1 = 1
GROUP BY userid
--ORDER BY SUM(price * amount)    DESC
;

-- my solution
         SELECT t01.username
              , t01.userid
--              , t02.userid
              , NVL(t02.user_total, 0)
                AS  user_total
              , CASE
                    WHEN    t02.user_total  >= 1500
                    THEN    '최우수회원'
                    WHEN    t02.user_total  >= 1000
                    THEN    '우수회원'
                    WHEN    t02.user_total  >=    1
                    THEN    '일반회원'
                    ELSE    '유령회원'
                END 
                AS  user_grade
           FROM usertbl t01
LEFT OUTER JOIN (
                    SELECT  userid
                          , SUM(price * amount)
                            AS user_total
                      FROM  buytbl
                     WHERE  1 = 1
                  GROUP BY  userid
                )       t02
             ON t01.userid = t02.userid
          WHERE 1 = 1
       ORDER BY user_total  DESC
;


--
          SELECT    t01.*
                  , t02.*
--                  , SUM(t01.price * t01.amount)
--                    AS user_total
            FROM    buytbl  t01
RIGHT OUTER JOIN    usertbl t02
              ON    t01.userid = t02.userid
           WHERE    1 = 1
;


-- book's solution
          SELECT    t02.username
                  , t02.userid
                  , SUM(t01.price * t01.amount)
                    AS  user_total
                  , CASE
                        WHEN    SUM(t01.price * t01.amount) >=  1500
                        THEN    '최우수회원'
                        WHEN    SUM(t01.price * t01.amount) >=  1000
                        THEN    '우수회원'
                        WHEN    SUM(t01.price * t01.amount) >=     1
                        THEN    '일반회원'
                        ELSE    '유령회원'
                    END
                    AS  user_grade
            FROM    buytbl  t01
RIGHT OUTER JOIN    usertbl t02
              ON    t01.userid = t02.userid
           WHERE    1 = 1
        GROUP BY    t02.username
                  , t02.userid
        ORDER BY    SUM(t01.price * t01.amount) DESC NULLS LAST
                  , t02.username
;

--
DECLARE
    iNum    NUMBER(3)   ;
    hap     NUMBER(5)   ;
BEGIN

    iNum    :=  1       ;
    hap     :=  0       ;
    WHILE   iNum <= 100
    LOOP
         hap :=   hap + iNum ;
        iNum :=  iNum + 1    ;
    END LOOP
    ;
    
    DBMS_OUTPUT.PUT_LINE('WHILE LOOP / SUM(1~100) == ' || hap) ;

END
;

--
DECLARE
    iNum    NUMBER(3)       ;
    hap     NUMBER(5)       ;
BEGIN

    hap     :=  0           ;
    
    FOR iNum IN 1 .. 100
    LOOP
        hap :=  hap + iNum  ;
    END LOOP
    ;
    
    DBMS_OUTPUT.PUT_LINE('FOR LOOP / SUM(1~100) == ' || hap) ;
    
END
;

-- 
DECLARE
    iNum    NUMBER(3)   ;
    hap     NUMBER(5)   ;
BEGIN

    iNum    :=  1       ;
    hap     :=  0       ;
    WHILE   iNum <= 100
    LOOP
        
        IF  MOD(iNum, 7) = 0    THEN
            iNum :=  iNum + 1   ;
            CONTINUE            ;
        END IF
        ;

        hap :=  hap + iNum      ;
        IF  hap > 1000          THEN
            EXIT ;
        END IF
        ;
         
        iNum :=  iNum + 1    ;
    END LOOP
    ;
    
    DBMS_OUTPUT.PUT_LINE('WHILE LOOP / SUM(1~100) == ' || hap) ;

END
;

--
DECLARE
    iNum    NUMBER(3)   ;
    hap     NUMBER(5)   ;
BEGIN

    iNum    :=  1       ;
    hap     :=  0       ;
    WHILE   iNum <= 100
    LOOP
        
        IF  MOD(iNum, 7) = 0    THEN
            iNum :=  iNum + 1   ;
            CONTINUE            ;
        END IF
        ;

        hap :=  hap + iNum      ;
        IF  hap > 1000          THEN
            EXIT ;
        END IF
        ;
         
        iNum :=  iNum + 1    ;
    END LOOP
    ;
    
    DBMS_OUTPUT.PUT_LINE('WHILE LOOP / SUM(1~100) == ' || hap) ;

END
;

DECLARE
    iNum    NUMBER(4)   ;
    is_3    CHAR(5)     ;
    is_8    CHAR(5)     ;
    hap     NUMBER(10)  ;
BEGIN

    iNum    :=  0       ;
    hap     :=  0       ;
    WHILE   iNum <= 1000
    LOOP
        iNum    :=  iNum + 1            ;
        
        SELECT  CASE
                    WHEN    MOD(iNum, 3) = 0 
                    THEN    ' TRUE'
                    ELSE    'FALSE'
                END
                AS boolstring
        INTO    is_3
        FROM    DUAL
        ;
        SELECT  CASE
                    WHEN    MOD(iNum, 8) = 0 
                    THEN    ' TRUE'
                    ELSE    'FALSE'
                END
                AS boolstring
        INTO    is_8
        FROM    DUAL
        ;
--        is_3    :=  MOD(iNum, 3) = 0    ;
--        is_8    :=  MOD(iNum, 8) = 0    ;
        
        IF  NOT
            ( 
                   is_3 = ' TRUE'
                OR is_8 = ' TRUE'
            ) 
        THEN 
            CONTINUE ;
        END IF
        ;
        
        hap :=  hap + iNum      ;
        
        DBMS_OUTPUT.PUT_LINE('is_3 == ' || is_3 || ' / is_8 == ' || is_8 || ' / iNum == ' || iNum || ' / hap == ' || hap) ;
--        DBMS_OUTPUT.PUT_LINE('is_3 == ' || is_3 || ' / is_8 == ' || is_8 || ' / iNum == ' || iNum || ' / hap == ' || hap) ;
    END LOOP
    ;
    
    DBMS_OUTPUT.PUT_LINE('WHILE LOOP / SUM(1~100) == ' || hap) ;

END
;

--
DECLARE
    iNum    NUMBER(1)   ;
BEGIN
    FOR iNum    IN  1 .. 5
    LOOP
        DBMS_OUTPUT.PUT_LINE('SLEEPING 1 SECOND ...') ;
        DBMS_LOCK.SLEEP(1) ;
    END LOOP
    ;
    DBMS_OUTPUT.PUT_LINE('END PROCEDURE') ;
END
;


--
SELECT  username
  FROM  usertbl
 WHERE  1 = 1
   AND  username LIKE '김%'
;

--
DECLARE

    v_username  usertbl.username%TYPE   ;
    
BEGIN

    SELECT  username
      INTO  v_username
      FROM  usertbl
     WHERE  1 = 1
       AND  username LIKE '김%'
    ;
    
    DBMS_OUTPUT.PUT_LINE('김씨 고객의 이름은 ' || v_username || ' 입니다.') ;
    EXCEPTION
         WHEN   NO_DATA_FOUND
         THEN   DBMS_OUTPUT.PUT_LINE('김씨 고객이 없습니다.') ;
         WHEN   TOO_MANY_ROWS
         THEN   DBMS_OUTPUT.PUT_LINE('김씨 고객이 2명 이상입니다.') ;
         WHEN   OTHERS
         THEN   DBMS_OUTPUT.PUT_LINE('결과 조회 중 예기치 못한 에러를 만났습니다.') ;
END
;

--
DECLARE

    v_username  usertbl.username%TYPE               ;
    
    userexcptn  EXCEPTION                           ;
    PRAGMA      EXCEPTION_INIT( userexcptn, -1422 ) ;

BEGIN

    SELECT  username
      INTO  v_username
      FROM  usertbl
     WHERE  1 = 1
       AND  username LIKE '김%'
    ;
    
    DBMS_OUTPUT.PUT_LINE('김씨 고객의 이름은 ' || v_username || ' 입니다.') ;
    EXCEPTION
         WHEN   NO_DATA_FOUND
         THEN   DBMS_OUTPUT.PUT_LINE('김씨 고객이 없습니다.') ;
         WHEN   userexcptn
         THEN   DBMS_OUTPUT.PUT_LINE('김씨 고객이 2명 이상입니다.') ;
         WHEN   OTHERS
         THEN   DBMS_OUTPUT.PUT_LINE('결과 조회 중 예기치 못한 에러를 만났습니다.') ;

END
;


--
DECLARE

    v_username  usertbl.username%TYPE   ;

    -- User-defined Exceptions
    zeroDelete  EXCEPTION               ;

BEGIN
    v_username  :=  '무명씨'   ;
    
    DELETE
      FROM  usertbl
     WHERE  1 = 1
       AND  username = v_username
    ;
    
--    DBMS_OUTPUT.PUT_LINE(SQL%NOTFOUND) ;    -- 'SQL%NOTFOUND = ' || 
    IF  SQL%NOTFOUND
    THEN
        RAISE   zeroDelete  ;
    END IF
    ;
    
    EXCEPTION
         WHEN   zeroDelete
         THEN   DBMS_OUTPUT.PUT_LINE('"' || v_username || '" 님의 데이터가 없는데 지우라구요... 확인먼저 하세요.') ;
         WHEN   OTHERS
         THEN   DBMS_OUTPUT.PUT_LINE('결과 조회 중 예기치 못한 에러를 만났습니다.') ;
END
;

--
DECLARE
    v_username  usertbl.username%TYPE   ;
BEGIN
    v_username  :=  '무명씨'   ;
    
    DELETE
      FROM  usertbl
     WHERE  1 = 1
       AND  username = v_username
    ;
    
    IF  SQL%NOTFOUND
    THEN
        RAISE_APPLICATION_ERROR( -20001, '존재하지 않는 행을 삭제하려는 시도입니다.') ;
    END IF
    ;
END
;

--
DECLARE
    v_username  usertbl.username%TYPE   ;
BEGIN
    v_username  :=  '무명씨'   ;
    
    DELETE
      FROM  usertbl
     WHERE  1 = 1
       AND  username = v_username
    ;
    
    IF  SQL%NOTFOUND
    THEN
        RAISE_APPLICATION_ERROR( -20001, '존재하지 않는 행을 삭제하려는 시도입니다.') ;
    END IF
    ;
END
;

--
SELECT  height
  FROM  usertbl
 WHERE  1 = 1
   AND  userid = 'EJW'
;

--
DECLARE
    v_sql       VARCHAR2(100)       ;
    v_height    usertbl.height%TYPE ;
BEGIN
    v_sql   :=  'SELECT height FROM usertbl WHERE userid = ''EJW'' ' ;
--    v_sql   :=  '
--        SELECT  height
--          FROM  usertbl
--         WHERE  1 = 1
--           AND  userid = ''EJW''
--    '
--    ;
    
    EXECUTE 
    IMMEDIATE   v_sql
    INTO        v_height
    ;
    
    DBMS_OUTPUT.PUT_LINE(v_height) ;
END
;

--
DECLARE

    v_year      CHAR(4)             ;
    v_month     CHAR(2)             ;
    v_day       CHAR(2)             ;
    
    v_tblnm     VARCHAR2(50)        ;
    v_ddl       VARCHAR2(200)       ;
    
--    v_height    usertbl.height%TYPE ;

BEGIN

    v_year  :=  EXTRACT( YEAR FROM SYSDATE) ;
    v_month :=  EXTRACT(MONTH FROM SYSDATE) ;
    v_day   :=  EXTRACT(  DAY FROM SYSDATE) ;
    
    v_tblnm :=  'mytbl_' || v_year || '_' || TRIM(LPAD(v_month, 3, '0')) || '_' || TRIM(LPAD(v_day, 3, '0')) ;
    DBMS_OUTPUT.PUT_LINE(v_tblnm)   ;
    
    
    v_ddl   :=  'CREATE TABLE ' || v_tblnm || '(idnum NUMBER(5), username NVARCHAR2(10))' ;
    DBMS_OUTPUT.PUT_LINE(v_ddl)     ;
    
    EXECUTE
    IMMEDIATE   v_ddl
    ;
    
    DBMS_OUTPUT.PUT_LINE('테이블 생성되었습니다 >> ' || v_tblnm) ;

END
;