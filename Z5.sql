--Napisati upit koji će prikazati broj zaposlenih po poslovima. 

SELECT 
    j.JOB_TITLE AS "Naziv posla",
    COUNT(e.JOB_ID) "Broj zaposlenih"
FROM employees e, jobs j
where e.JOB_ID = j.job_id
GROUP BY j.JOB_TITLE;