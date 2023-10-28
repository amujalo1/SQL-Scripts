--Napisati upit koji će prikazati naziv zaposlenog, šifru odjela, i sve zaposlene koji
--rade u istom odjelu kao i uzeti zaposlenik. Za kolone uzeti odgovarajuće labele. 

SELECT e1.first_name || ' ' || e1.last_name AS "Naziv zaposlenog",
       e1.department_id AS "Šifra odjela",
       e2.first_name || ' ' || e2.last_name AS "Zaposlenici u istom odjelu"
FROM employees e1
JOIN employees e2 ON e1.department_id = e2.department_id
WHERE e1.employee_id = 124;
SELECT * FROM jobs;