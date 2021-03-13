
--
ALTER TABLE usertbl
      ADD   homepage  VARCHAR(30)
            DEFAULT   'http://www.hanbit.co.kr'
            NULL
;

--
ALTER TABLE usertbl
      ADD  
      (
            homeaddr  NVARCHAR2(20)
          , postnum   VARCHAR(5)
      )
;

--
SELECT *
  FROM usertbl
 WHERE 1 = 1
;

--
ALTER TABLE usertbl
      DROP  COLUMN   homeaddr
;

--
ALTER TABLE usertbl
      DROP
      (
            homepage
          , postnum
      )
;

--
ALTER TABLE usertbl
      RENAME COLUMN username TO uname
;

--
ALTER TABLE  usertbl
      MODIFY
      (
             addr     NVARCHAR2(10)   NULL
      )
;

--
ALTER TABLE usertbl
      DROP  PRIMARY KEY
;

--
