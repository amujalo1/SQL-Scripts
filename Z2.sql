--Napisati upit koji će prikazati šifru, ime, prezime, platu i platu uvećanu za 25%
--kao cijeli broj. Labela za novu platu je «plata uvećana za 25%».

SELECT 	
		employee_id "Sifra",
		first_name "Ime",
		last_name "Prezime",
		salary "Plata",
		TRUNC(salary*1.25) "Plata uvecana za 25%"
FROM EMPLOYEES;