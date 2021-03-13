

--
SELECT ASCII('A')
        AS ASCII_A
     , CHR(65)
        AS CHR_65
     , ASCIISTR('한')
        AS "ASCII_STR_한"
     , UNISTR('\D55C')
        AS UNISTR_D55C
FROM DUAL
;

--
SELECT LENGTH('한글의길이는?')
        AS LENGTH_UNISTR
     , LENGTH('AB')
        AS LENGTH_AB
     , LENGTHB('한글의길이는?')
        AS LENGTHB_UNISTR
     , LENGTHB('AB')
        AS LENGTHB_AB
FROM DUAL
;

--
SELECT CONCAT('이것이', '오라클'||'이지')
        AS CONCAT_THISISORCL
     , '이것이'||'오라클이여'||'!!'
        AS CONCAT_OPERATOR
FROM DUAL
;

--
SELECT INSTR('이것이 Oracle 이다. 이것도 오라클이다.', '이것')
        AS INSTR_EX01
     , INSTR('이것이 Oracle 이다. 이것도 오라클이다.', '이것', 2)
        AS INSTR_EX02
     , INSTRB('이것이 Oracle 이다. 이것도 오라클이다.', '이것', 2)
        AS INSTRB_EX01
FROM DUAL
;

--
SELECT LOWER('abcdefgHIJKL!@한글')
        AS EX_LOWER
     , UPPER('abcdefgHIJKL!@한글')
        AS EX_UPPER
     , INITCAP('THIS IS ORACLE')
        AS EX_INITCAP
FROM DUAL
;

--
SELECT REPLACE('이것이 Oracle 이다.', 'Oracle ', 'MariaDB')
        AS EX_REPLACE
FROM DUAL
;

-- 괴기스럽지만 이해는 됨
SELECT TRANSLATE('이것이 Oracle 이다.', '이.', '그!')
FROM DUAL
;

--
SELECT SUBSTR('대한민국만세삼창', -8, 7)
        AS substr_ex01
     , SUBSTR('대한민국만세삼창', -8, 9)
        AS substr_ex02
     , SUBSTR('대한민국만세삼창', -9, 7)
        AS substr_ex03
     , SUBSTR('대한민국만세삼창', 1, 7)
        AS substr_ex03
FROM DUAL
;

--
SELECT REVERSE('Oracle')
        AS reverse_ex
FROM DUAL
;

-- ?? PAD 는 이해안됨
SELECT LPAD('이것이', 15, '#')
        AS lpad_ex
     , RPAD('이것이', 15, '#')
        AS rpad_ex
FROM DUAL
;

--
SELECT LTRIM('      이거좀봐    낄낄')
        AS ex_ltrim
     , RTRIM('  개쩌냐 ? ? ? ? ? ? ?', ' ?')
        AS ex_rtrim
FROM DUAL
;

--
SELECT TRIM('    양옆펼쳐  ?')
        AS trim_ex01
     , TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋㅋ개웃곀ㅋㅋㅋㅋㅋ')
        AS trim_both
     , TRIM(LEADING 'ㅋ' FROM 'ㅋㅋㅋㅋ개웃곀ㅋㅋㅋㅋㅋ')
        AS trim_leading
     , TRIM(TRAILING 'ㅋ' FROM 'ㅋㅋㅋㅋ개웃곀ㅋㅋㅋㅋㅋ')
        AS trim_trailing
FROM DUAL
;

--
SELECT REGEXP_COUNT('이여 모든것들이여 이여몸의 것이여 될것이여다', '이여')
        AS ex_regexp_count
FROM DUAL
;

--
SELECT ABS(-55.5)
        AS abs_ex01
     , ABS(99.9)
        AS abs_ex02
FROM DUAL
;

--
SELECT CEIL(4.7)
        AS ex_ceil
     , FLOOR(4.7)
        AS ex_floor
     , ROUND(4.7)
        AS ex_round_01
     , ROUND(4.00076, 4)
        AS ex_round_02
FROM DUAL
;

--
SELECT EXP(1)
        AS ex_exp
     , LN(5)
        AS ex_ln
     , LOG(EXP(1), 5)
        AS ex_log
FROM DUAL
;

--
SELECT MOD(157, 10)
        AS ex_mod
FROM DUAL
;

--
SELECT POWER(2, 3)
        AS ex_power
     , SQRT(POWER(3,2))
        AS ex_sqrt
FROM DUAL
;

--
SELECT SIGN(-55.5)
        AS ex_sign_minus55
     , SIGN(0)
        AS ex_sign_zero
     , SIGN(1004.777)
        AS ex_sign_1004_777
FROM DUAL
;

--
SELECT 6789.123456
        AS ORIGINAL_VALUE
     , TRUNC(6789.123456, 2)
        AS ex_trunc_2
     , TRUNC(6789.123456, 5)
        AS ex_trunc_5
     , TRUNC(6789.123456, -2)
        AS ex_trunc_MINUS2
FROM DUAL
;

--
SELECT ADD_MONTHS('2020-01-01', 5)
        AS addmonth_ex01
     , ADD_MONTHS(SYSDATE, 5)
        AS addmonth_ex02
FROM DUAL
;

--
SELECT TO_DATE('2020-01-01') + 5
        AS addday_oper_ex01
     , SYSDATE - 5
        AS addday_oper_ex02
FROM DUAL
;

--
SELECT TO_CHAR(CURRENT_DATE, 'YYYY-MM-DD HH24:MI:SS')
        AS "CURRENT_DATE"
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
        AS "SYSDATE"
     , CURRENT_TIMESTAMP
FROM DUAL
;

--
SELECT EXTRACT(YEAR FROM SYSDATE)
        AS sysdate_year
     , EXTRACT(MONTH FROM SYSDATE)
        AS sysdate_month
     , EXTRACT(DAY FROM SYSDATE)
        AS sysdate_day
     , EXTRACT(DAY FROM TO_DATE('1990-05-11 11:05:44', 'YYYY-MM-DD HH24:MI:SS'))
        AS date_hours
FROM DUAL
;

--
SELECT LAST_DAY(TO_DATE('1990-05-11 11:05:44', 'YYYY-MM-DD HH24:MI:SS'))
        AS ex_last_day
FROM DUAL
;

--
SELECT NEXT_DAY(SYSDATE, '일')
        AS ex_nextday_sysdate
     , NEXT_DAY(TO_DATE('1990-05-11 11:05:44', 'YYYY-MM-DD HH24:MI:SS'), '일')
        AS ex_nextday_sysdate
FROM DUAL
;

--
SELECT MONTHS_BETWEEN(
            SYSDATE, 
            TO_DATE('1990-05-11 11:05:44', 'YYYY-MM-DD HH24:MI:SS')
        )
        AS ex_monthsbeetween
FROM DUAL
;

--
SELECT BIN_TO_NUM(1)
        AS bintonum_ex01
     , BIN_TO_NUM(1, 1)
        AS bintonum_ex02
     , BIN_TO_NUM(0, 0, 1)
        AS bintonum_ex03
     , BIN_TO_NUM(1, 0, 1)
        AS bintonum_ex04
     , BIN_TO_NUM(0, 0, 0)
        AS bintonum_ex04
FROM DUAL
;

--
SELECT NUMTODSINTERVAL(49.3, 'HOUR')
        AS numtodsinterval_ex01
     , NUMTODSINTERVAL(6009.3, 'SECOND')
        AS numtodsinterval_ex02
FROM DUAL
;

--
SELECT NUMTOYMINTERVAL(37, 'MONTH')
        AS numtoyminterval_ex01
     , NUMTOYMINTERVAL(1.6, 'YEAR')
        AS numtoyminterval_ex02
FROM DUAL
;