--Napisati upit koji će prikazati naziv zaposlenog
--i šifru odjela za sve zaposlene iz odjela 10 i 30
--sortirano po prezimenu zaposlenog.

SELECT 
	first_name || ' ' || last_name "Naziv zaposlenog",
	department_id "Sifra odjela"
FROM employees
WHERE DEPARTMENT_ID IN (10, 30)
ORDER BY LAST_NAME ASC;