--Za sve zaposlene iz tabele zaposlenih prikazati naziv zaposlenog, naziv odjela i
--kontinent, kao i broj mjeseci zaposlenja zaposlenika. Broj mjeseci zaokružiti na
--cjelobrojnu vrijednost. 

SELECT
    e.first_name || ' ' || e.last_name "Naziv zaposlenog",
    d.department_name "Naziv odjela",
    r.region_name "Kontinent",
    ROUND(MONTHS_BETWEEN(SYSDATE, e.hire_date)) "Broj meseci zaposlenja"
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN COUNTRIES c ON c.COUNTRY_ID = l.COUNTRY_ID 
JOIN regions r ON r.REGION_ID = c.REGION_ID;
