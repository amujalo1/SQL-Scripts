--Napisati upit koji će prikazati naziv zaposlenog, platu i indikator plate izražene za
--znakom «*». Svaka zvjezdica označava jednu hiljadu od plate. Na primjer ako
--uposleni prima 2600 KM platu, tada treba za indikator plate ispisati ***, a ako prima 2400 onda **. ;

SELECT
    first_name || ' ' || last_name AS "Naziv zaposlenog",
    salary AS "Plata",
    RPAD('*', ROUND(salary / 1000), '*') AS "Indikator plate"
FROM employees;
