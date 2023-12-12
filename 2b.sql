--Napisati SQL iskaze putem kojih će se kopirati tabela "Studenti" u novu tabelu
--"Osobe". Potom dodati novu kolonu "info" tipa string. Nakon kreiranja kolone,
--ažurirati vrijednosti za novo kreiranu kolonu na vrijednost koja se dobijaje na
--osnovu prosječne vrijednosti bodova po odsjecima kojim student pripada.

CREATE TABLE Osobe AS
SELECT * FROM Studenti;
        
ALTER TABLE Osobe
ADD COLUMN info VARCHAR(255); -- Prilagodite veličinu VARCHAR prema potrebi

UPDATE Osobe
SET info = (
    SELECT 
        CASE 
        WHEN AVG(b.bodovi) BETWEEN 1 AND 5 THEN 'D'
        WHEN AVG(b.bodovi) BETWEEN 6 AND 10 THEN 'C'
        WHEN AVG(b.bodovi) BETWEEN 11 AND 15 THEN 'B'
        WHEN AVG(b.bodovi) BETWEEN 16 AND 20 THEN 'A'
    END 
    FROM Osobe, bodovi b, Odsjeci o
    WHERE o.id = Osobe.odi AND b.sid = Osobe.id
);