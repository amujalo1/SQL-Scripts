--Napisti upit koji će prikazati naziv zaposlenog 
--i šifru odjela za šifru zaposlenog 102.
SELECT 
	first_name || ' ' || last_name "Naziv zaposlenog",
	DEPARTMENT_ID "Sifra odjela"
FROM employees WHERE EMPLOYEE_ID = 102; 
