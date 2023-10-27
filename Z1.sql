--Napisati upit koji će prikazati naziv zaposlenog,
--šifru i naziv odjela za sve zaposlene. 

SELECT 
	e.first_name,
	e.last_name,
	e.EMPLOYEE_ID,
	d.DEPARTMENT_NAME
FROM EMPLOYEES e, DEPARTMENTS d
WHERE e.DEPARTMENT_ID=d.DEPARTMENT_ID;