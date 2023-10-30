--Napisati upit koji će prikazati naziv zaposlenog, grad u kojem zaposlenik radi, kao i
--iznos dodatka na platu. Za one zaposlene koji ne dobivaju dodatak na platu ispisati
--«zaposlenik ne prima dodatak na platu».  

SELECT
    e.first_name || ' ' || e.last_name AS "Naziv zaposlenog",
    l.city AS "Grad",
    DECODE(commission_pct * salary, NULL, 'Zaposlenik ne prima dodatak na platu',
    commission_pct * salary) AS "Iznos dodatka na platu"
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations l ON d.location_id = l.location_id;