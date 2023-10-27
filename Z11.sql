--Napisati upit koji će prikazati naziv, platu i dodatak na platu
--za sve zaposlene čiji je iznos dodatka na platu veći od 
--plate zaposlenog umanjene za 80%. 

SELECT 
	first_name || ' ' || last_name "Naziv zaposlenog",
	salary "Plata",
	commission_pct "Dodatak na platu"
FROM employees
WHERE (NVL(COMMISSION_PCT,0)*salary) > (0.2*salary);