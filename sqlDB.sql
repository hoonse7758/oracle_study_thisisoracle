

--
CREATE TABLE usertbl
(
    userid      CHAR(8) NOT NULL PRIMARY KEY,
    username    NVARCHAR2(10) NOT NULL,
    birthyear   NUMBER(4) NOT NULL,
    addr        NCHAR(2) NOT NULL,
    mobile1     CHAR(3),
    mobile2     CHAR(8),
    height      NUMBER(3),
    mdate       DATE
)
;


-- 
CREATE TABLE buytbl
(
    idnum       NUMBER(8) NOT NULL PRIMARY KEY,
    userid      CHAR(8) NOT NULL,
    prodname    NCHAR(6) NOT NULL,
    groupname   NCHAR(4),
    price       NUMBER(8) NOT NULL,
    amount      NUMBER(3) NOT NULL,
    
    FOREIGN KEY (userid) REFERENCES usertbl(userid)
)
;


--
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-08-08');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-04-04');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-07-07');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-04-04');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL, NULL, 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-09-09');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL, NULL, 170, '2005-05-05');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-03-03');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '55555555', 176, '2013-05-05');


-- 
CREATE SEQUENCE idseq;
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'KBS', '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'JYP', '모니터', '전자', 200, 1);
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'BBK', '모니터', '전자', 200, 5);
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'KBS', '청바지', '의류', 50, 3);
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'BBK', '메모리', '전자', 80, 10);
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'SSK', '책', '서적', 15, 5);
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'EJW', '책', '서적', 15, 2);
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'EJW', '청바지', '의류', 50, 1);
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'BBK', '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'EJW', '책', '서적', 15, 1);
INSERT INTO buytbl VALUES(idseq.NEXTVAL, 'BBK', '운동화', NULL, 30, 2);


--
COMMIT ;


--
SELECT *
FROM usertbl
WHERE 1 = 1
;


--
SELECT *
FROM buytbl
WHERE 1 = 1
;

