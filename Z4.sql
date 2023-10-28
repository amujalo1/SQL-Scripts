--Napisati upit koji će prikazati naziv zaposlenog, datum zaposlenja i datum prvog
--ponedjeljka nakon 6 mjeseci rada zaposlenog. Datume predstaviti u formatu naziv
--dana – naziv mjeseca, godina.

SELECT 
		first_name || ' ' || last_name "Naziv zaposlenog",
		to_char(hire_date, 'dd - month yyyy') "Datum zaposlenja",
		next_day(add_months(hire_date,6),'MONDAY')
FROM EMPLOYEES;
		