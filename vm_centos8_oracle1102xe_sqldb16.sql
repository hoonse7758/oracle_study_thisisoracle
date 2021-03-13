
--
SET SERVEROUTPUT ON ;


--
DROP TABLE testtbl
;

--
CREATE TABLE testtbl
(
    id  NUMBER
  , txt NVARCHAR2   (5)
)
;

--
INSERT INTO testtbl VALUES(1, '원더걸스')   ;
INSERT INTO testtbl VALUES(2, '블랙핑크')   ;
INSERT INTO testtbl VALUES(3, '구구단')    ;

--
SELECT
        *
  FROM  testtbl
 WHERE  1 = 1
;

--
CREATE OR REPLACE TRIGGER   testtrg
                  AFTER DELETE OR UPDATE
                  ON        testtbl
                  FOR EACH ROW
                  BEGIN
                        DBMS_OUTPUT.PUT_LINE('트리거 testtrg 작동하였습니다.')    ;
                  END
;

--
BEGIN
    INSERT INTO testtbl VALUES (4, '나인뮤지스') ;
END
;

--
BEGIN
    UPDATE  testtbl
       SET  
            txt = '에이핑크'
     WHERE  1 = 1
       AND  id = 3
    ;
END
;

--
BEGIN
    DELETE  testtbl
     WHERE  1 = 1
       AND  id = 4
    ;
END
;

--
DROP TABLE backup_usertbl
;

--
CREATE TABLE backup_usertbl
(
    userid      CHAR        (8)     NOT NULL    PRIMARY KEY
  , username    NVARCHAR2   (10)    NOT NULL
  , birthyear   NUMBER      (4)     NOT NULL
  , addr        NCHAR       (2)     NOT NULL
  , mobile1     CHAR        (3)
  , mobile2     CHAR        (8)
  , height      NUMBER      (3)
  , mdate       DATE
  , grade       NVARCHAR2   (5)
  , modtype     NCHAR       (2)
  , moddate     DATE
  , moduser     NVARCHAR2   (256)
)
;

--
SELECT
        *
  FROM  usertbl
 WHERE  1 = 1
;

--
CREATE OR REPLACE TRIGGER trg_backup_usertbl
    AFTER   UPDATE OR DELETE
       ON   usertbl
    FOR EACH ROW
DECLARE
    v_modtype   NCHAR   (2) ;
BEGIN
    IF      UPDATING    THEN
            v_modtype   :=  '수정'    ;
    ELSIF   DELETING    THEN
            v_modtype   :=  '삭제'    ;
    END IF
    ;
    
    INSERT  INTO backup_usertbl 
            VALUES
            (
                :OLD.userid
              , :OLD.username
              , :OLD.birthyear
              , :OLD.addr
              , :OLD.mobile1
              , :OLD.mobile2
              , :OLD.height
              , :OLD.mdate
              , :OLD.grade
              , v_modtype
              , SYSDATE()
              , USER()
            )
    ;
END     trg_backup_usertbl
;

--
SELECT
        *
  FROM  usertbl
 WHERE  1 = 1
   AND  height >= 177
;

----
--BEGIN
--    INSERT INTO usertbl VALUES (4, '나인뮤지스') ;
--END
--;

--
BEGIN
    UPDATE  usertbl
       SET  
            addr = '몽고'
     WHERE  1 = 1
       AND  userid = 'JKW'
    ;
END
;

--
SELECT
        *
  FROM  backup_usertbl
 WHERE  1 = 1
;

--
BEGIN
    DELETE  usertbl
     WHERE  1 = 1
       AND  height >= 177
    ;
END
;

--
DROP TRIGGER trg_backup_usertbl ;

--
CREATE OR REPLACE TRIGGER trg_insert_usertbl
    AFTER INSERT
    ON usertbl
    FOR EACH ROW
BEGIN
        DBMS_OUTPUT.PUT_LINE('USERTBL 테이블에 데이터 입력 시도가 감지되었습니다.')    ;
        DBMS_OUTPUT.PUT_LINE('데이터 입력 시도가 서버에 기록됩니다.')                 ;
        DBMS_OUTPUT.PUT_LINE('입력이 불가한 테이블입니다.')                          ;
        RAISE_APPLICATION_ERROR(-20999, '입력 시도 감지, INSERT 시도를 롤백합니다.')  ;
END     trg_insert_usertbl
;

CREATE OR REPLACE TRIGGER trg_insert_usertbl
    AFTER INSERT
    ON usertbl
    FOR EACH ROW
BEGIN
        DBMS_OUTPUT.PUT_LINE('USERTBL 테이블에 데이터 입력 시도가 감지되었습니다.')    ;
        DBMS_OUTPUT.PUT_LINE('데이터 입력 시도가 서버에 기록됩니다.')                 ;
        DBMS_OUTPUT.PUT_LINE('입력이 불가한 테이블입니다.')                          ;
        RAISE_APPLICATION_ERROR(-20999, '입력 시도 감지, INSERT 시도를 롤백합니다.')  ;
END     trg_insert_usertbl
;

--
SELECT
        *
  FROM  usertbl
 WHERE  1 = 1
;

--
BEGIN
    INSERT INTO usertbl VALUES ('ABC', '에비씨', 1977, '서울', '011', '11111111', 181, '2019-12-25', NULL) ;
END
;

--
DROP TRIGGER trg_insert_usertbl ;

--
CREATE OR REPLACE TRIGGER trg_change_usertbl
    BEFORE INSERT
    ON usertbl
    FOR EACH ROW
BEGIN
    :NEW.username   :=  SUBSTR(:NEW.username, 1, 1) || 'XX'    ;
    :NEW.birthyear  :=  :NEW.birthyear + 2333   ;
END
;

--
SELECT
        *
  FROM  usertbl
 WHERE  1 = 1
;

--
INSERT INTO usertbl VALUES ('ABC', '에비씨', 1977, '서울', '011', '11111111', 181, '2019-12-25', NULL) ;

--
CREATE OR REPLACE TRIGGER trg_column_change
    AFTER UPDATE OF username
    ON usertbl
    FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20888, '이름은 변경하실 수 없습니다 !')    ;
END
;

--
UPDATE  usertbl
   SET  
        addr = '우주'
 WHERE  1 = 1
   AND  userid = 'ABC'
;

--
SELECT
        *
  FROM  usertbl
 WHERE  1 = 1
;

--
UPDATE  usertbl
   SET  
        username = '무명씨'
 WHERE  1 = 1
   AND  userid = 'ABC'
;

--
CREATE OR REPLACE TRIGGER trg_change_usertbl
    BEFORE INSERT
    ON usertbl
    FOR EACH ROW
BEGIN
    :NEW.username   :=  SUBSTR(:NEW.username, 1, 1) || 'XX'    ;
    
    IF :NEW.birthyear < 1900 THEN
        :NEW.birthyear  :=  0   ;
    ELSE
        :NEW.birthyear  :=  :NEW.birthyear + 2333   ;
    END IF
    ;
END
;

--
SELECT
        *
  FROM  usertbl
 WHERE  1 = 1
;

--
INSERT INTO usertbl VALUES ('DEF', '디에프', 1994, '영국', '010', '11111111', 193, '2011-12-25', NULL) ;
INSERT INTO usertbl VALUES ('XYZ', '엑솨제', 1895, '미국', '019', '11131111', 213, '2001-12-5', NULL) ;

--
CREATE VIEW v_deliver
AS
(
        SELECT
                t00.userid
              , t01.username
              , t00.prodname
              , t00.price
              , t00.amount
              , t01.addr
          FROM  buytbl  t00
    INNER JOIN  usertbl t01
            ON  t00.userid = t01.userid
)
;

--
SELECT
        *
  FROM  v_deliver
 WHERE  1 = 1
;

--
INSERT INTO v_deliver VALUES ('SDY', '신동엽', '구두', 50, 1, '인천')  ;

--
CREATE OR REPLACE TRIGGER trg_view_insert
    INSTEAD OF INSERT
    ON v_deliver
    FOR EACH ROW
BEGIN
        INSERT 
            INTO usertbl
            (
                userid
              , username
              , birthyear
              , addr
              , mdate
            )
            VALUES
            (
                :NEW.userid
              , :NEW.username
              , 0
              , :NEW.addr
              , SYSDATE
            )
        ;
        
        INSERT 
            INTO buytbl  
            (
                idnum
              , userid
              , prodname
              , price
              , amount
            )
            VALUES
            (
                idseq.NEXTVAL
              , :NEW.userid
              , :NEW.prodname
              , :NEW.price
              , :NEW.amount
            )
        ;
END     trg_view_insert
;

--
INSERT INTO v_deliver VALUES ('SDY', '신동엽', '구두', 50, 1, '인천')  ;

--
SELECT
        *
  FROM  usertbl
 WHERE  1 = 1
;

--
SELECT
        *
  FROM  buytbl
 WHERE  1 = 1
;

--
SELECT
        *
  FROM  user_triggers
 WHERE  1 = 1
;

--
  SELECT
            *
    FROM    user_source
   WHERE    1 = 1
     AND    name = UPPER('trg_view_insert')
ORDER BY
            name
          , type
          , line
;

--
