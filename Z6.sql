--Napisati upit koji će prikazati za sve zaposlene iz odjela 10, 30 i 50 sljedeće:
--«naziv zaposlenog» prima platu «iznos plate» mjesečno ali on bi želio platu «plata
--uvećana za procenat dodataka na platu i pomnožena sa 4,5 puta». Labela za kolonu
--je «plata o kojoj možeš samo sanjati». 

SELECT
    CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(first_name, ' '), last_name), ' prima platu '), salary), ' mjesečno ali on bi želio platu '), TO_CHAR(salary + NVL(COMMISSION_PCT, 0) * salary) * 4.5) 
    AS "Plata kojoj možeš samo sanjati"
FROM employees
WHERE department_id IN (10, 30, 50);
