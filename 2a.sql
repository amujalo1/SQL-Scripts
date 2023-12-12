--Napisati upit koji će prikazati broj indeksa, broj bodova i bodove predstavljene kao
--kategorije na sljedeći način:
--od 1 do 5 kao "D",
--od 6 do 10 kao "C",
--od 11 do 15 kao "B" i
--od 16 do 20 kao "A".

SELECT
    s.indeks,
    b.bodovi,
    CASE 
        WHEN b.bodovi BETWEEN 1 AND 5 THEN 'D'
        WHEN b.bodovi BETWEEN 6 AND 10 THEN 'C'
        WHEN b.bodovi BETWEEN 11 AND 15 THEN 'B'
        WHEN b.bodovi BETWEEN 16 AND 20 THEN 'A'
    END AS "OCJENA"
FROM studenti s, bodovi b
WHERE s.id = b.sid;
        
    