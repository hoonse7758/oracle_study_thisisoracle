

--
SELECT t02.*
     , t01.*
FROM        buytbl  t01
INNER JOIN  usertbl t02
ON          t01.userid = t02.userid
WHERE       1 = 1
--AND         t02.userid = 'JYP'
;


--
SELECT t01.userid
     , t02.username
     , t01.prodname
     , t02.addr
     , t02.mobile1 || '-' || t02.mobile2
        AS "연락처"
FROM        buytbl  t01
INNER JOIN  usertbl t02
ON          t01.userid = t02.userid
WHERE       1 = 1
AND         t01.userid = 'JYP'
;

--
SELECT t01.*
     , t02.*
FROM    buytbl      t01
      , usertbl     t02
WHERE   1 = 1
AND     t01.userid = t02.userid
;

--
SELECT DISTINCT *
FROM (
    SELECT DISTINCT
           t01.userid
         , t01.username
         , t01.addr
    FROM        usertbl t01
    INNER JOIN  buytbl  t02
    ON          t01.userid = t02.userid
    WHERE       1 = 1
    ORDER BY    t01.userid
)
;

--
SELECT *
FROM        usertbl t01
WHERE       1 = 1
AND         EXISTS(
                SELECT  *
                FROM    buytbl  t02
                WHERE   t01.userid = t02.userid
            )
ORDER BY    t01.userid
;

--
DROP    TABLE   studenttbl ;
CREATE  TABLE   studenttbl
(
    stdname NCHAR(5)    NOT NULL    PRIMARY KEY,
    addr    NCHAR(2)    NOT NULL
)
;
DROP    TABLE   clubtbl ;
CREATE  TABLE   clubtbl
(
    clbname NCHAR(5)    NOT NULL    PRIMARY KEY,
    roomno  NCHAR(4)    NOT NULL
)
;

CREATE  SEQUENCE    stdclubseq ;

DROP    TABLE   studentclubtbl ;
CREATE  TABLE   studentclubtbl
(
    idnum   NUMBER(5)   NOT NULL    PRIMARY KEY,
    stdname NCHAR(5)    NOT NULL,
    clbname NCHAR(5)    NOT NULL,
    
    FOREIGN KEY (stdname)   REFERENCES  studenttbl(stdname),
    FOREIGN KEY (clbname)   REFERENCES  clubtbl(clbname)
)
;

INSERT  INTO    studenttbl      VALUES('김범수', '경남');
INSERT  INTO    studenttbl      VALUES('성시경', '서울');
INSERT  INTO    studenttbl      VALUES('조용필', '경기');
INSERT  INTO    studenttbl      VALUES('은지원', '경북');
INSERT  INTO    studenttbl      VALUES('바비킴', '서울');

INSERT  INTO    clubtbl         VALUES('수영', '101호');
INSERT  INTO    clubtbl         VALUES('바둑', '102호');
INSERT  INTO    clubtbl         VALUES('축구', '103호');
INSERT  INTO    clubtbl         VALUES('봉사', '104호');

INSERT  INTO    studentclubtbl  VALUES(stdclubseq.NEXTVAL, '김범수', '바둑');
INSERT  INTO    studentclubtbl  VALUES(stdclubseq.NEXTVAL, '김범수', '축구');
INSERT  INTO    studentclubtbl  VALUES(stdclubseq.NEXTVAL, '조용필', '축구');
INSERT  INTO    studentclubtbl  VALUES(stdclubseq.NEXTVAL, '은지원', '축구');
INSERT  INTO    studentclubtbl  VALUES(stdclubseq.NEXTVAL, '은지원', '봉사');
INSERT  INTO    studentclubtbl  VALUES(stdclubseq.NEXTVAL, '바비킴', '봉사');


--
SELECT  *
FROM    studenttbl
WHERE   1 = 1
;
SELECT  *
FROM    clubtbl
WHERE   1 = 1
;
SELECT  *
FROM    studentclubtbl
WHERE   1 = 1
;

--
SELECT      t01.*
          , t02.clbname
          , t03.roomno
FROM        studenttbl      t01
INNER JOIN  studentclubtbl  t02
        ON  t01.stdname = t02.stdname
INNER JOIN  clubtbl         t03
        ON  t02.clbname = t03.clbname
WHERE       1 = 1
ORDER BY    t01.stdname
;

--
SELECT      t01.clbname
--          , t02.*
          , t03.stdname
FROM        clubtbl         t01
INNER JOIN  studentclubtbl  t02
        ON  t01.clbname = t02.clbname
INNER JOIN  studenttbl      t03
        ON  t02.stdname = t03.stdname
WHERE       1 = 1
ORDER BY    t01.clbname
;

--
SELECT  t01.*
      , t02.*
FROM            usertbl t01
LEFT OUTER JOIN buytbl  t02
             ON t01.userid = t02.userid
WHERE           1 = 1
ORDER BY        t01.userid
;

--
            SELECT  t02.*
                  , t01.*
            FROM    buytbl  t01
RIGHT OUTER JOIN    usertbl t02
              ON    t01.userid = t02.userid
           WHERE    1 = 1
        ORDER BY    t01.userid
;

--
          SELECT    t02.*
--                  , t01.*
            FROM    buytbl  t01
RIGHT OUTER JOIN    usertbl t02
              ON    t01.userid = t02.userid
           WHERE    1 = 1
             AND    t01.userid IS NULL
        ORDER BY    t02.userid
;


--
         SELECT /**/ t01.*
              , /**/ t02.*
              , /**/ t03.*
           FROM /**/ studenttbl      t01
LEFT OUTER JOIN /**/ studentclubtbl  t02
             ON /**/ t01.stdname = t02.stdname
LEFT OUTER JOIN /**/ clubtbl         t03
             ON /**/ t02.clbname = t03.clbname
          WHERE /**/ 1 = 1
       ORDER BY /**/ t01.stdname
;

--
          SELECT    t03.*
                  , t02.*
                  , t01.*
            FROM    studenttbl      t01
 LEFT OUTER JOIN    studentclubtbl  t02
              ON    t01.stdname = t02.stdname
RIGHT OUTER JOIN    clubtbl         t03
              ON    t02.clbname = t03.clbname
           WHERE    1 = 1
        ORDER BY    t02.clbname
;

--
          SELECT    t01.*
--                  , t02.*
                  , t03.*
            FROM    studenttbl      t01
 LEFT OUTER JOIN    studentclubtbl  t02
              ON    t01.stdname = t02.stdname
 LEFT OUTER JOIN    clubtbl         t03
              ON    t02.clbname = t03.clbname
           WHERE    1 = 1
--        ORDER BY    t02.clbname
           UNION    -- 
          SELECT    t01.*
--                  , t02.*
                  , t03.*
            FROM    studenttbl      t01
 LEFT OUTER JOIN    studentclubtbl  t02
              ON    t01.stdname = t02.stdname
RIGHT OUTER JOIN    clubtbl         t03
              ON    t02.clbname = t03.clbname
           WHERE    1 = 1
--        ORDER BY    t02.clbname
;

--
          SELECT    t01.*
                  , t02.*
                  , t03.*
            FROM    studenttbl      t01
 FULL OUTER JOIN    studentclubtbl  t02
              ON    t01.stdname = t02.stdname
 FULL OUTER JOIN    clubtbl         t03
              ON    t02.clbname = t03.clbname
           WHERE    1 = 1
        ORDER BY    t01.stdname
                  , t02.clbname
;

--
    SELECT  *
      FROM  buytbl
CROSS JOIN  usertbl
     WHERE 1 = 1
;


--
    SELECT  *
      FROM  buytbl
         ,  usertbl
     WHERE 1 = 1
;

-- 
    SELECT  COUNT(*)
            AS  CNT
      FROM  hr.employees
CROSS JOIN  hr.countries
     WHERE  1 = 1
;

--
    SELECT  t01.userid
          , t01.username
          , t02.groupname
          , t02.prodname
          , t02.price
          , t02.amount
      FROM  usertbl     t01
CROSS JOIN  buytbl       t02
     WHERE  1 = 1
;

--
CREATE  TABLE   crosstbl AS (
        SELECT  t01.userid
              , t01.username
              , t02.groupname
              , t02.prodname
              , t02.price
              , t02.amount
          FROM  usertbl     t01
    CROSS JOIN  (
                    SELECT  DISTINCT
                            groupname
                          , prodname
                          , price
                          , amount
                      FROM  buytbl
                     WHERE  1 = 1
                )           t02
         WHERE  1 = 1
--      ORDER BY  t01.userid
--              , t02.groupname
--              , t02.prodname
--              , t02.price
--              , t02.amount
)
;

--
    SELECT  *
      FROM  crosstbl
     WHERE  1 = 1
  ORDER BY  userid
          , groupname
          , prodname
          , price
          , amount     
;

--
CREATE  TABLE   emptbl
(
    emp         NCHAR(3),
    manager     NCHAR(3),
    department  NCHAR(3)
)
;

--
TRUNCATE    TABLE   emptbl ;
INSERT  INTO    emptbl  VALUES  ('나사장', '없음', '없음') ;
INSERT  INTO    emptbl  VALUES  ('김재무', '나사장', '재무부') ;
INSERT  INTO    emptbl  VALUES  ('김부장', '김재무', '재무부') ;
INSERT  INTO    emptbl  VALUES  ('이부장', '김재무', '재무부') ;
INSERT  INTO    emptbl  VALUES  ('우대리', '이부장', '재무부') ;
INSERT  INTO    emptbl  VALUES  ('지사원', '이부장', '재무부') ;
INSERT  INTO    emptbl  VALUES  ('이영업', '나사장', '영업부') ;
INSERT  INTO    emptbl  VALUES  ('한과장', '이영업', '영업부') ;
INSERT  INTO    emptbl  VALUES  ('최정보', '나사장', '정보부') ;
INSERT  INTO    emptbl  VALUES  ('윤차장', '최정보', '정보부') ;
INSERT  INTO    emptbl  VALUES  ('이주임', '윤차장', '정보부') ;

--
SELECT  *
FROM    emptbl
WHERE   1 = 1
;

--
    SELECT  tbl_emp.*
          , tbl_mgr.*
      FROM  emptbl  tbl_emp
INNER JOIN  emptbl  tbl_mgr
        ON  tbl_emp.manager = tbl_mgr.emp
     WHERE  1 = 1
--       AND  tbl_emp.emp = '우대리'
;

--
   SELECT   stdname
          , addr
     FROM   studenttbl
    WHERE   1 = 1
UNION ALL -----------------------
   SELECT   clbname
          , roomno
     FROM   clubtbl
    WHERE   1 = 1
;

--
   SELECT   username
          , mobile1 || '-' || mobile2
            AS "전화번호"
     FROM   usertbl
    WHERE   1 = 1
      AND   username NOT IN (
                  SELECT    username
                    FROM    usertbl
                   WHERE    1 = 1
                     AND    mobile1 IS NULL
            )
;

--
   SELECT   username
          , mobile1 || '-' || mobile2
            AS "전화번호"
     FROM   usertbl
    WHERE   1 = 1
      AND   username IN (
                  SELECT    username
                    FROM    usertbl
                   WHERE    1 = 1
                     AND    mobile1 IS NULL
            )
;

