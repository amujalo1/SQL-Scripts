--Napisati upit sve zaposlene koji su počeli da rade prije 1996 godine. 

SELECT 
	*
FROM EMPLOYEES 
WHERE HIRE_DATE < TO_DATE('2996','YYYY'); 