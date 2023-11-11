--Modificirati prethodni upit tako da pokazuje maksimalnu, minimalnu i prosječnu
--platu po poslovima.

SELECT 
    j.JOB_TITLE AS "Naziv posla",
    Round(MAX(SALARY),6) AS "Najveca plata",
    Round(MIN(SALARY),6) AS "Najmanja plata",
    Round(SUM(SALARY),6) AS "Suma svih plata",
    TO_CHAR(AVG(SALARY),'999,999.999999') AS "Srednja plata"
FROM employees e, jobs j
WHERE e.JOB_ID = j.job_id
GROUP BY j.JOB_TITLE;