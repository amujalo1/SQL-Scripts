--Napisati upit koji će prikazati naziv, platu i posao zaposlenog
--za sve zaposlene koji nemaju nadređenog
SELECT 
	first_name || ' ' || last_name "Naziv zaposlenog",
	SALARY "Plata",
	JOB_ID "posao zaposlenog"
FROM EMPLOYEES 
WHERE MANAGER_ID IS NULL;