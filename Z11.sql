--Napisati upit koji će prikazati naziv i datum zaposlenja zaposlenog, naziv i datum
--zaposlenja šefa zaposlenog, za sve zaposlene koji su se zaposlili prije svog šefa.  

SELECT 
	e1.first_name || ' ' || e1.last_name "Naziv zaposlenog",
	e1.HIRE_DATE "Datum zaposlenja",
	e2.first_name || ' ' || e2.last_name "Naziv šefa",
	e2.HIRE_DATE "Datum zaposlenja šefa"
FROM employees e1
JOIN employeEs e2 ON e1.manager_id = e2.employee_id
WHERE e1.HIRE_DATE < e2.HIRE_DATE;