
--
SELECT userid       AS "사용자 아이디"
     , SUM(amount)  AS "총 구매 개수"
FROM buytbl
WHERE 1 = 1
GROUP BY userid
;

--
SELECT userid               AS "사용자 아이디"
     , SUM(amount * price)  AS "총 구매 금액"
FROM buytbl
WHERE 1 = 1
GROUP BY userid
;

--
SELECT CAST(AVG(amount) AS NUMBER(5, 3))          AS "평균 구매 금액"
FROM buytbl
WHERE 1 = 1
;

--
SELECT userid                               AS "사용자 아이디"
     , CAST(AVG(amount) AS NUMBER(5, 3))    AS "평균 구매 금액"
FROM buytbl
WHERE 1 = 1
GROUP BY userid
;

--
SELECT username
     , height
FROM usertbl
WHERE 1 = 1
AND (
       height = (SELECT MAX(height) FROM usertbl)
    OR height = (SELECT MIN(height) FROM usertbl)
)
;

--
SELECT COUNT(*)         AS "전체 회원 수"
     , COUNT(mobile1)   AS "휴대폰 보유 회원 수"
FROM usertbl
WHERE 1 = 1
;

--
SELECT userid               AS "사용자 아이디"
     , SUM(amount * price)  AS "총 구매 금액"
FROM buytbl
WHERE 1 = 1
GROUP BY userid
HAVING 1 = 1
AND SUM(amount * price) > 1000
ORDER BY SUM(amount * price) DESC
;



-- ROLLUP
SELECT ROWNUM                   AS "아이디 일련번호"
     , groupname                AS "그룹명"
     , SUM(price * amount)      AS "비용"
     , GROUPING_ID(groupname)   AS "추가행 여부"
FROM buytbl
WHERE 1 = 1
--GROUP BY groupname, ROWNUM
GROUP BY ROLLUP(groupname, ROWNUM)
;

-- CUBE
SELECT groupname                        AS "그룹명"
     , userid                           AS "사용자 아이디"
     , SUM(amount)                      AS "총 구매 수량"
     , GROUPING_ID(groupname, userid)   AS "추가행 여부"
FROM buytbl
WHERE 1 = 1
GROUP BY CUBE(userid, groupname)
ORDER BY groupname
       , userid
;
