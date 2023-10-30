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
    DECODE(j.JOB_TITLE, 
    'President', 'A',
    'Manager', 'B',
    'Analyst', 'C',
    'Sales Manager', 'D',
    'Programmer', 'E', 
    'X') AS "Stepen posla"
FROM employees e
JOIN jobs j ON e.JOB_ID=j.JOB_ID;