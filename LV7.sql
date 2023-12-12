--1. Napisati upit koji ?e prikazati naziv zaposlenog, naziv odjela i naziv posla za sve
--zaposlene koji rade u istom odjelu kao i Susan, isklju?uju?i Susan.

SELECT
    e.first_name || ' ' || e.last_name,
    d.department_name,
    j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id AND e.job_id = j.job_id AND
    e.department_id = (
    SELECT department_id
    FROM employees 
    WHERE first_name = 'Susan') AND e.first_name <> 'Susan';

--2. Napisati upit koji ?e prikazati šifru, ime, prezime, platu za sve zaposlene koji
--zara?uju platu ve?u od prosje?ne plate svih zaposlenih iz odjela 30 i 90. 
SELECT 
    employee_id,
    first_name,
    last_name,
    salary
FROM employees
WHERE salary > (
    SELECT
        AVG(salary)
    FROM employees 
    WHERE employee_id in (30, 90)
);
--3.Napisati upit koji ?e prikazati sve podatke o zaposlenim za sve zaposlene koji rade u
--istom odjelu kao i neki od zaposlenih koji u imenu, na bilo kom mjestu, sadrže slovo «C»
SELECT *
FROM employees
WHERE department_id = ANY (
    SELECT department_id
    FROM employees
    WHERE first_name LIKE '%C%');
--4. Napisati upit koji ?e prikazati šifru i naziv zaposlenog, kao i naziv posla za sve
--zaposlene koji rade u odjelu koji je locairan u Torontu. 
SELECT e.employee_id,
    e.first_name || ' ' || e.last_name,
    j.job_title
    FROM employees e, jobs j
    WHERE e.JOB_ID = j.job_id
    AND  department_id = any (
        SELECT d.department_id
        FROM departments d, locations l 
        WHERE d.location_id = l.location_id AND l.city = 'Toronto');
--5. Napisati upit koji ?e prikazati sve podatke o zaposlenim koji izvještavaju King-a. 
SELECT * 
FROM employees
where manager_id = any (
    SELECT employee_id
    FROM employees 
    WHERE first_name || ' ' || last_name = 'Steven King');
--6. Modificirati upit pod rednim brojem 3 tako da prikazuje samo one zaposlene koji
--dobivaju platu ve?u od prosje?ne plate svih zaposlenih iz doti?nog odjela u kojem
--dati zaposlenik radi.
SELECT *
FROM employees e
WHERE e.department_id = ANY (
    SELECT department_id
    FROM employees
    WHERE first_name LIKE '%C%')
    AND e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2 WHERE e2.department_id = e.department_id);
--7. Napisati upit koji ?e prikazati naziv zaposlenog, naziv odjela i platu za sve one
--zaposlene koji pripadaju istom odjelu i zara?uju istu platu kao i neki od zaposlenih
--koji dobiva dodatak na platu, isklju?uju?i one zaposlene koji dobivaju dodatak na
--platu. 
SELECT e.first_name || ' ' || e.last_name,
    d.department_name,
    e.salary
FROM employees e, departments d 
WHERE e.department_id = d.department_id
AND (nvl(e.department_id,0),e.salary) IN  (
    SELECT NVL(department_id,0), salary
    FROM employees WHERE commission_pct IS NOT NULL)
    AND commission_pct IS NULL;
--8. Napisati upit koji ?e prikazati naziv zaposlenog, naziv odjela, platu i grad za svakog
--zaposlenog koji ima istu platu i dodatak na platu kao i neki od zaposlenih koji rade u Rimu. 
SELECT e.first_name || ' ' || e.last_name,
    d.department_name,
    e.salary,
    l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id 
AND d.location_id = l.location_id
AND (e.salary, NVL(commission_pct,0)) IN (
    SELECT e2.salary, NVL(e2.commission_pct,0)
    FROM employees e2, departments d2, locations l2
    WHERE e2.department_id = d2.department_id
    AND d2.location_id = l2.location_id
    AND l2.city = 'Oxford');
--9. Napisati upit koji ?e prikazati naziv zaposlenog, datum zaposlenja i platu za sve
--zaposlene koji imaju istu platu i dodatak na platu kao i Scott. 
SELECT 
    first_name || ' ' || last_name,
    hire_date,
    salary
FROM employees
WHERE (salary, Nvl(commission_pct, 0)) = (SELECT salary, Nvl(commission_pct, 0)
                                          FROM employees
                                          WHERE last_name = 'Austin');
--10. Napisati upit koji ?e prikazati samo one zaposlene koji zara?uju platu ve?u od plate
--svih iz odjala za prodaju. Rezultat sortirati po plati od najve?e do najmanje. 
SELECT *
FROM  employees
WHERE salary > ALL (
    SELECT e.salary
    FROM employees e, departments d
    WHERE e.department_id = d.department_id AND d.department_name LIKE '%Sale%')
ORDER BY salary DESC;
--11. Napisati upit koji će prikazati naziv zaposlenog, naziv odjela, naziv posla i grad za
--sve zaposlene koji primaju platu veću od prosjećne plate svojih svih šefova koji
--imaju dodatak na platu i rade u istom odjelu kao i dotični zaposlenik.
select 
    e.first_name || ' ' || e.last_name naziv,
    d.department_name naziv_odjela,
    j.job_title naziv_posla,
    l.city grad
from employees e, departments d, locations l, jobs j
where e.department_id = d.department_id and l.location_id = d.location_id and e.job_id = j.job_id
and e.salary > (
    select avg(t.salary)
    from employees t
    where t.employee_id = e.manager_id
    and t.commission_pct is not null
    and t.department_id = e.department_id );
--12. Napisati upit koji će prikazati šifru i naziv zaposlenog, šifru i naziv odjela, platu,
--prosječnu, minimalnu i maksimalnu platu odjela u kojem zaposlenik radi, kao i
--minimalnu, maksimalnu i prosječnu platu na nivou firme za sve zaposlene koji
--imaju platu veću od minimalne prosječne plate svih šefova u odjelu u kojim dati zaposlenik radi.
SELECT DISTINCT e.employee_id, e.first_name || ' ' || e.last_name, d.department_id, d.department_name, e.salary,
       plate.average, plate.minimum, plate.maximum,
       plate2.minimum, plate2.maximum, plate2.average
FROM employees e, departments d,
      -- minimalna, maksimalna i prosjecna plata odjela u kojem zaposlenik radi
     (SELECT Avg(e2.salary) AS average, Min(e2.salary) AS minimum, Max(e2.salary) AS maximum, e2.department_id AS department_id
      FROM employees e2
      GROUP BY department_id) plate,

      -- minimalna, maksimalna i prosjecna plata na nivou firme
     (SELECT Min(e3.salary) AS minimum, Max(e3.salary) AS maximum, Avg(e3.salary) AS average, e3.salary AS plata
      FROM employees e3
      GROUP BY e3.salary) plate2,

      -- minimalna prosjecna plata svih sefova po odjelima
     (SELECT Min(plate3.average) AS minimum, plate3.department_id AS department_id
      -- prosjecna plata svih sefova na nivou firme
      FROM (SELECT Avg(e4.salary) AS average, e4.department_id AS department_id
            FROM employees e4
            -- osiguravanje da dobijemo samo zaposlenike koji su sefovi
            WHERE e4.employee_id IN (SELECT DISTINCT e5.employee_id
                                     FROM employees e5, employees e6
                                     WHERE e5.employee_id = e6.manager_id)   
            GROUP BY e4.department_id) plate3
      GROUP BY plate3.department_id) plate4

WHERE e.department_id = d.department_id
      -- osiguravanje da dobijemo prosjecnu platu samo za odjel u kojem zaposlenik radi
      AND e.department_id = plate.department_id
      -- osiguravanje da minimalna prosjecna plata bude samo za sefove iz odjela zaposlenika
      AND e.department_id = plate4.department_id
      -- osiguravanje da u racun za nivo firme udu samo plate vece od minimalne prosjecne plate sefova
      AND plate2.plata > plate4.minimum;