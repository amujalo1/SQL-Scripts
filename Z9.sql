--Napisati upit koji će prikazati naziv, datum zaposlenja i dan u sedmici kada je
--zaposleni počeo da radi. Rezultati sortirati po danima u sedmici počevši od ponedjeljka. 


SELECT 
    first_name || ' ' || last_name AS "Naziv zaposlenog",
    hire_date AS "Datum zaposlenja",
    TO_CHAR(hire_date, 'Day') AS "Dan u sedmici"
FROM employees
ORDER BY CASE TO_CHAR(hire_date, 'D')
    WHEN '2' THEN 1 -- ponedeljak
    WHEN '3' THEN 2	-- utorak
    WHEN '4' THEN 3 -- srijeda
    WHEN '5' THEN 4	-- cetvrtak
    WHEN '6' THEN 5	-- petak
    WHEN '7' THEN 6 -- subota 
    ELSE 7 			-- nedelja
END;
