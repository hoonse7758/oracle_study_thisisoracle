
--
CREATE TABLE testtbl1 (
    id          NUMBER(4),
    username    NCHAR(3),
    age         NUMBER(2)
)
;

--
INSERT INTO testtbl1 VALUES(1, '홍길동', 25);

--
INSERT INTO testtbl1 (id, username) VALUES(2, '설현');

--
INSERT INTO testtbl1 (username, age, id) VALUES ('지민', 26, 3);


--
CREATE TABLE testtbl2 (
    id          NUMBER(4),
    username    NCHAR(3),
    age         NUMBER(2),
    nation      NCHAR(4)    DEFAULT '대한민국'
)
;

--
-- DROP SEQUENCE idseq ;
CREATE SEQUENCE idseq
    START WITH 1
    INCREMENT BY 1
;

-- 
INSERT INTO testtbl2 VALUES (idseq.NEXTVAL, '유나', 25, DEFAULT);
INSERT INTO testtbl2 VALUES (idseq.NEXTVAL, '혜정', 24, '대영제국');
INSERT INTO testtbl2 VALUES (11, '쯔위', 18, '타이완');
INSERT INTO testtbl2 VALUES (idseq.NEXTVAL, '루니', 38, '대영제국');
INSERT INTO testtbl2 VALUES (5, '하나땅', 26, '일본');
INSERT INTO testtbl2 VALUES (idseq.NEXTVAL, '세훈', 38, '대한민국');

--
SELECT *
FROM testtbl2
WHERE 1 = 1
;

--
ALTER SEQUENCE idseq
    INCREMENT BY 10
;

--
INSERT INTO testtbl2 VALUES (idseq.NEXTVAL, '미나', 21, '일본');

--
ALTER SEQUENCE idseq
    INCREMENT BY 1
;

--
INSERT INTO testtbl2 VALUES (idseq.NEXTVAL, '우올레', 21, '하와이');

--
SELECT idseq.CURRVAL
FROM DUAL
WHERE 1 = 1
;

--
CREATE TABLE testtbl3 (
    id  NUMBER(3)
)
;

--
CREATE SEQUENCE cycleseq
    START       WITH    100
    INCREMENT   BY      100
    MINVALUE    100
    MAXVALUE    300
    CYCLE
    NOCACHE
;

--
INSERT INTO testtbl3 VALUES (cycleseq.NEXTVAL);
INSERT INTO testtbl3 VALUES (cycleseq.NEXTVAL);
INSERT INTO testtbl3 VALUES (cycleseq.NEXTVAL);
INSERT INTO testtbl3 VALUES (cycleseq.NEXTVAL);

--
SELECT *
FROM testtbl3
WHERE  1 = 1
;



--
DROP TABLE testtbl4;
CREATE TABLE testtbl4 (
    empid       NUMBER(6),
    firstname   VARCHAR2(20),
    lastname    VARCHAR2(25),
    phone        VARCHAR2(20)
)
;

--
INSERT INTO testtbl4
(
    SELECT employee_id
         , first_name
         , last_name
         , phone_number
    FROM HR.employees
    WHERE 1 = 1
)
;

--
SELECT *
FROM testtbl4
WHERE 1 = 1
;

--
CREATE TABLE testtbl5 AS (
    SELECT employee_id
         , first_name
         , last_name
         , phone_number
    FROM HR.employees
    WHERE 1 = 1
)
;

--
SELECT *
FROM testtbl5
WHERE 1 = 1
;

--
COMMIT;
ROLLBACK ;

--
SELECT *
FROM testtbl4
WHERE 1 = 1
AND firstname = 'David'
;

--
UPDATE testtbl4
SET phone = '없음'
WHERE 1 = 1
AND firstname = 'David'
;

--
SELECT *
FROM buytbl
WHERE 1 = 1
;

--
UPDATE buytbl
SET PRICE = PRICE * 1.5
;

--
SELECT *
FROM testtbl4
WHERE 1 = 1
AND firstname = 'Peter'
;

--
DELETE 
FROM testtbl4 
WHERE 1 = 1
AND firstname = 'Peter'
;

--
SELECT *
FROM testtbl4
WHERE 1 = 1
AND firstname = 'Peter'
AND ROWNUM <= 2
;

--
DELETE 
FROM testtbl4 
WHERE 1 = 1
AND firstname = 'Peter'
AND ROWNUM <= 2
;

-- understanding DBMS_RANDOM.VALUE(from_num, to_num)
SELECT numdata
     , COUNT(*) AS cnt
FROM (
    SELECT level
                AS bigid
             , ROUND(DBMS_RANDOM.VALUE(1, 500000), 0)
                AS numdata
    FROM DUAL
    WHERE 1 = 1
    CONNECT BY level <= 500000
)
WHERE 1 = 1
GROUP BY numdata
HAVING 1 = 1
AND COUNT(*) > 1
ORDER BY cnt    DESC
;

--
CREATE TABLE bigtbl1 AS (
    SELECT level
            AS bigid
         , ROUND(DBMS_RANDOM.VALUE(1, 500000), 0)
            AS numdata
    FROM DUAL
    WHERE 1 = 1
    CONNECT BY level <= 500000
)
;

--
CREATE TABLE bigtbl2 AS (
    SELECT level
            AS bigid
         , ROUND(DBMS_RANDOM.VALUE(1, 500000), 0)
            AS numdata
    FROM DUAL
    WHERE 1 = 1
    CONNECT BY level <= 500000
)
;

--
CREATE TABLE bigtbl3 AS (
    SELECT level
            AS bigid
         , ROUND(DBMS_RANDOM.VALUE(1, 500000), 0)
            AS numdata
    FROM DUAL
    WHERE 1 = 1
    CONNECT BY level <= 500000
)
;

--
SELECT COUNT(*)
FROM bigtbl1
WHERE 1 = 1
;

--
DELETE 
FROM bigtbl1 
WHERE 1 = 1
;

--
DROP TABLE bigtbl2;

--
TRUNCATE TABLE bigtbl3;

--
SELECT COUNT(*)
FROM bigtbl3
WHERE 1 = 1
;

--
CREATE TABLE membertbl AS (
    SELECT userid
         , username
         , addr
    FROM usertbl
    WHERE 1 = 1
)
;

--
SELECT *
FROM membertbl
WHERE 1 = 1
;

--
CREATE TABLE changetbl (
    userid      CHAR(8),
    username    NVARCHAR2(10),
    addr        NCHAR(2),
    changetype  NCHAR(4)
)
;

--
INSERT INTO changetbl VALUES ('TKV', '태권브이', '한국', '신규가입');
INSERT INTO changetbl VALUES ('LSG', NULL, '제주', '주소변경');
INSERT INTO changetbl VALUES ('LJB', NULL, '영국', '주소변경');
INSERT INTO changetbl VALUES ('BBK', NULL, '탈퇴', '회원탈퇴');
INSERT INTO changetbl VALUES ('SSK', NULL, '탈퇴', '회원탈퇴');

--
SELECT *
FROM changetbl
WHERE 1 = 1
;

--
SELECT *
FROM membertbl
WHERE 1 = 1
;

--
MERGE 
    INTO membertbl    tbl_tgt
    USING (
        SELECT changetype
             , userid
             , username
             , addr
        FROM changetbl
        WHERE 1 = 1
    ) tbl_src
    ON (
        tbl_tgt.userid = tbl_src.userid
    )
    WHEN MATCHED THEN
        -- 일단 업데이트
        UPDATE SET tbl_tgt.addr = tbl_src.addr
        -- 사유가 회원탈퇴일 경우 삭제됨
        DELETE WHERE tbl_src.changetype = '회원탈퇴'
    WHEN NOT MATCHED THEN
        INSERT (userid, username, addr) 
        VALUES (tbl_src.userid, tbl_src.username, tbl_src.addr)
;

