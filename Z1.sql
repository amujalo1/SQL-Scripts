--Napisati upit koji će prikazati trenutni datum i 
--korisnika logiranog na bazu podataka. 
--Labele za kolone su date i user respektivno.
SELECT 
		to_char(sysdate, 'day - month syyyy, hh24:mi:ss') "Trenutni datum",
		user "Logirani korisnik na bazu"
FROM dual;