

--
CREATE SEQUENCE orderseq
;

--
CREATE SEQUENCE deliverseq
;

--
CREATE  TABLE ordertbl
(
        orderno         NUMBER
      , userid          NVARCHAR2   (5)
      , prodname        NVARCHAR2   (5)
      , orderamount     NUMBER
)
;

--
CREATE  TABLE prodtbl
(
        prodname        NVARCHAR2   (5)
      , account         NUMBER
)
;

--
CREATE  TABLE delivertbl
(
        deliverno       NUMBER
      , prodname        NVARCHAR2   (5)
      , amount          NUMBER
)
;

--
INSERT INTO prodtbl VALUES ('사과', 100)  ;
INSERT INTO prodtbl VALUES ('배', 100)  ;
INSERT INTO prodtbl VALUES ('귤', 100)  ;

--
CREATE OR REPLACE TRIGGER trg_order
    AFTER INSERT
    ON ordertbl
    FOR EACH ROW
DECLARE
    v_orderamount   NUMBER          ;
    v_prodname      NVARCHAR2   (5) ;
BEGIN
    DBMS_OUTPUT.PUT_LINE('1. trg_order 가 실행됩니다.')   ;
    
    SELECT
            :NEW.orderamount
      INTO  v_orderamount
      FROM  DUAL
    ;
    
    SELECT
            :NEW.prodname
      INTO  v_prodname
      FROM  DUAL
    ;
    
    UPDATE  prodtbl
       SET
            account = account - v_orderamount
     WHERE  1 = 1
       AND  prodname = v_prodname
    ;
END     trg_order
;

--
CREATE OR REPLACE TRIGGER trg_prod
    AFTER UPDATE
    ON prodtbl
    FOR EACH ROW
DECLARE
    v_amount    NUMBER          ;
    v_prodname  NVARCHAR2   (5) ;
BEGIN
    DBMS_OUTPUT.PUT_LINE('2. trg_prod 가 실행됩니다.')   ;
    
    SELECT
            :NEW.prodname
      INTO  v_prodname
      FROM  DUAL
    ;
    
    SELECT
            :OLD.account - :NEW.account
      INTO  v_amount
      FROM  DUAL
    ;
    
    INSERT  INTO    delivertbl
                    (
                        deliverno
                      , prodname
                      , amount
                    )
            VALUES  (
                        deliverseq.NEXTVAL
                      , v_prodname
                      , v_amount
                    )
    ;
END     trg_prod
;

--
SET SERVEROUTPUT ON ;

--
BEGIN
    INSERT INTO ordertbl VALUES (orderseq.NEXTVAL, 'JOHN', '배', 5)  ;
END
;

--
SELECT
        *
  FROM  ordertbl
 WHERE  1 = 1
;

--
SELECT
        *
  FROM  prodtbl
 WHERE  1 = 1
;

--
SELECT
        *
  FROM  delivertbl
 WHERE  1 = 1
;

--
ALTER TABLE delivertbl
    RENAME COLUMN prodname TO productname
;

--
BEGIN
    INSERT INTO ordertbl VALUES (orderseq.NEXTVAL, 'DANG', '사과', 9)  ;
END
;

--
ALTER TABLE delivertbl
    RENAME COLUMN productname TO prodname
;

--
BEGIN
    INSERT INTO ordertbl VALUES (orderseq.NEXTVAL, 'DANG', '사과', 9)  ;
END
;

--
CREATE SEQUENCE Aseq    ;
CREATE SEQUENCE Bseq    ;

--
CREATE  TABLE recuA
(
        id      NUMBER
      , txt     NVARCHAR2   (10)
)
;

--
CREATE  TABLE recuB
(
        id      NUMBER
      , txt     NVARCHAR2   (10)
)
;

--
CREATE  TABLE counttbl
(
        cnt     NUMBER
)
;

--
INSERT INTO counttbl VALUES (0) ;

--
SELECT
        *
  FROM  counttbl
 WHERE  1 = 1
;

--
CREATE OR REPLACE TRIGGER trg_recuA
    AFTER INSERT
    ON recuA
DECLARE
        v_count     NUMBER  ;
BEGIN
        SELECT
                cnt
          INTO  v_count
          FROM  counttbl
         WHERE  1 = 1
        ;
        
        IF v_count >= 49 THEN
            RETURN  ;
        END IF
        ;
        
        v_count :=  v_count + 1 ;
        DBMS_OUTPUT.PUT_LINE(v_count || ' --> trg_recuA 가 실행됩니다.')  ;
        
        UPDATE  counttbl
           SET
                cnt = v_count
        ;
        
        INSERT INTO recuB VALUES (bseq.NEXTVAL, '간접 재귀 트리거')    ;
        
END     trg_recuA
;

--
CREATE OR REPLACE TRIGGER trg_recuB
    AFTER INSERT
    ON recuB
DECLARE
        v_count     NUMBER  ;
BEGIN
        SELECT
                cnt
          INTO  v_count
          FROM  counttbl
         WHERE  1 = 1
        ;
        
        IF v_count >= 49 THEN
            RETURN  ;
        END IF
        ;
        
        v_count :=  v_count + 1 ;
        DBMS_OUTPUT.PUT_LINE(v_count || ' --> trg_recuB 가 실행됩니다.')  ;
        
        UPDATE  counttbl
           SET
                cnt = v_count
        ;
        
        INSERT INTO recuA VALUES (aseq.NEXTVAL, '간접 재귀 트리거')    ;

END
;

--
BEGIN
    INSERT 
      INTO  recuA
    VALUES (
                aseq.NEXTVAL
              , '처음입력값'
            )
    ;
END
;

--
SELECT
        *
  FROM  recuA
 WHERE  1 = 1
;

--
SELECT
        *
  FROM  counttbl
 WHERE  1 = 1
;

--
DROP SEQUENCE aseq  ;
DROP SEQUENCE bseq  ;

--
CREATE SEQUENCE aseq    ;
CREATE SEQUENCE bseq    ;

--
UPDATE  counttbl
   SET
        cnt = 0
;

--
BEGIN
    INSERT 
      INTO  recuA
    VALUES (
                aseq.NEXTVAL
              , '처음입력값'
            )
    ;
END
;

--
SELECT
        *
  FROM  recuA
 WHERE  1 = 1
;

--
SELECT
        *
  FROM  recuB
 WHERE  1 = 1
;


--
CREATE  TABLE recu
(
        id      NUMBER
      , txt     NVARCHAR2   (10)
)
;

--
CREATE OR REPLACE TRIGGER trg_recu
    AFTER INSERT
    ON recu
DECLARE
        v_count     NUMBER  ;
BEGIN
        SELECT
                cnt
          INTO  v_count
          FROM  counttbl
         WHERE  1 = 1
        ;
        
        IF v_count >= 49 THEN
            RETURN  ;
        END IF
        ;
        
        v_count :=  v_count + 1 ;
        DBMS_OUTPUT.PUT_LINE(v_count || ' --> trg_recu 가 실행됩니다.')  ;
        
        UPDATE  counttbl
           SET
                cnt = v_count
        ;
        
        INSERT INTO recu VALUES (aseq.NEXTVAL, '직접 재귀 트리거')    ;

END
;

--
BEGIN
    INSERT 
      INTO  recu
    VALUES (
                aseq.NEXTVAL
              , '처음입력값'
            )
    ;
END
;


--
SELECT
        *
  FROM  counttbl
 WHERE  1 = 1
;


--
SELECT
        *
  FROM  recu
 WHERE  1 = 1
;


--
CREATE  TABLE autoTable
(
        seqnum      NUMBER              NOT NULL    PRIMARY KEY
      , txt         NVARCHAR2   (20)
)
;

--
DROP SEQUENCE autoseq
;

--
CREATE SEQUENCE autoseq
    START WITH  10000
    INCREMENT BY    1
;

--
CREATE OR REPLACE TRIGGER trg_autoseq
    BEFORE INSERT
    ON autotable
    FOR EACH ROW
BEGIN
    IF INSERTING AND :NEW.seqnum IS NULL THEN
        SELECT
                autoseq.NEXTVAL
          INTO  :NEW.seqnum
          FROM  DUAL
        ;
    END IF
    ;
END     trg_autoseq
;

--
SELECT
        *
  FROM  autotable
 WHERE  1 = 1
;

--
INSERT 
INTO    autotable
VALUES  (
            NULL
          , '이것이'
        )
;
INSERT 
INTO    autotable
VALUES  (
            NULL
          , '오라클'
        )
;
INSERT 
INTO    autotable
VALUES  (
            NULL
          , '이죠'
        )
;