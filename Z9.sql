--Napisati upit koji će prikazati broj zaposlnih koji su bili zaposleni u 1995, 1996,
--1997 i 1998, kao i ukupan broj zaposlenih u ovim godinama. Za labele uzeti 1995g,
--1996g, 1997g, 1998g i ukupan broj zaposlenih respektivno

SELECT 
    COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'), '2005', 1)) AS "2005g",
    COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'), '2006', 1)) AS "2006g",
    COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'), '2007', 1)) AS "2007g",
    COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'), '2008', 1)) AS "2008g",
    COUNT(*) AS "ukupno_zaposlenih"
FROM 
    employees
WHERE 
    TO_CHAR(hire_date, 'YYYY') IN ('2005', '2006', '2007', '2008');



