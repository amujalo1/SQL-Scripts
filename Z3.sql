--Napisati upit koji će prikazati 
--sve zaposlene čija plata 
--nije u rangu od 1000 do 2345. 

 SELECT 
 	*
 FROM EMPLOYEES 
 WHERE SALARY NOT BETWEEN 1000 AND 2345;