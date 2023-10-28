--Napisati upit koji će prikazati naziv zaposlenog, 
--naziv šefa i grad šefa u kojem radi.
--Za labele kolona uzeti Naziv zaposlenog, Šifra zaposlenog,
--Naziv šefa, Šifra šefa, Grad šefa, respektivno.


SELECT
    e1.employee_id AS "Šifra zaposlenog",
    e1.first_name || ' ' || e1.last_name AS "Naziv zaposlenog",
    e2.employee_id AS "Šifra šefa",
    e2.first_name || ' ' || e2.last_name AS "Naziv šefa",
    l.city AS "Grad šefa"
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.employee_id
JOIN departments d ON e2.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;