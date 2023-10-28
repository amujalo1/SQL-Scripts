--Napisati upit koji će prikazati naziv, posao, naziv odjela, 
--platu i stepene plate za sve zaposlene kod kojih stepen plate
--nije u rasponu kada se na platu zaposlenog doda dodatak na platu. 


SELECT e.first_name || ' ' || e.last_name "Naziv",
       j.job_title AS "Posao",
       d.department_name AS "Naziv odjela",
       e.salary AS "Plata",
       e.commission_pct AS "Dodatak na platu",
       (e.SALARY+NVL(e.COMMISSION_PCT,0)*e.SALARY) "Ukupna plata",
       j.min_salary AS "Minimalna plata za posao",
       j.max_salary AS "Maksimalna plata za posao"
FROM employees e
JOIN jobs j ON e.JOB_ID = j.JOB_ID 
JOIN departments d ON e.department_id = d.department_id
WHERE (e.salary + COALESCE(e.salary * NVL(e.commission_pct, 0), 0)) NOT BETWEEN j.min_salary AND j.max_salary;
