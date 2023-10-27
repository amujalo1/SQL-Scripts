--Napisati upit koji će prikazati naziv
--zaposlenog (predstavljeno kao jedna kolona)
--«Zaposleni», posao i datum zaposlenja za sve
--zaposlene koji su počeli da rade u
--periodu od 11.01.1996 do 22.02.1997. 

SELECT 
	first_name || ' ' || last_name "Naziv zaposlenog",
	JOB_ID "Posao",
	HIRE_DATE "Datum zaposlenja"
FROM EMPLOYEES 
WHERE HIRE_DATE BETWEEN TO_DATE('1996-01-11', 'YYYY-MM--DD') AND TO_DATE('2005-02-22', 'YYYY-MM--DD');