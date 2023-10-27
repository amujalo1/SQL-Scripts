--Napisati upit koji će prikazati naziv zaposlenog, platu i dodatak na platu
--za sve one zaposlene koji su stekli dodatak na platu.
--Sortirati podatke u opadajućem poretku po plati i dodatku na platu.

SELECT 
	first_name || ' ' || last_name "Naziv zaposlenog",
	salary "Plata",
	commission_pct "Dodatak na platu"
FROM EMPLOYEES 
WHERE commission_pct IS NOT NULL 
ORDER BY (SALARY + SALARY*COMMISSION_PCT) DESC;

