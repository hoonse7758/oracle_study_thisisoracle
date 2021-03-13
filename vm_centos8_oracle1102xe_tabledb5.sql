
--
DROP TABLE usertbl ;
DROP TABLE buytbl  ;


--
CREATE TABLE usertbl
(
       userid        CHAR         (8)
     , username      NVARCHAR2    (10)
     , birthyear     NUMBER       (4)
     , addr          NCHAR        (2)
     , mobile1       CHAR         (3)
     , mobile2       CHAR         (8)
     , height        NUMBER       (3)
     , mdate         DATE
)
;

--
CREATE TABLE buytbl
(
       idnum          NUMBER       (8)     PRIMARY KEY
     , userid         CHAR         (8)
     , prodname       NCHAR        (6)
     , groupname      NCHAR        (4)
     , price          NUMBER       (8)
     , amount         NUMBER       (3)
)
;

--
DROP   SEQUENCE idseq ;

--
CREATE SEQUENCE idseq ;

--
INSERT INTO usertbl VALUES ('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8') ;
INSERT INTO usertbl VALUES ('KBS', '김범수', NULL, '경남', '011', '22222222', 173, '2012-4-4') ;
INSERT INTO usertbl VALUES ('KKH', '김경호', 1871, '전남', '019', '33333333', 177, '2007-7-7') ;
INSERT INTO usertbl VALUES ('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4') ;

--
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'KBS', '운동화', NULL, 30, 2) ;
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'KBS', '노트북', '전자', 1000, 1) ;
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'JYP', '모니터', '전자', 200, 1) ;
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'BBK', '모니터', '전자', 200, 5) ;

--
ALTER TABLE usertbl
      ADD   CONSTRAINT   pk_usertbl_userid
            PRIMARY KEY  (userid)
;

--
SELECT *
  FROM user_constraints
 WHERE 1 = 1
   AND owner = 'TABLEDB'
   AND table_name = 'USERTBL'
;

--
DESCRIBE usertbl 
;

--
ALTER TABLE buytbl
      ADD   CONSTRAINT   fk_usertbl_buytbl
            FOREIGN KEY  (userid)
            REFERENCES   usertbl (userid)
;

--
DELETE 
  FROM  buytbl 
 WHERE  1 = 1
   AND  userid = 'BBK'
;


--
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'BBK', '모니터', '전자', 200, 5) ;

--
ALTER TABLE    buytbl
      DISABLE  CONSTRAINT  fk_usertbl_buytbl
;

--
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'BBK', '모니터', '전자', 200, 5) ;
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'KBS', '청바지', '의류', 50, 3) ;
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'BBK', '메모리', '전자', 80, 10) ;
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'SSK', '책', '서적', 15, 5) ;
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'EJW', '책', '서적', 15, 2) ;
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'EJW', '청바지', '의류', 50, 1) ;
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'BBK', '운동화', NULL, 30, 2) ;
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'EJW', '책', '서적', 15, 1) ;
INSERT INTO buytbl VALUES (idseq.NEXTVAL, 'BBK', '운동화', NULL, 30, 2) ;

--
ALTER TABLE  buytbl
      ENABLE NOVALIDATE CONSTRAINT fk_usertbl_buytbl
;


--
ALTER TABLE  usertbl
      ADD    CONSTRAINT ck_birthyear
             CHECK      ( birthyear >= 1900 AND birthyear <= 2017 )
             ENABLE
;

--
SELECT *
  FROM usertbl
 WHERE 1 = 1
;


--
ALTER TABLE  usertbl
      ADD    CONSTRAINT ck_birthyear
             CHECK      ( birthyear >= 1900 AND birthyear <= 2017 )
             ENABLE     NOVALIDATE
;


--
INSERT INTO usertbl VALUES ('SSK', '성시경', 1979, '서울', NULL, NULL, 186, '2013-12-12') ;
INSERT INTO usertbl VALUES ('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-9-9') ;
INSERT INTO usertbl VALUES ('YJS', '윤종신', 1969, '경남', NULL, NULL, 170, '2005-5-5') ;
INSERT INTO usertbl VALUES ('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3') ;
INSERT INTO usertbl VALUES ('JKW', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10') ;
INSERT INTO usertbl VALUES ('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-5-5') ;





--
DELETE
  FROM usertbl
 WHERE 1 = 1
   AND userid = 'BBK'
;

--
ALTER TABLE buytbl
      DROP  CONSTRAINT  fk_usertbl_buytbl
;

--
ALTER TABLE buytbl
      ADD   CONSTRAINT  fk_usertbl_buytbl
                        FOREIGN KEY        (userid)
                        REFERENCES         usertbl (userid)
                        ON DELETE CASCADE
;

--
SELECT *
  FROM buytbl
 WHERE 1 = 1
;

--
DELETE
  FROM usertbl
 WHERE 1 = 1
   AND userid = 'BBK'
;


--
ALTER TABLE usertbl
      DROP  COLUMN   birthyear
;


