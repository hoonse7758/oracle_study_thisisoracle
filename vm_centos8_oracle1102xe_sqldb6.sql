

--
SELECT ROW_NUMBER() OVER ( ORDER BY height DESC )
        AS "키큰순위"
     , T01.*
FROM usertbl    T01
WHERE 1 = 1
;


--
SELECT ROW_NUMBER() OVER ( ORDER BY height DESC , username ASC)
        AS "키큰순위"
     , T01.*
FROM usertbl    T01
WHERE 1 = 1
;

--
SELECT t01.addr
     , ROW_NUMBER() OVER ( PARTITION BY addr ORDER BY height DESC , username ASC)
        AS "키큰순위"
     , t01.*
FROM usertbl    t01
WHERE 1 = 1
;


--
SELECT DENSE_RANK() OVER ( ORDER BY height DESC )
        AS "키큰순위"
     , T01.*
FROM usertbl    T01
WHERE 1 = 1
;


--
SELECT RANK() OVER ( ORDER BY height DESC )
        AS "키큰순위"
     , T01.*
FROM usertbl    T01
WHERE 1 = 1
;

--
SELECT NTILE(4) OVER ( ORDER BY height DESC )
        AS "몇반"
     , T01.*
FROM usertbl    T01
WHERE 1 = 1
;

--
SELECT username
     , addr
     , height
     , LEAD(height, 2, NULL) OVER ( ORDER BY height DESC )
        AS "다다음사람 키"
     , height - (LEAD(height, 2, 0) OVER ( ORDER BY height DESC ))
        AS "다다음 사람과 키차이"
FROM usertbl
WHERE 1 = 1
;

--
SELECT username
     , addr
     , height
     , LAG(height, 2) OVER ( ORDER BY ROWNUM )  -- 정렬조건 명시 안해주면 에러남.. 정렬 조건 안쓰려면 이거라도 넣어줘야 됨..
        AS "전전사람 키"
     , height - (LAG(height, 2) OVER ( ORDER BY ROWNUM ))
        AS "전전사람과 키차이"
FROM usertbl
WHERE 1 = 1
;

--
SELECT addr
     , username
     , height
     , CUME_DIST() OVER ( PARTITION BY addr ORDER BY height DESC )
        AS "지역누적백분율"    -- 상위백분위
FROM usertbl
WHERE 1 = 1
;

--
SELECT addr
     , username
     , height
     , PERCENT_RANK() OVER ( PARTITION BY addr ORDER BY height ASC )
        AS "지역누적백분율"    -- 상위백분위
FROM usertbl
WHERE 1 = 1
;

--
SELECT  DISTINCT addr
     , PERCENTILE_CONT(0.5) 
        WITHIN  GROUP   ( ORDER BY height )
        OVER ( PARTITION BY addr )
        AS "지역별 키 중앙값"
FROM usertbl
WHERE 1 = 1
;

--
SELECT  DISTINCT addr
     , PERCENTILE_DISC(0.5) 
        WITHIN  GROUP   ( ORDER BY height )
        OVER ( PARTITION BY addr )
        AS "지역별 키 중앙값"
FROM usertbl
WHERE 1 = 1
;


--
CREATE TABLE pivottest (
    uname   NCHAR(3),
    season  NCHAR(2),
    amount  NUMBER(3)
)
;

--
INSERT INTO pivottest VALUES ('김범수', '겨울', 10) ;
INSERT INTO pivottest VALUES ('윤종신', '여름', 15) ;
INSERT INTO pivottest VALUES ('김범수', '가을', 25) ;
INSERT INTO pivottest VALUES ('김범수', '봄', 3) ;
INSERT INTO pivottest VALUES ('김범수', '봄', 37) ;
INSERT INTO pivottest VALUES ('윤종신', '겨울', 40) ;
INSERT INTO pivottest VALUES ('김범수', '여름', 14) ;
INSERT INTO pivottest VALUES ('김범수', '겨울', 22) ;
INSERT INTO pivottest VALUES ('윤종신', '여름', 64) ;


--
SELECT *
FROM pivottest
WHERE 1 = 1
;

--
SELECT DISTINCT SEASON FROM pivottest ORDER BY season;

--
SELECT *
FROM pivottest
PIVOT ( SUM(amount)
        FOR season
        IN ( '봄', '여름', '가을', '겨울' )     -- SELECT DISTINCT SEASON FROM pivottest ORDER BY season
)
;