--Napisati upit koji će prikazati broj menadžera, bez njihovog prikazivanja. 

SELECT
    COUNT(DISTINCT manager_id) "Broj menadžera"
FROM employees;
