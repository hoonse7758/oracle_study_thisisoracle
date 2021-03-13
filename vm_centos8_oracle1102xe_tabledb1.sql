
--
SELECT  *
  FROM  user_constraints
 WHERE  1 = 1
   AND  owner = 'TABLEDB'
   AND  table_name = 'USERTBL'
--   AND  constraint_type = 'P'
;

--
DROP    TABLE   usertbl CASCADE CONSTRAINTS
;

--
CREATE  TABLE   usertbl
(
    userid      CHAR        (8)     NOT NULL    CONSTRAINT pk_usertbl_userid PRIMARY KEY
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
CREATE  TABLE   usertbl
(
    userid      CHAR        (8)     NOT NULL
  , username    NVARCHAR2   (10)    NOT NULL
  , birthyear   NUMBER      (4)     NOT NULL
  , addr        NCHAR       (2)     NOT NULL
  , mobile1     CHAR        (3)         NULL
  , mobile2     CHAR        (8)         NULL
  , height      NUMBER      (3)         NULL
  , mdate       DATE

  , CONSTRAINT pk_usertbl_userid PRIMARY KEY(userid)
)
;

--
CREATE  TABLE   usertbl
(
    userid      CHAR        (8)     NOT NULL
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
ALTER   TABLE   usertbl
        ADD     CONSTRAINT  pk_usertbl_userid
                PRIMARY KEY (userid)
;

--
CREATE  TABLE   prodtbl
(
    prodcode    CHAR        (3)     NOT NULL
  , prodid      CHAR        (4)     NOT NULL
  , proddate    DATE                NOT NULL
  , prodcur     CHAR        (10)    NULL
)
;

--
ALTER   TABLE   prodtbl
        ADD     CONSTRAINT  pk_prodtbl_prodcode_prodid
                PRIMARY KEY (prodcode, prodid)
;

--
DROP    TABLE   prodtbl     CASCADE CONSTRAINTS
;

--
CREATE  TABLE   prodtbl
(
    prodcode    CHAR        (3)     NOT NULL
  , prodid      CHAR        (4)     NOT NULL
  , proddate    DATE                NOT NULL
  , prodcur     CHAR        (10)    NULL
  
  , CONSTRAINT  pk_prodtbl_prodcode_prodid  PRIMARY KEY (prodcode, prodid)
)
;

--
DROP    TABLE   usertbl CASCADE CONSTRAINTS
;

--
DROP    TABLE   buytbl  CASCADE CONSTRAINTS
;

--
CREATE  TABLE   usertbl
(
    userid      CHAR        (8)     NOT NULL    CONSTRAINT pk_usertbl_userid    PRIMARY KEY
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
    idnum       NUMBER      (8)     NOT NULL    CONSTRAINT  pk_buytbl_idnum     PRIMARY KEY
  , userid      CHAR        (8)     NOT NULL    CONSTRAINT  fk_buytbl_userid    REFERENCES  usertbl(userid)
  , prodname    NCHAR       (6)     NOT NULL
  , groupname   NCHAR       (4)         NULL
  , price       NUMBER      (8)         NULL
  , amount      NUMBER      (3)     NOT NULL
)
;

--
CREATE  TABLE   buytbl
(
    idnum       NUMBER      (8)     NOT NULL    CONSTRAINT  pk_buytbl_idnum     PRIMARY KEY
  , userid      CHAR        (8)     NOT NULL
  , prodname    NCHAR       (6)     NOT NULL
  , groupname   NCHAR       (4)         NULL
  , price       NUMBER      (8)         NULL
  , amount      NUMBER      (3)     NOT NULL
  
  , CONSTRAINT  fk_buytbl_userid    FOREIGN KEY(userid) REFERENCES  usertbl(userid)
)
;

--
CREATE  TABLE   buytbl
(
    idnum       NUMBER      (8)     NOT NULL    CONSTRAINT  pk_buytbl_idnum     PRIMARY KEY
  , userid      CHAR        (8)     NOT NULL
  , prodname    NCHAR       (6)     NOT NULL
  , groupname   NCHAR       (4)         NULL
  , price       NUMBER      (8)         NULL
  , amount      NUMBER      (3)     NOT NULL
  
  ,             FOREIGN KEY(userid) REFERENCES  usertbl(userid)
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
)
;

--
ALTER   TABLE   buytbl
        ADD     CONSTRAINT  fk_usertbl_buytbl
                FOREIGN KEY (userid)    REFERENCES  usertbl(userid)
;

--
ALTER   TABLE   buytbl
        DROP    CONSTRAINT  fk_usertbl_buytbl
;

--
ALTER   TABLE   buytbl
        ADD     CONSTRAINT  fk_usertbl_buytbl
                FOREIGN KEY (userid)    REFERENCES  usertbl(userid)
                                        ON DELETE   CASCADE
;

--
DROP    TABLE   usertbl     CASCADE CONSTRAINTS
;

--
CREATE  TABLE   usertbl
(
    userid      CHAR        (8)     NOT NULL    CONSTRAINT pk_usertbl_userid    PRIMARY KEY
  , username    NVARCHAR2   (10)    NOT NULL
  , birthyear   NUMBER      (4)     NOT NULL
  , addr        NCHAR       (2)     NOT NULL
  , mobile1     CHAR        (3)         NULL
  , mobile2     CHAR        (8)         NULL
  , height      NUMBER      (3)         NULL
  , mdate       DATE
  , email       CHAR        (30)        NULL    UNIQUE
)
;

--
CREATE  TABLE   usertbl
(
    userid      CHAR        (8)     NOT NULL    CONSTRAINT pk_usertbl_userid    PRIMARY KEY
  , username    NVARCHAR2   (10)    NOT NULL
  , birthyear   NUMBER      (4)     NOT NULL
  , addr        NCHAR       (2)     NOT NULL
  , mobile1     CHAR        (3)         NULL
  , mobile2     CHAR        (8)         NULL
  , height      NUMBER      (3)         NULL
  , mdate       DATE                    NULL
  , email       CHAR        (30)        NULL
  ,             CONSTRAINT ak_mail  UNIQUE (email)
)
;

--
CREATE  TABLE   usertbl
(
    userid      CHAR        (8)     NOT NULL    CONSTRAINT pk_usertbl_userid    PRIMARY KEY
  , username    NVARCHAR2   (10)    NOT NULL
  , birthyear   NUMBER      (4)     NOT NULL
  , addr        NCHAR       (2)     NOT NULL
  , mobile1     CHAR        (3)         NULL
  , mobile2     CHAR        (8)         NULL
  , height      NUMBER      (3)         NULL
  , mdate       DATE
  , email       CHAR        (30)        NULL
)
;

--
ALTER   TABLE   usertbl
        ADD     CONSTRAINT  ak_mail UNIQUE (email)
;

--
ALTER   TABLE   usertbl
        ADD     CONSTRAINT  ck_height
                CHECK       ( height > 0 )
;

--
ALTER   TABLE   usertbl
        ADD     CONSTRAINT  ck_mobile1
                CHECK       ( mobile1 IN ('010', '011', '016', '017', '018', '019') )
;

--
ALTER   TABLE   usertbl
        DROP    CONSTRAINT  ck_mobile1
;

--
ALTER   TABLE   usertbl
        ADD     CONSTRAINT  ck_mobile1
                CHECK       ( mobile1 IN ('010', '011', '016', '017', '018', '019') )
                ENABLE  NOVALIDATE
;


--
DROP    TABLE   usertbl     CASCADE CONSTRAINTS
;


--
CREATE  TABLE   usertbl
(
    userid      CHAR        (8)                     NOT NULL    CONSTRAINT  pk_usertbl_userid   PRIMARY KEY
  , username    NVARCHAR2   (10)                    NOT NULL
  , birthyear   NUMBER      (4)     DEFAULT -1      NOT NULL
  , addr        NCHAR       (2)     DEFAULT '¼­¿ï'   NOT NULL
  , mobile1     CHAR        (3)                     NULL
  , mobile2     CHAR        (8)                     NULL
  , height      NUMBER      (3)     DEFAULT 170     NULL
  , mdate       DATE
  , email       CHAR        (30)                    NULL
)
;

--
CREATE  TABLE   usertbl
(
    userid      CHAR        (8)     NOT NULL    CONSTRAINT pk_usertbl_userid    PRIMARY KEY
  , username    NVARCHAR2   (10)    NOT NULL
  , birthyear   NUMBER      (4)     NOT NULL
  , addr        NCHAR       (2)     NOT NULL
  , mobile1     CHAR        (3)         NULL
  , mobile2     CHAR        (8)         NULL
  , height      NUMBER      (3)         NULL
  , mdate       DATE
  , email       CHAR        (30)        NULL    UNIQUE
)
;

--
ALTER   TABLE   usertbl
        MODIFY  birthyear   DEFAULT -1
;
ALTER   TABLE   usertbl
        MODIFY  addr        DEFAULT '¼­¿ï'
;
ALTER   TABLE   usertbl
        MODIFY  height      DEFAULT 170
;

--
SELECT  *
  FROM  usertbl
 WHERE  1 = 1
;

--
INSERT  INTO    usertbl VALUES  ('LHL', 'ÀÌÇý¸®', DEFAULT, DEFAULT, '011', '1234567', DEFAULT, '2019.12.12', 'lhl@daum.net') ;
INSERT  INTO    usertbl(userid, username) VALUES  ('KAY', '±è¾Æ¿µ') ;
INSERT  INTO    usertbl VALUES  ('WB', '¿øºó', 1982, '´ëÀü', '019', '9876543', 176, '2020.5.5', 'wb@naver.com') ;

