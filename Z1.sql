--Napisati upit koji će prikazati sumu iznosa datataka na platu, broj zaposlenih koji
--dobivaju dodatak na platu, kao i ukupan broj zaposlenih. 

SELECT
    SUM(COMMISSION_PCT*SALARY) "Suma iznosa dodataka",
    COUNT(COMMISSION_PCT) "Br. zaposlenih sa dodatkom",
    COUNT(*) "Ukupan broj zaposlenih"
FROM employees;