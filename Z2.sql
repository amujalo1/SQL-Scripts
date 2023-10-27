--Napisati jedinstvenu listu svih poslova iz odjela 30.

SELECT distinct
	e.first_name || ' ' || e.last_name "Naziv zaposlenog",
FROM employees e, DEPARTMENTS d WHERE d.department_id=e.DEPARTMENT_id AND d.department_id=30;
SELECT * FROM DEPARTMENTS;