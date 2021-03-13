
--
SELECT employee_id
     , hire_date
FROM employees
WHERE 1 = 1
ORDER BY hire_date
;

--
SELECT *
FROM (
    SELECT employee_id
         , hire_date
    FROM employees
    WHERE 1 = 1
    ORDER BY hire_date
)
WHERE 1 = 1 
AND ROWNUM <= 5
;

--
SELECT *
FROM employees SAMPLE(5)
WHERE 1 = 1
-- AND department_id = '50'
;

