


--
SET SERVEROUTPUT ON;

--
DECLARE
    myvar1  NUMBER(3) ;
    myvar2  NUMBER(5, 2)    :=  3.14 ;
    myvar3  NVARCHAR2(20)   :=  'ÀÌ½Â±â Å° == ' ;
BEGIN
    
    myvar1 := 5 ;

    DBMS_OUTPUT.PUT_LINE(myvar1) ;
    DBMS_OUTPUT.PUT_LINE(myvar1 + myvar2) ;
    
    SELECT height
    INTO myvar1
    FROM usertbl
    WHERE 1 = 1
    AND username = 'ÀÌ½Â±â'
    ;
    
    DBMS_OUTPUT.PUT_LINE(myvar3 || TO_CHAR(myvar1)) ;
END
;


--
SELECT CAST(AVG(amount) AS NUMBER(3, 2))
        AS  "Æò±Õ ±¸¸Å °¹¼ö"
FROM buytbl
WHERE 1 = 1
;

--
SELECT CAST('2019$12$15'    AS  DATE)
        AS  "³¯Â¥CAST1"
     , CAST('1990^05$11'    AS  DATE)
        AS "³¯Â¥CAST2"
FROM DUAL
;

--
SELECT CAST(
            price
            AS  CHAR(5)
        )   ||
        'X' ||
        CAST(
            amount
            AS CHAR(4)
        )   ||
        '='
        AS "´Ü°¡ X ¼ö·®"
     , price * amount
        AS "±¸¸Å¾×"
FROM buytbl
WHERE 1 = 1
;

--
SELECT TO_CHAR(
            12345,
            '$000,999'
        )
        AS  "È­ÆóÇ¥½Ã1"
     , TO_CHAR(
            1345,
            'L9,9,9,9'
        )
        AS  "È­ÆóÇ¥½Ã2"
     , TO_CHAR(
            SYSDATE,
            'YYYY@MM@DD HH24^MM_SS'
        )
        AS  "³¯ÀÚ_¹®ÀÚ¿­"
    
FROM DUAL
;

--
SELECT TO_CHAR(
            16,
            'XX'
        )
        AS  "DGT_16_01"
     , TO_CHAR(
            255,
            'XX'
        )
        AS  "DGT_16_02"
FROM DUAL
;

--
SELECT TO_NUMBER(
            'A',
            'X'
        )
        AS  "TO_DGT_10_01"
     , TO_NUMBER(
            'FF',
            'XX'
        )
        AS  "TO_DGT_10_02"
FROM DUAL
;

--
SELECT TO_NUMBER(
            '12345'
        )
        AS  "¼ýÀÚÇüÀ¸·Î_01"
     , TO_NUMBER(
            '12345.678'
        )
        AS  "¼ýÀÚÇüÀ¸·Î_01"
FROM DUAL
;

--
SELECT TO_CHAR(
            (SELECT price
            FROM buytbl
            WHERE 1 = 1
            AND price >= '500'),
            '999,999'
        )
FROM DUAL
;

--
SELECT '1.004' * '200'    
        AS  "¾Ï¹¬01"
      , CONCAT('104', '201')
        AS  "¾Ï¹¬02"
      , 104 || ' - ' || '201'
        AS  "¾Ï¹¬03"
      , TO_CHAR(
            (
                SELECT price
                FROM buytbl
                WHERE 1 = 1
                AND price >= '500'
            ),
            '999,999'
        )
        AS  "¾Ï¹¬04"
      , 2 * '33'
        AS  "¾Ï¹¬05"
FROM DUAL
;