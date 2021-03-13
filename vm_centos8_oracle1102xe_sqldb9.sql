

--
CREATE VIEW v_usertbl
       AS
       (
           SELECT 
                  userid
                , username
                , addr
             FROM usertbl
            WHERE 1 = 1
       )
;

--
SELECT *
FROM   v_usertbl
 WHERE 1 = 1
;

--
CREATE OR REPLACE VIEW v_usertbl
       AS
       (
           SELECT 
                  userid
                , username
                , addr
             FROM usertbl
            WHERE 1 = 1
       )
;

--
CREATE OR REPLACE VIEW v_userbuytbl
                  AS
                  (
                           SELECT
                                  t00.userid
                                , t00.username
                                , t01.prodname
                                , t00.addr
                                , t00.mobile1 || t00.mobile2   AS mobile
                             FROM usertbl  t00
                       INNER JOIN buytbl   t01
                               ON t00.userid = t01.userid
                  )
;

--
SELECT *
  FROM v_userbuytbl
 WHERE 1 = 1
   AND username = '김범수'
;


--
CREATE OR REPLACE VIEW v_userbuytbl
                  AS
                  (
                           SELECT
                                  t00.userid
                                  AS  "USER ID"
                                , t00.username
                                  AS  "USER NAME"
                                , t01.prodname
                                  AS  "PRODUCT NAME"
                                , t00.addr
                                  AS  "ADDRESS"
                                , t00.mobile1 || t00.mobile2
                                  AS  "MOBILE PHONE"
                             FROM usertbl  t00
                       INNER JOIN buytbl   t01
                               ON t00.userid = t01.userid
                  )
;

--
SELECT *
  FROM v_userbuytbl
 WHERE 1 = 1
   AND "USER NAME" = '김범수'
;

--
DROP VIEW v_userbuytbl ;

--
SELECT *
  FROM user_views
 WHERE 1 = 1
;



--
SELECT *
  FROM v_usertbl
 WHERE 1 = 1
;

--
UPDATE v_usertbl
   SET addr = '부산'
 WHERE 1 = 1
   AND userid = 'JKW'
;

--
SELECT *
  FROM usertbl
 WHERE 1 = 1
;


--
INSERT INTO v_usertbl (userid, username, addr) VALUES ('KBM', '김병만', '충북') ;

--
CREATE OR REPLACE VIEW v_usertbl
       AS
       (
           SELECT 
                  userid
                , username
                , addr
             FROM usertbl
            WHERE 1 = 1
       )
       WITH READ ONLY
;

--
UPDATE v_usertbl
   SET addr = '경상'
 WHERE 1 = 1
   AND userid = 'JKW'
;

--
CREATE OR REPLACE VIEW v_sum
                    AS
                    (      SELECT
                                  userid
                                , SUM(price*amount)
                                  AS total_amount
                             FROM buytbl
                            WHERE 1 = 1
                         GROUP BY 
                                  userid
                    )
;

--
SELECT *
  FROM v_sum
 WHERE 1 = 1
;

--
INSERT INTO v_sum VALUES('BAD', 1000) ;

--
SELECT *
  FROM v_userbuytbl
 WHERE 1 = 1
;

--
UPDATE v_userbuytbl
   SET "ADDRESS" = '경강'
 WHERE 1 = 1
   AND "USER ID" = 'BBK'
;

--
CREATE OR REPLACE VIEW v_height_177
                       AS 
                       (
                           SELECT *
                             FROM usertbl
                            WHERE 1 = 1
                              AND height >= 177
                       )
;

--
SELECT *
  FROM v_height_177
 WHERE 1 = 1
;

--
SELECT *
  FROM usertbl
 WHERE 1 = 1
;

--
DELETE 
  FROM v_height_177 
 WHERE 1 = 1
   AND HEIGHT < 177 
;

--
INSERT INTO v_height_177 VALUES ('KBM', '김병만', 1977, '경기', '010', '55555555', 158, '2019-01-01') ;

--
CREATE OR REPLACE VIEW v_height_177
                       AS 
                       (
                           SELECT *
                             FROM usertbl
                            WHERE 1 = 1
                              AND height >= 177
                       )
                       WITH CHECK OPTION
;

--
INSERT INTO v_height_177 VALUES ('KBM', '김병만', 1977, '경기', '010', '55555555', 158, '2019-01-01') ;

--
CREATE OR REPLACE VIEW v_userbuytbl
                       AS
                       (
                                SELECT 
                                       t00.userid
                                     , t00.username 
                                     , t01.prodname
                                     , t00.addr
                                     , t00.mobile1 || t00.mobile2
                                       AS mobile
                                  FROM usertbl  t00
                            INNER JOIN buytbl   t01
                                    ON t00.userid = t01.userid
                       )
;

--
SELECT *
  FROM v_userbuytbl
 WHERE 1 = 1
;



--
INSERT INTO v_userbuytbl VALUES ('PKL', '박경리', '운동화', '경기', '0000000000') ;

--
CREATE TABLE usertbl
             AS
             (
                 SELECT *
                   FROM usertbl_bak
                  WHERE 1 = 1
             )
;

--
DROP TABLE usertbl CASCADE CONSTRAINTS ;

--
SELECT * FROM v_userbuytbl ;