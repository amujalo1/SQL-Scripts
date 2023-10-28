--Modificirati upit 2 tako da se doda nova kolona koja će iz nove plata izdvojiti
--posljednje 2 cifre plate i prikazati kao novu kolonu koja će se zvati «ostatak plate».

SELECT 	
		employee_id "Sifra",
		first_name "Ime",
		last_name "Prezime",
		salary "Plata",
		TRUNC(salary*1.25) "Plata uvecana za 25%",
		SUBSTR(TO_CHAR(salary*1.25), -2) "Ostatak plate"
FROM EMPLOYEES;