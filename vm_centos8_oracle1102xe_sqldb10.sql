

--
CREATE TABLE bigtbl
             AS
             (
                     SELECT *
                       FROM hr.bigemployees
                      WHERE 1 = 1
             )
;

--
SELECT COUNT(*)
  FROM bigtbl
 WHERE 1 = 1
;

--
CREATE TABLE smalltbl
             AS
             (
                    SELECT *
                      FROM hr.employees
                     WHERE 1 = 1
             )
;

--
SELECT COUNT(*)
  FROM smalltbl
 WHERE 1 = 1
;

--
    SELECT 
           ROUND(AVG(EXTRACT(YEAR FROM t00.birth_date)), 0) 
           AS "D"
      FROM bigtbl   t00
CROSS JOIN smalltbl t01
;

--
CREATE MATERIALIZED VIEW my_avgyear
                         -- BUILD IMMEDIATE
                         AS
                         (
                                    SELECT
                                           ROUND(AVG(EXTRACT(YEAR FROM t00.birth_date)), 0) 
                                           AS "D"
                                      FROM bigtbl    t00
                                CROSS JOIN smalltbl  t01
                         )
;

--
SELECT *
  FROM my_avgyear
 WHERE 1 = 1
;

--
DROP MATERIALIZED VIEW my_avgyear ;

--
CREATE MATERIALIZED VIEW my_avgyear
                         BUILD DEFERRED
                         AS
                         (
                                    SELECT
                                           ROUND(AVG(EXTRACT(YEAR FROM t00.birth_date)), 0) 
                                           AS "D"
                                      FROM bigtbl    t00
                                CROSS JOIN smalltbl  t01
                         )
;

--
SELECT *
  FROM my_avgyear
 WHERE 1 = 1
;

--
EXECUTE DBMS_MVIEW.REFRESH(LIST => 'my_avgyear') ;

-- ADD VIRTUAL COLUMN
ALTER TABLE buytbl
        ADD sales GENERATED ALWAYS AS ( price * amount )
;

--
SELECT *
  FROM buytbl
 WHERE 1 = 1
;


--
CREATE MATERIALIZED VIEW    my_sumsales
                    BUILD   IMMEDIATE
                    REFRESH COMPLETE
                    ON COMMIT
                    AS
                    (
                            SELECT SUM(sales)
                              FROM buytbl
                             WHERE 1 = 1
                    )
;

--
SELECT *
  FROM my_sumsales
 WHERE 1 = 1
;

--
UPDATE buytbl
   SET price = price * 2
 WHERE 1 = 1
;

--
SELECT *
  FROM my_sumsales
 WHERE 1 = 1
;

--
COMMIT ;

--
SELECT *
  FROM my_sumsales
 WHERE 1 = 1
;

--
