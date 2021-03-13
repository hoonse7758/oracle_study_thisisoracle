

--
SELECT *
FROM usertbl
;

--
SELECT *
FROM usertbl
WHERE 1 = 1
AND username = '±è°æÈ£'
;

-- 
SELECT userid
     , username
FROM usertbl
WHERE 1 = 1
AND birthyear >= 1970
AND height >= 182
;

--
SELECT username
     , height
FROM usertbl
WHERE 1 = 1
AND height BETWEEN 180 AND 183
;

-- 
SELECT username
     , addr
FROM usertbl
WHERE 1 = 1
AND( 
        addr = '°æ³²'
    OR addr = 'Àü³²'
    OR addr = 'ÀüºÏ'
)
;

--
SELECT username
     , addr
FROM usertbl
WHERE 1 = 1
AND addr IN ('°æ³²', 'Àü³²', 'ÀüºÏ')
;


--
SELECT username
     , height
FROM usertbl
WHERE 1 = 1
AND username LIKE '±è%'
;

--
SELECT username
     , height
FROM usertbl
WHERE 1 = 1
AND username LIKE '_Á¾½Å'
;

-- SUBQUERY
SELECT username
     , height
FROM usertbl
WHERE 1 = 1
AND height <= (
    SELECT height
    FROM usertbl
    WHERE 1 = 1
    AND username = '±è°æÈ£'
)
;

--
SELECT username
     , height
FROM usertbl
WHERE 1 = 1
AND height >= ANY (
    SELECT height
    FROM usertbl
    WHERE 1 = 1
    AND addr = '°æ³²'
)
;

--
SELECT username
     , height
FROM usertbl
WHERE 1 = 1
AND height = ANY (  -- EQUIVALENT TO >> IN ( ... SUBQRY ... )
    SELECT height
    FROM usertbl
    WHERE 1 = 1
    AND addr = '°æ³²'
)
;

-- ORDER BY
SELECT *
FROM usertbl
WHERE 1 = 1
ORDER BY mdate      DESC
       , username
;

-- 
SELECT DISTINCT addr
FROM usertbl
WHERE 1 = 1
ORDER BY addr
;

-- TABLE COPY
CREATE TABLE buytbl2 AS (
    SELECT *
    FROM buytbl
    WHERE 1 = 1
)
;

--
SELECT *
FROM buytbl2
WHERE 1 = 1
;

--
