--Napisati upit koji će prikazati naziv zaposlenog,
--naziv odjela i lokaciju za sve zaposlene koji 
--ne primaju dodataka na platu. 

SELECT 
 	e.first_name,
 	e.last_name,
 	d.department_name,
 	l.city
 FROM EMPLOYEES e, departments d, locations l
 WHERE e.commission_pct is null and e.employee_id=d.department_id and d.location_id=l.location_id;