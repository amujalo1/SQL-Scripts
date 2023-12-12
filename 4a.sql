--a) Napisati upit koji će prikazati prezime i ime zaposlenog, datum_zaposlenja i broj
--mjeseci zaposlenja, tj. od kada je zaposlenik zaposlen gledajući u odnosu na datum
--zaposlenja i trenutni datum. Upit treba da vrati zaposlene sortirane na osnovu broja
--mjeseci staža zaposlenog.

SELECT 
    last_name || ' ' || first_name AS "Naziv zaposlenog",
    hire_date AS "Datum zaposlenja",
    ROUND(Months_between(sysdate,hire_date),2) AS  broj_mjeseci_zaposlenja
FROM employees
ORDER BY  broj_mjeseci_zaposlenja DESC;