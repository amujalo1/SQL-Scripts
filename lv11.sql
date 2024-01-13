--1. Kreiraje vašu tabelu zaposlenih koja će sadržavati sljedeće kolone: šifru
--zaposlenog, naziv zaposlenog, naziv odjela, šifra posla, naziv posla, platu i dodatak
--na platu. Potom modificirati vašu tabelu zaposlenih sa novom kolonom šifra koja će
--biti primarni ključ. Potom kreirati triger koji će onemogućiti promjene nad podacima
--onih zaposlenih koji su počeli da rade od 1998 godine. 

DROP TABLE zaposleni;

CREATE TABLE zaposleni
  (sifra_zaposlenog NUMBER,
   naziv_zaposlenog VARCHAR2(35),
   naziv_odjela VARCHAR2(20),
   sifra_posla NUMBER,
   naziv_posla VARCHAR2(20),
   plata NUMBER,
   dodatak NUMBER,
   datum_zaposlenja DATE);

ALTER TABLE zaposleni
ADD (sifra NUMBER,
     CONSTRAINT sifra_zap_pk PRIMARY KEY (sifra));

CREATE OR REPLACE TRIGGER zaposleni_trigger
BEFORE UPDATE OR DELETE ON zaposleni
FOR EACH ROW
BEGIN 
    IF TO_NUMBER(to_char(:old.datum_zaposlenja,'YYYY')) <= 1998
    THEN  Raise_Application_Error(-20000, 'Nemoguce mijenjati podatke za ovog zaposlenika!');
  END IF; 
END;
/

--2. Kreirati triger nad vašom tabelom zaposlenih koji će onemogućiti promjene nad
--podacima za radne dane, tj. od ponedjeljka do petka, u periodu od 16:23 i 23:16, i
--subotom i nedjeljom od 06:34 i 23:56. 


create or replace trigger zaposleni_dani
before insert or update or delete 
on zaposleni
for each row
declare 
    dan varchar2(20);
    sat number;
    minuta number;
begin
    dan := to_char(sysdate, 'DAY');
    sat := to_number(to_char(sysdate, 'HH'));
    minuta := to_number(to_char(sysdate, 'MI'));
    IF dan in ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY') AND sat = 16 AND minuta >= 23 OR sat > 16 AND sat < 23 OR sat = 23 AND minuta <= 16
    THEN Raise_Application_Error(-20001, 'Zabranjen unos u toku ovog vremena!');
    ELSIF dan IN ('SATURDAY', 'SUNDAY') AND sat = 6 AND minuta >= 34 OR sat > 6 AND sat < 23 OR sat = 23 AND minuta <= 56
    THEN Raise_Application_Error(-20002, 'Zabranjen unos u toku ovog vremena!');
    END IF;
END;
/

--3. Kreirati triger nad vašom tablom zaposlenih koji se za sve promjene nad podacima
--zaposlenih insertovati stare podatke o zaposlenom u vašu tabelu arhive, koja će
--pored svih kolona kao i vaša tabela zaposlenih sadržavati još i informacije o
--korisniku koji se ažurirao podatke, kao i vrijeme ažuriranja podataka. 
drop table arhiva;
CREATE TABLE arhiva
AS
SELECT *
FROM zaposleni;

ALTER TABLE arhiva
ADD (korisnik VARCHAR2(20),
     datum DATE);

CREATE OR REPLACE TRIGGER zaposleni_arhiva
BEFORE UPDATE OR DELETE
ON zaposleni
FOR EACH ROW
BEGIN
  INSERT INTO arhiva
  VALUES (:old.sifra_zaposlenog, :old.naziv_zaposlenog, :old.naziv_odjela, :old.sifra_posla, :old.naziv_posla, :old.plata, :old.dodatak, :old.datum_zaposlenja, :old.sifra, USER, SYSDATE);
END;
/

--4. Kreirajte vašu tabelu odjela i poslova identičnih tabelama departments i jobs, sa
--dodatnim kolonama id, korisnik i datum, gdje će te proglasiti kolone id primarnim
--ključevima tabela, respektivno. Potom uvesti dodatne kolone nad vašim tabelama
--zaposlenih, kako bi ste kreirali odgovarajuće strane ključeve između odgovarajućih
--tabela. Potom kreirajte odgovarajuće ključeve.
--Nakon što kreirate ove tabele krirajte trigere nad bazom koji će omogućiti
--automatsko dodijeljivanje id, korisnika i datum nad vašim novo kreiranim tabelama.
--Id je potrebno osigurati iz sekvenci brojeva. 

drop table odjeli;
drop table poslovi;

create table odjeli
as select * 
from departments;

create table poslovi
as select *
from jobs;

drop sequence id_odjeli;
create sequence id_odjeli
    minvalue 1
    start with 1
    increment by 1
    cache 20;

drop sequence id_poslovi;
create sequence id_poslovi
    minvalue 1
    start with 1
    increment by 1
    cache 20;

ALTER TABLE odjeli
ADD (id NUMBER DEFAULT id_odjeli.NEXTVAL,
     korisnik VARCHAR2(20) DEFAULT '%%%%',
     datum DATE DEFAULT To_Date('01012000', 'DDMMYYYY'),
     CONSTRAINT id_odjeli_pk PRIMARY KEY (id));

ALTER TABLE poslovi
ADD (id NUMBER DEFAULT id_poslovi.NEXTVAL,
     korisnik VARCHAR2(20) DEFAULT '%%%%',
     datum DATE DEFAULT To_Date('01012000', 'DDMMYYYY'),
     CONSTRAINT id_poslovi_pk PRIMARY KEY (id));

ALTER TABLE zaposleni
ADD (id_odjela NUMBER,
     id_posla NUMBER,
     CONSTRAINT odjel_zap_fk FOREIGN KEY (id_odjela)
     REFERENCES odjeli (id),
     CONSTRAINT posao_zap_fk FOREIGN KEY (id_posla)
     REFERENCES poslovi (id));
    
CREATE OR REPLACE TRIGGER odjeli_dodjele
BEFORE INSERT
ON odjeli
FOR EACH ROW
BEGIN
  :new.korisnik := USER;
  :new.datum := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER poslovi_dodjele
BEFORE INSERT
ON poslovi
FOR EACH ROW
BEGIN
  :new.korisnik := USER;
  :new.datum := SYSDATE;
END;
/

--5. Modificirajte predhodni triger za tabelu odjela na takava način da se za menagera
--odjela, koji se trenutno insertuje u bazu, automatski dodijeli onaj manager koji ima
--najmanje uposlenih.

create or replace trigger odjeli_dodjele
before insert
on odjeli
for each row
declare
    manager number;
begin 
    :new.korisnik := USER;
    :new.datum := SYSDATE;
    SELECT e.employee_id
    INTO manager
    FROM employees e
    where e.employee_id = (SELECT e2.employee_id
                           FROM employees e2
                           WHERE e2.employee_id IN (SELECT DISTINCT manager_id
                                                    FROM employees)
                           AND (SELECT Count(*)
                             FROM employees e3
                             WHERE e3.manager_id = e2.employee_id) = (SELECT Max(broj)
                                                                      FROM (SELECT Count(*) AS broj, manager_id
                                                                            FROM employees
                                                                            GROUP BY manager_id) zaposlenici_po_sefovima));
    :new.manager_id := manager;
END;
/

--6. Modificirajte triger za insertovanje slogova za tabelu zaposlenih na takav način da
--se za sifru odjela uzme onaj odjal kojim rukovidi onaj šef, koji rukovodi sa najmanje 2 odjela.

CREATE OR REPLACE TRIGGER zaposleni_trigger
BEFORE INSERT
ON zaposleni
for each row
declare 
    odjel NUMBER;
BEGIN
    SELECT d.department_id
    INTO odjel
    FROM departments d, employees e
    WHERE d.manager_id = e.employee_id AND e.employee_id IN (SELECT e2.employee_id
                                                           FROM employees e2, (SELECT manager_id, Count(department_id) AS broj
                                                                               FROM departments
                                                                               GROUP BY manager_id) nadlezni
                                                           WHERE nadlezni.broj >= 2 AND e2.employee_id = nadlezni.manager_id);
    :new.id_odjela := odjel;
END;
/

--7. Kreirajte triger nad tabelom zaposlenih koji će za brisanje slogova iz vaše tabele
--zaposlenih kreirati tabelu arhive. Tabela arhive mora imati primarni ključ po koloni id tabele arhive. 

CREATE SEQUENCE id_arhiva
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE TABLE arhiva_brisanja
AS SELECT *
FROM zaposleni;

ALTER TABLE arhiva_brisanja
ADD (id NUMBER,
     CONSTRAINT id_arh_pk PRIMARY KEY(id));
    
CREATE OR REPLACE TRIGGER zaposleni_brisanje
BEFORE DELETE 
ON zaposleni
FOR EACH ROW
DECLARE 
    odjel NUMBER;
BEGIN
    INSERT INTO arhiva_brisanja
    VALUES (:old.sifra_zaposlenog, :old.naziv_zaposlenog, :old.naziv_odjela, :old.sifra_posla, :old.naziv_posla, :old.plata, :old.dodatak, :old.datum_zaposlenja, :old.sifra, id_arhiva.NEXTVAL);
END;
/

--8. Kreirajte triger nad vašom tabelom zaposlenih koja će osigurati, integritet visine
--plate za odgovarajuće poslove po iznosima koji su definisani sa maksimalnom i
--minimalnom vrijednošću. U slučaju da je prebačen limit, tj. da je plata i dodatak na
--platu veći od naznačenog limita umanjiti platu za 20 odsto. U slučaju da i pored
--ovog umanjivanja plata sa dodatkom na platu je veća od dozvoljenih limita,
--umanjiti platu za 30 odsto i tako redom, dok se ne zadovolji kriterij visine plate po
--naznačenom poslu. A ako je u pitanju plata i dodatak na platu koji je manja od
--naznačenih limita, tada je potrebno uraditi obratan postupak, tj. prvo platu uvećati
--za 20 odsto, pa ako ne zadovoljava kriterij za 30 odsto i tako redom. 

CREATE OR REPLACE TRIGGER zaposleni_plata
BEFORE INSERT OR UPDATE ON zaposleni
FOR EACH ROW
DECLARE 
    iznos_plate NUMBER;
    minimum NUMBER;
    maksimum NUMBER;
    smanjivanje NUMBER;
    povecavanje NUMBER;
BEGIN
    minimum := 1000;
    maksimum := 10000;
    smanjivanje := 0.2;
    povecavanje := 0.2;
    iznos_plate := :new.plata*(1+:new.dodatak);
    WHILE iznos_plate > maksimum AND smanjivanje <= 1
    LOOP
        :new.plata := :new.plata*(1-smanjivanje);
        smanjivanje := smanjivanje + 0.1;
    END LOOP;
    WHILE iznos_plate < minimum AND povecavanje <= 1
    LOOP
        :new.plata := :new.plata*(1+povecavanje);
        povecavanje := povecavanje + 0.1;
    END LOOP;
END;
/

--9. Kreirati triger nad vašom tabelom odjela koji će onemogućiti promjenu odjela iz
--Amerike u Englesku, a potom krirati najpodesniju tebelu logova, u kojoj će te čuvati
--inforamciju o pokušajima promjene odjela iz jedne u drugu lokaciju. Voditi računa
--da je neophodno u log tabeli imati informaciju o staroj i novoj lokaciji. 

CREATE TABLE logovi_odjeli 
    (korisnik VARCHAR2(20),
     datum DATE,
     odjel NUMBER,
     stara_lokacija VARCHAR2(30),
     novca_lokacija VARCHAR2(30));

CREATE OR REPLACE TRIGGER odjeli_drzava
BEFORE UPDATE ON odjeli 
FOR EACH ROW
DECLARE 
    stara_drzava VARCHAR2(30);
    nova_drzava VARCHAR2(30);
    stara_lokacija NUMBER;
    nova_lokacija NUMBER;
BEGIN
    stara_lokacija := :old.location_id;
    nova_lokacija := :new.location_id;
    
    SELECT c.country_name
    INTO stara_drzava
    FROM locations l, countries c
    WHERE l.location_id = stara_lokacija AND l.country_id = c.country_id;
    
    SELECT c.country_name
    INTO nova_drzava
    FROM locations l, countries c
    WHERE l.location_id = nova_lokacija AND l.country_id = c.country_id;
    
    IF stara_lokacija = 'United States of America' AND nova_lokacija = 'United Kingdom'
    THEN
        INSERT INTO logovi_odjeli
        VALUES (USER, SYSDATE, :new.department_id, stara_lokacija, nova_lokacija);
        Raise_Application_Error(-20003, 'Zabranjen izmjena iz SAD u UK!');
    END IF;
END;
/




