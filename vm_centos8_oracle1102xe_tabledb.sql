
--
DROP    TABLE   table1
;

--
SELECT *
FROM usertbl
WHERE 1 = 1
;


--
DROP    TABLE       buytbl ;
DROP    TABLE       usertbl ;
DROP    SEQUENCE    idseq ;
DROP    SEQUENCE    buytbl_seq ;
DROP    TRIGGER     buytbl_trg ;


--
CREATE  TABLE   usertbl
(
    userid      CHAR        (8)     NOT NULL    PRIMARY KEY
  , username    NVARCHAR2   (10)    NOT NULL
  , birthyear   NUMBER      (4)     NOT NULL
  , addr        NCHAR       (2)     NOT NULL
  , mobile1     CHAR        (3)         NULL
  , mobile2     CHAR        (8)         NULL
  , height      NUMBER      (3)         NULL
  , mdate       DATE
)
;

--
CREATE  TABLE   buytbl
(
    idnum       NUMBER      (8)     NOT NULL    PRIMARY KEY
  , userid      CHAR        (8)     NOT NULL
  , prodname    NCHAR       (6)     NOT NULL
  , groupname   NCHAR       (4)         NULL
  , price       NUMBER      (8)         NULL
  , amount      NUMBER      (3)     NOT NULL
    
  , FOREIGN KEY(userid)     REFERENCES  usertbl(userid)
)
;


--
INSERT  INTO    usertbl VALUES  ('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-08-08')    ;
INSERT  INTO    usertbl VALUES  ('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-04-04')    ;
INSERT  INTO    usertbl VALUES  ('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-07-07')    ;

--
CREATE  SEQUENCE    idseq   ;
INSERT  INTO    buytbl  VALUES  (idseq.NEXTVAL, 'KBS', '운동화', NULL, 30, 2)      ;
INSERT  INTO    buytbl  VALUES  (idseq.NEXTVAL, 'KBS', '노트북', '전자', 1000, 1)    ;
--INSERT  INTO    buytbl  VALUES  (idseq.NEXTVAL, 'JYP', '모니터', '전자', 200, 1)     ;

--
SELECT  *
FROM    buytbl
WHERE   1 = 1
;