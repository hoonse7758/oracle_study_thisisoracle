
--
CREATE TABLE tbl1
(
       a     NUMBER    (4)    PRIMARY KEY
     , b     NUMBER    (4)
     , c     NUMBER    (4)
)
;

--
SELECT *
  FROM user_indexes
 WHERE 1 = 1
;

--
    SELECT *
      FROM user_indexes      t00
INNER JOIN user_ind_columns  t01
        ON t00.index_name = t01.index_name
     WHERE 1 = 1
       AND t00.table_name = 'TBL1'
;

--
SELECT *
  FROM user_ind_columns
 WHERE 1 = 1
;

--
CREATE TABLE tbl2
(
       a     NUMBER    (4)    PRIMARY KEY
     , b     NUMBER    (4)    UNIQUE
     , c     NUMBER    (4)    UNIQUE
     , d     NUMBER    (4)
)
;

--
    SELECT *
      FROM user_indexes      t00
INNER JOIN user_ind_columns  t01
        ON t00.index_name = t01.index_name
     WHERE 1 = 1
       AND t00.table_name = 'TBL2'
;

--
CREATE TABLE btreetbl
(
       userid         CHAR           (8)
     , username       NVARCHAR2      (10)
)
;

--
INSERT INTO btreetbl VALUES ('LSG', '이승기') ;
INSERT INTO btreetbl VALUES ('KBS', '김범수') ;
INSERT INTO btreetbl VALUES ('KKH', '김경호') ;
INSERT INTO btreetbl VALUES ('JYP', '조용필') ;
INSERT INTO btreetbl VALUES ('SSK', '성시경') ;
INSERT INTO btreetbl VALUES ('LJB', '임재범') ;
INSERT INTO btreetbl VALUES ('YJS', '윤종신') ;
INSERT INTO btreetbl VALUES ('EJW', '은지원') ;
INSERT INTO btreetbl VALUES ('JKW', '조관우') ;
INSERT INTO btreetbl VALUES ('BBK', '바비킴') ;

--
SELECT 
       ROWID
     , SUBSTR(ROWID, 1, 6)
       AS data_obj_id
     , SUBSTR(ROWID, 7, 3)
       AS file_id
     , SUBSTR(ROWID, 10, 6)
       AS block_id
     , SUBSTR(ROWID, 16, 17 + 4)
       AS row_id
     , t00.*
  FROM btreetbl   t00
 WHERE 1 = 1
;

--
SHOW PARAMETER DB_BLOCK_SIZE ;

--
ALTER TABLE btreetbl
        ADD CONSTRAINT pk_btreetbl_userid
            PRIMARY KEY (userid)
;

--
INSERT INTO btreetbl VALUES ('FNT', '푸니타') ;
INSERT INTO btreetbl VALUES ('KAI', '카아이') ;

--
    SELECT *
      FROM user_indexes      t00
INNER JOIN user_ind_columns  t01
        ON t00.index_name = t01.index_name
     WHERE 1 = 1
       AND t00.table_name = 'USERTBL'
;

--
ALTER TABLE usertbl
        ADD CONSTRAINT pk_usertbl_userid
            PRIMARY KEY (userid)
;

--
ALTER TABLE buytbl
        ADD CONSTRAINT fk_usertbl_buytbl
            FOREIGN KEY (userid)
            REFERENCES usertbl(userid)
;

--
SELECT *
  FROM usertbl
 WHERE 1 = 1
;

--
    SELECT 
           t00.*
         , t01.*
      FROM user_indexes t00
INNER JOIN user_ind_columns t01
        ON t00.index_name = t01.index_name
     WHERE 1 = 1
       AND t00.table_name = 'USERTBL'
;

--
SELECT
       index_name        -- 인덱스 이름
     , leaf_blocks       -- 리프 블록에 할당된 블록 갯수
     , distinct_keys     -- 서로 다른 키의 갯수
     , num_rows          -- 테이블 행의 갯수
  FROM user_indexes
 WHERE 1 =  1
   AND table_name = 'USERTBL'
;

-- F10
SELECT *
  FROM usertbl
 WHERE 1 = 1
   AND userid = 'BBK'
;

-- F10
SELECT *
  FROM usertbl
 WHERE 1 = 1
   AND username = '바비킴'
;


--
CREATE INDEX idx_usertbl_addr
          ON usertbl (addr) 
;


--
    SELECT 
           t00.*
         , t01.*
      FROM user_indexes t00
INNER JOIN user_ind_columns t01
        ON t00.index_name = t01.index_name
     WHERE 1 = 1
       AND t00.table_name = 'USERTBL'
;

--
CREATE UNIQUE INDEX idx_usertbl_birthyear
                 ON usertbl (birthyear) 
;

--
CREATE UNIQUE INDEX idx_usertbl_username
                 ON usertbl (username) 
;

--
--
    SELECT 
           t00.*
         , t01.*
      FROM user_indexes t00
INNER JOIN user_ind_columns t01
        ON t00.index_name = t01.index_name
     WHERE 1 = 1
       AND t00.table_name = 'USERTBL'
;

--
INSERT INTO usertbl VALUES ('GPS', '김범수', 1983, '미국', NULL, NULL, 162, NULL) ;

--
CREATE INDEX idx_usertbl_username_birthyear
          ON usertbl ( 
                  username
                , birthyear 
            )
;

--
DROP INDEX idx_usertbl_username ;

--
    SELECT 
           t00.*
         , t01.*
      FROM user_indexes t00
INNER JOIN user_ind_columns t01
        ON t00.index_name = t01.index_name
     WHERE 1 = 1
       AND t00.table_name = 'USERTBL'
;

--
SELECT *
  FROM usertbl
 WHERE 1 = 1
   AND username = '윤종신'
   AND birthyear = '1969'
;

--
SELECT *
  FROM usertbl
 WHERE 1 = 1
   AND username = '윤종신'
;

--
CREATE INDEX idx_usertbl_mobile1
          ON usertbl 
             (
                     mobile1
             )
;

--
SELECT *
  FROM usertbl
 WHERE 1 = 1
   AND mobile1 = '011'
;

--
SELECT *
  FROM user_indexes
 WHERE 1 = 1
   AND table_name = 'USERTBL'
;

--
DROP INDEX idx_usertbl_addr ;
DROP INDEX idx_usertbl_mobile1 ;
DROP INDEX idx_usertbl_username_birthyear ;

--
DROP INDEX pk_usertbl_userid ;

--
ALTER TABLE usertbl
       DROP PRIMARY KEY
;

--
SELECT *
  FROM user_constraints
 WHERE 1 = 1
   AND owner = 'SQLDB'
   AND table_name = 'BUYTBL'
   AND constraint_type = 'R'
;

--
ALTER TABLE usertbl
       DROP PRIMARY KEY CASCADE
;

--
SELECT 
       COUNT(*) 
       AS CNT
  FROM hr.bigemployees
 WHERE 1 = 1
;

--
CREATE TABLE emp 
             AS 
                  SELECT 
                         *
                    FROM hr.bigemployees
                   WHERE 1 = 1
                ORDER BY 
                         DBMS_RANDOM.VALUE
;

--
CREATE TABLE emp_idx
             AS 
                  SELECT 
                         *
                    FROM hr.bigemployees
                   WHERE 1 = 1
                ORDER BY 
                         DBMS_RANDOM.VALUE
;

--
SELECT *
  FROM emp
 WHERE 1 = 1
   AND ROWNUM <= 5
;

--
SELECT *
  FROM emp_idx
 WHERE 1 = 1
   AND ROWNUM <= 5
;

--
SELECT 
       *
  FROM user_indexes
 WHERE 1 = 1
   AND table_name = 'EMP_IDX'
;

--
CREATE INDEX idx_empidx_empno
          ON emp_idx 
             (
                      empno
             )
;

--
SELECT 
       index_name
     , index_type
     , blevel
     , leaf_blocks
     , distinct_keys
     , num_rows
  FROM user_indexes
 WHERE 1 = 1
   AND table_name = 'EMP_IDX'
;

--
ALTER SYSTEM FLUSH BUFFER_CACHE ;
ALTER SYSTEM FLUSH SHARED_POOL ;

--
SELECT *
  FROM emp
 WHERE 1 = 1
   AND empno = '20000'
;

--
SELECT *
  FROM emp_idx
 WHERE 1 = 1
   AND empno = '20000'
;

--
ALTER SYSTEM FLUSH BUFFER_CACHE ;
ALTER SYSTEM FLUSH SHARED_POOL ;

--
SELECT *
  FROM emp
 WHERE 1 = 1
   AND empno < 10100
;


--
SELECT *
  FROM emp_idx
 WHERE 1 = 1
   AND empno < 10100
;


--
SELECT *
  FROM emp_idx
 WHERE 1 = 1
   AND empno < 300000
;

--
ALTER SYSTEM FLUSH BUFFER_CACHE ;
ALTER SYSTEM FLUSH SHARED_POOL ;

--
SELECT *
  FROM emp_idx
 WHERE 1 = 1
   AND empno * 1 = '20000'
;

--
SELECT *
  FROM emp_idx
 WHERE 1 = 1
   AND empno = '20000' / 1
;

--
SELECT 
       DISTINCT GENDER
  FROM emp
 WHERE 1 = 1
;

--
SELECT 
       *
  FROM user_indexes
 WHERE 1 = 1
   AND table_name = 'EMP'
;

--
CREATE INDEX idx_emp_gender 
          ON emp (gender) 
;

--
SELECT 
       index_name
     , leaf_blocks
     , distinct_keys
     , num_rows
  FROM user_indexes
 WHERE 1 = 1
   AND table_name = 'EMP'
;

--
ALTER SYSTEM FLUSH BUFFER_CACHE ;
ALTER SYSTEM FLUSH SHARED_POOL ;

--
SELECT 
       *
  FROM emp
 WHERE 1 = 1
   AND gender = 'M'
;