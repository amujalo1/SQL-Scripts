--Napisati upit koji će prikazati platu, ime, prezime
--i dodatak na platu za sve zaposlene koji imaju platu
--veću od 1500 i rade u odjelima 10 ili 30. Za labele kolona
--uzeti respektovno: mjesečna plata, ime zaposlenog,
--prezime zaposlenog i dodatak na platu.

SELECT 
	salary "mjesečna plata",
	first_name "ime zaposlenog",
	last_name "prezime zaposlenog",
	commission_pct "dodatak na platu"
FROM EMPLOYEES
WHERE SALARY > 1500 AND DEPARTMENT_ID IN (10, 30);
