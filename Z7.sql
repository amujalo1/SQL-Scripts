--Napisati upit koji će vratiti jednu kolonu "Ime + Plata" od naziva zaposlenog i
--njegove plate za sve zaposlene. Formatirati "Ime + plata" tako da je vraćena
--kolona dužine 50 karaktera i s lijeve strane nadopunjena s «$» karakterom. 

SELECT 
    LPAD(CONCAT(CONCAT(first_name, ' '), TO_CHAR(salary, '9999.99')), 50, '$') "Ime + Plata"
FROM employees;
