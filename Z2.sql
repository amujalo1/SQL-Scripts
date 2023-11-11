--Napisati upit koji će prikazati broj zaposlenih po poslovima i organizacionim jedinicama. 
--Za labele uzeti naziv posla, naziv organizacione jedinice i broj uposlenih respektivno.

SELECT 
    j.JOB_TITLE AS "Naziv posla",
    d.DEPARTMENT_NAME AS "naziv organizacione jedinice",
    COUNT(e.employee_id) AS "broj uposlenih respektivno"
from departments d, employees e, jobs j
WHERE e.JOB_ID = j.JOB_ID AND e.DEPARTMENT_ID=d.DEPARTMENT_ID
GROUP BY j.job_title, d.department_name;