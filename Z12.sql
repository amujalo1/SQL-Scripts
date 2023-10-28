--Napisati upit koji će prikazati sve zaposlene s stepenom posla. 
--Stepen posla potrebnoa je uraditi prema sljedećoj specifikaciji:
--President -> A
--Manager -> B
--Analyst -> C
--Sales manager -> D
--Programmer -> E
--Ostali -> X


SELECT
    e.first_name || ' ' || e.last_name AS "Naziv zaposlenog",
    j.JOB_TITLE AS "Posao",
    CASE 
        WHEN j.JOB_TITLE = 'President' THEN 'A'
        WHEN j.JOB_TITLE = 'Manager' THEN 'B'
        WHEN j.JOB_TITLE = 'Analyst' THEN 'C'
        WHEN j.JOB_TITLE = 'Sales Manager' THEN 'D'
        WHEN j.JOB_TITLE = 'Programmer' THEN 'E'
        ELSE 'X'
    END AS "Stepen posla"
FROM employees e
JOIN jobs j ON e.JOB_ID=j.JOB_ID;