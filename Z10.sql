--Napisati upit koji će prikazati naziv i datum zaposlenja 
--za sve radnike koji su zaposeleni poslije Blake-a. 

SELECT e1.first_name || ' ' || e1.last_name "Naziv",
	   e1.HIRE_DATE "Datum zaposlenja"
FROM employees e1 
JOIN employees e2 ON e1.HIRE_DATE > e2.HIRE_DATE
WHERE e2.last_name = 'Bates';

