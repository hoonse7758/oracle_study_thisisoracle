
--
SELECT userid               AS "사용자 아이디"
     , SUM(amount * price)  AS "총 구매액"
FROM buytbl
WHERE 1 = 1
GROUP BY userid
;

--
WITH cte_001( userid, total_price )
AS (
    SELECT userid
        , SUM(amount * price)
    FROM buytbl
    WHERE 1 = 1
    GROUP BY userid
)
SELECT userid       AS "사용자 아이디"
     , total_price  AS "총 구매액"
FROM cte_001
WHERE 1 = 1
ORDER BY total_price DESC
;

--
WITH cte_001( addr, max_height )
AS (
    SELECT addr
         , MAX(height)
    FROM usertbl
    WHERE 1 = 1
    GROUP BY addr
)
SELECT AVG(max_height)  AS "각지역 최장신자 평균"
FROM cte_001
WHERE 1 = 1
;

-- 
WITH 
cte_001( userid, user_total_amount )
AS (
    SELECT userid
         , SUM(amount * price)
    FROM buytbl
    WHERE 1 = 1
    GROUP BY userid
),
cte_002( all_total_amount )
AS (
    SELECT SUM(user_total_amount)
    FROM cte_001
    WHERE 1 = 1
),
cte_003( user_avg_amount )
AS (
    SELECT all_total_amount / ( SELECT COUNT(*) FROM buytbl )
    FROM cte_002
    WHERE 1 = 1
)
SELECT * 
FROM cte_003
WHERE 1 = 1
;

-- RECURSIVE CTE
CREATE TABLE emptbl (
    emp         NCHAR(3),
    manager     NCHAR(3),
    department  NCHAR(3)
)
;

--
INSERT INTO emptbl VALUES ( '나사장', '없음', '없음' );
INSERT INTO emptbl VALUES ( '김재무', '나사장', '재무부' );
INSERT INTO emptbl VALUES ( '김부장', '김재무', '재무부' );
INSERT INTO emptbl VALUES ( '이부장', '김재무', '재무부' );
INSERT INTO emptbl VALUES ( '우대리', '이부장', '재무부' );
INSERT INTO emptbl VALUES ( '지사원', '이부장', '재무부' );
INSERT INTO emptbl VALUES ( '이영업', '나사장', '영업부' );
INSERT INTO emptbl VALUES ( '한과장', '이영업', '영업부' );
INSERT INTO emptbl VALUES ( '최정보', '나사장', '정보부' );
INSERT INTO emptbl VALUES ( '윤차장', '최정보', '정보부' );
INSERT INTO emptbl VALUES ( '이주임', '윤차장', '정보부' );

-- 
WITH cte_emp ( empname, mgrname, dept, emplevel )
AS (
    -- ANCHOR
    (
        SELECT emp, manager, department, 0
        FROM emptbl
        WHERE 1 = 1
        AND manager = '없음'
    )
    -- RECURSIVE UNION
    UNION ALL
    (
        SELECT emptbl.emp
             , emptbl.manager
             , emptbl.department
             , cte_emp.emplevel + 1
        FROM emptbl
--        WHERE 1 = 1
        INNER JOIN cte_emp
        ON emptbl.manager = cte_emp.empname
    )
)
SELECT *
FROM cte_emp
WHERE 1 = 1
ORDER BY dept
       , emplevel
;

--
WITH cte_emp ( empname, mgrname, dept, emplevel )
AS (
    -- ANCHOR
    (
        SELECT emp, manager, department, 0
        FROM emptbl
        WHERE 1 = 1
        AND manager = '없음'
    )
    -- RECURSIVE UNION
    UNION ALL
    (
        SELECT emptbl.emp
             , emptbl.manager
             , emptbl.department
             , cte_emp.emplevel + 1
        FROM emptbl
--        WHERE 1 = 1
        INNER JOIN cte_emp
        ON emptbl.manager = cte_emp.empname
    )
)
SELECT CONCAT(RPAD('├', emplevel * 2 + 1, '─'), empname) AS "직원이름"
     , dept                                               AS "직원부서"
FROM cte_emp
WHERE 1 = 1
ORDER BY dept
       , emplevel
;
