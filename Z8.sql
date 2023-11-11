--Napisati upit koji će prikazati naziv odjela, naziv grada, broj zaposlenih i prosječnu
--platu za sve zaposlene u dotičnom odjelu. 

SELECT 
	d.DEPARTMENT_NAME AS "Naziv odjela",
	l.CITY AS "Naziv grada",
	Count(e.EMPLOYEE_ID) AS "Broj zaposlenih",
	ROUND(AVG(e.SALARY),3) "Prosjecna plata" 
FROM EMPLOYEES e, DEPARTMENTS d, locations l
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND d.LOCATION_ID  = l.LOCATION_ID
GROUP BY d.DEPARTMENT_NAME , l.CITY;