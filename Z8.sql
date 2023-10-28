--Napisati upit koji će prikazati naziv zaposlenog i dužinu naziva zaposlenog za sve
--zaposlene čija imena počinju sa slovima A, J, M i S. Naziv zaposlenog treba
--prikazati tako da je prvi karakter naziva predstavljen malim slovom, a ostali
--karakteri velikom slovima.

SELECT 
	LOWER(SUBSTR(first_name, 1, 1)) || UPPER(SUBSTR(first_name,2))  || ' ' || UPPER(last_name) AS "Naziv zaposlenog",
	LENGTH(first_name || ' ' || last_name) AS "Duzina naziva zaposlenog"
FROM EMPLOYEES
WHERE SUBSTR(first_name, 1, 1) IN ('A', 'J', 'M', 'S');