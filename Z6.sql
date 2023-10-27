--Napisati upit koji će prikazati naziv zaposlenog, 
--naziv šefa i grad šefa u kojem radi.
--Za labele kolona uzeti Naziv zaposlenog, Šifra zaposlenog,
--Naziv šefa, Šifra šefa, Grad šefa, respektivno.

SELECT 
	e1.first_name || ' ' || e1.last_name "Naziv zaposlenog",
	e1.employee_id "Šifra zaposlenog",
	e2.first_name || ' ' || e2.last_name "Naziv šefa",
	e2.employee_id "Šifra šefa",
	l.city "Grad šefa"
FROM employees e1,employees e2, departments d, locations l
WHERE e1.manager_id = e2.employee_id AND e2.department_id = d.department_id AND d.location_ID = l.location_ID;
