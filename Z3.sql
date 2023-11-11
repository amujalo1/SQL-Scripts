--Napisati upit koji će prikazati najveću, najmanju, sumarnu i prosječnu platu za sve zaposlene.
--Vrijednosti zaokružiti na šest decimalnih mjesta. 

SELECT 
    Round(MAX(SALARY),6) AS "Najveca plata",
    Round(MIN(SALARY),6) AS "Najmanja plata",
    Round(SUM(SALARY),6) AS "Suma svih plata",
    TO_CHAR(AVG(SALARY),'999,999.999999') AS "Srednja plata"
FROM employees;