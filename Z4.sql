--Napisati upit koji će prikazati naziv zaposlenog
--i naziv odjela za sve zaposlene koji u imenu sadrže
--slovo A na bilo kom mjestu.

SELECT 
	e.first_name,
	e.last_name,
	d.department_name
FROM EMPLOYEES e, DEPARTMENTS d
WHERE e.department_id=d.department_id AND e.first_name LIKE '%a%';