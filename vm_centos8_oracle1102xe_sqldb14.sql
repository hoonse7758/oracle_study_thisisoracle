
--
CREATE OR REPLACE PROCEDURE cursorproc
AS
    v_height    NUMBER          ; 
    v_cnt       NUMBER  :=  0   ;
    v_total     NUMBER  :=  0   ;
    
    CURSOR      usercursor  IS
                            SELECT
                                    height
                              FROM  usertbl
                             WHERE  1 = 1
  ;
BEGIN
    OPEN    usercursor
    ;
    
    LOOP
        FETCH   usercursor  INTO    v_height
        ;
        
        EXIT
                WHEN    usercursor%NOTFOUND
        ;
        
        v_total :=  v_total +   v_height        ;
        v_cnt   :=  v_cnt   +   1               ;
        
        DBMS_OUTPUT.PUT_LINE(v_cnt || ' / ' || v_height || ' / ' ||v_total)
        ;
    END LOOP
    ;
    
    CLOSE   usercursor
    ;
    
    DBMS_OUTPUT.PUT_LINE('회원 키의 총합 ==> ' || v_total)
    ;
    DBMS_OUTPUT.PUT_LINE('회원 키의 평균 ==> ' || (v_total / v_cnt))
    ;
END     cursorproc
;

--
SET SERVEROUTPUT ON ;


--
EXECUTE cursorproc()    ;


--
ALTER   TABLE   usertbl
        ADD
                grade   NVARCHAR2(5)
;

--
CREATE OR REPLACE PROCEDURE gradeproc
AS
        v_id        CHAR        (8)         ;
        v_total     NUMBER      (5) :=  0   ;
        v_grade     NVARCHAR2   (5)         ;
        
        CURSOR      usercursor  IS
                              SELECT
                                        t01.userid
                                      , SUM(t00.price * t00.amount)
                                FROM    buytbl  t00
                    RIGHT OUTER JOIN    usertbl t01
                                  ON    t00.userid = t01.userid
                            GROUP BY    
                                        t01.userid
        ;
BEGIN
    OPEN    usercursor
    ;
    
    LOOP
            FETCH   usercursor  
            INTO    
                    v_id
                  , v_total    
            ;
            
            EXIT
                    WHEN    usercursor%NOTFOUND
            ;
            
            CASE
                    WHEN    ( v_total >= 1500 ) THEN
                        v_grade :=  '최우수회원' ;
                    WHEN    ( v_total >= 1000 ) THEN
                        v_grade :=  '우수회원'  ;
                    WHEN    ( v_total >=    1 ) THEN
                        v_grade :=  '일반회원'  ;
                    ELSE
                        v_grade :=  '유령회원'  ;
            END CASE
            ;
            
            UPDATE  usertbl
               SET  grade = v_grade
             WHERE  1 = 1
               AND  userid = v_id
            ;
            
    END LOOP
    ;
    
    CLOSE   usercursor
    ;
END     gradeproc
;

--
EXEC gradeproc()    ;

--
SELECT
        *
  FROM  usertbl
 WHERE  1 = 1
;

--
          SELECT
                    t01.userid
                  , SUM(t00.price * t00.amount)
            FROM    buytbl  t00
RIGHT OUTER JOIN    usertbl t01
              ON    t00.userid = t01.userid
        GROUP BY    
                    t01.userid
;

