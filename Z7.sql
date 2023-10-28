--Modificirati upit pod rednim brojem šest, da prikazuje i manager-a King-a
--koji nema predpostavljenog.

SELECT
    e1.employee_id AS "Šifra zaposlenog",
    e1.first_name || ' ' || e1.last_name AS "Naziv zaposlenog",
    e2.employee_id AS "Šifra šefa",
    e2.first_name || ' ' || e2.last_name AS "Naziv šefa",
    COALESCE(l.city, 'Nema šefa') "Grad šefa"
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id
LEFT JOIN departments d ON e2.department_id = d.department_id
LEFT JOIN locations l ON d.location_id = l.location_id
WHERE e1.manager_id IS NULL OR e1.manager_id != 100;