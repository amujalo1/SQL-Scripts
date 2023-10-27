--Napisati upit koji će prikazati naziv 
--zaposlenog i platu za sve zaposlene koji imaju
--platu veću od 2456. 

SELECT 
	first_name || ' ' || last_name "Zaposleni",
	salary "Plata"
FROM employees WHERE salary > 2456;
