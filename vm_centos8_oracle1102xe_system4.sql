
--
CREATE  USER                    tabledb
        IDENTIFIED BY           1234
        DEFAULT     TABLESPACE  USERS
        TEMPORARY   TABLESPACE  TEMP
;

--
GRANT   CONNECT
      , RESOURCE
      , DBA
TO tabledb
;


--
