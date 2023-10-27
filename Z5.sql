--Napisati upit koji će prikazati naziv, posao, broj
--i naziv odjela za sve zaposlene koji rade u Seattle-u. 

SELECT 
	e.first_name,
	e.last_name,
	j.job_title,
	l.postal_code,
	d.department_name
FROM EMPLOYEES e, DEPARTMENTS d, jobs j, locations l
WHERE l.city = 'Seattle' AND e.department_id=d.department_id AND e.JOB_ID = j.JOB_ID AND d.location_ID=l.location_ID;