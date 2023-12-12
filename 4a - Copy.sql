--b) Napisati upit koji će prikazati naziv odjela, kao i broj zaposlenih u odjelu, za sve one
--zaposlene koji rade u onim odjelima koji zapošljavaju 3, 5 ili više od 10 zaposlenih u
--odjelu u kojima dati zaposlenici rade. Upit treba da vrati podatke sortirane po broj
--zaposlenih i nazivu odjela.

SELECT 
    d.department_name AS Naziv_odjela,
    COUNT(e.department_id) AS Broj_zaposlenih
from departments d
JOIN EMPLOYEES e ON d.department_id = e.department_id
WHERE d.department_id IN (
    SELECT 
        department_id
    FROM employees
    GROUP BY department_id
    HAVING COUNT(*) >= 3
)
GROUP BY d.department_name
HAVING COUNT(e.employee_id) >= 5
ORDER BY Broj_zaposlenih, Naziv_odjela;