--Napisati upit koji će prikazati naziv zaposlenog 
--za sve one zaposlene koji imaju dva slova «l» u nazivu
--(naziv se sastoji od imena i prezimena zaposlenog). 

SELECT 
	first_name || ' ' || last_name "Naziv zaposlenog"
FROM EMPLOYEES 
WHERE first_name || ' ' || last_name LIKE  '%l%l%' AND first_name || ' ' || last_name NOT LIKE  '%l%l%l%';