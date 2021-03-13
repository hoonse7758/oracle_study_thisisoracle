
--
CREATE TABLE bigemployees
(
       empno               NUMBER     (10)         PRIMARY KEY
     , birth_date          DATE                    NOT NULL
     , first_name          VARCHAR    (20)         NOT NULL
     , last_name           VARCHAR    (20)         NOT NULL
     , gender              CHAR       (1)          NOT NULL
     , hire_date           DATE                    NOT NULL
)
;


-- AFTER IMPORT FROM bigemployees.csv FILE
SELECT COUNT(*)
  FROM bigemployees
 WHERE 1 = 1
;

--
SELECT *
  FROM bigemployees
 WHERE 1 = 1
   AND ROWNUM <= 10
;


--
