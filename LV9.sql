--1. Kreirati tabelu odjela sa sljede?om strukturom:
create table odjel (
    Id Varchar2(25) not null,
    Naziv Varchar2(10) not null,
    Opis Char(15),
    Datum Date not null,
    Korisnik Varchar2(30) not null,
    Napomena Varchar2(10)
);
--2. Kopirate podatke iz tabele odjela u vašu kreiranu tabelu odjela samo onim
--podacima koje je mogu?e upisati u tabelu. 
insert into odjel (Id, Naziv, Opis, Datum, Korisnik, Napomena) 
select to_char(d.department_id),
    substr(d.department_name,1,10),
    null,
    sysdate,
    user,
    null
from departments d;
--3.Modificirati vašu tabelu odjela na takav na?in da se upišu svi podaci iz postoje?e tabele odjela. 

alter table odjel
add (manager_id number(6));
alter table odjel
add (location_id number(4));

update odjel l
set l.manager_id = (
    select d.manager_id
    from departments d where to_number(l.Id) = d.department_id);
update odjel l
set l.location_id = (
    select d.location_id
    from departments d where to_number(l.Id) = d.department_id);
alter table odjel
modify (location_id number(4) not null); 

--4. Kreiraje vašu tabelu zaposlenih sa sljede?om strukturom:
create table zaposleni (
    Id number(4) not null,
    Sifra_zaposlenog Varchar2(5) not null,
    Naziv_zaposlenog char(50),
    Godina_zaposlenja number(4) not null,
    Mjesec_zaposlenja Char(2) not null,
    Sifra_odjela varchar2(5),
    Naziv_odjela Varchar2(15) not null,
    Grad Char(10) not null,
    Sifra_posla Varchar2(25),
    Naziv_posla Char(50) not null,
    Iznos_dodatak_na_platu number(5),
    Plata number(6) not NULL,
    Kontinent Varchar2(20),
    Datum_unosa Date not NULL,
    Korisnik_unio Char(20) not null
);

--5. Na sve postoje?e podatke o zaposlenim iz tabla vezanih za zaposlene, kopirajte
--potrebne podatke u vašu tabelu zaposlenih. 
insert into zaposleni
select rownum,
    to_char(e.employee_id),
    e.first_name || ' ' || e.last_name,
    to_number(to_char(e.hire_date,'yyyy')),
    to_char(e.hire_date,'mm'),
    to_char(e.department_id),
    substr(d.department_name,1,15),
    substr(l.city,1,10),
    e.job_id,
    j.job_title,
    e.salary*e.commission_pct,
    salary,
    substr(r.region_name,1,20),
    sysdate,
    user
from employees e, departments d, jobs j, locations l, countries c, regions r
where e.department_id = d.department_id and e.job_id = j.job_id and d.location_id = l.location_id
and l.country_id = c.country_id and c.region_id = r.region_id;
    
--6. Kopirajte vašu tabelu zaposlenih u novu tabelu zaposleni2
create table zaposleni2 as
select * from zaposleni;

--7.Modificirajte tabelu zaposleni2 tako da kolone: sifra_zaposlenog i naziv zaposlenog,
--sifra_odjela i naziv_odjela, sifra_posla i naziv_posla bude predstavljen kao jedna
--kolona respektivno: odjel, zaposleni i posao. 

-- Dodajte nove kolone za kombinaciju
ALTER TABLE zaposleni2
ADD (zaposleni VARCHAR2(55),
     odjel VARCHAR2(20),
     posao VARCHAR2(75));

-- Ažurirajte nove kolone s kombinacijom vrijednosti
UPDATE zaposleni2
SET zaposleni = Sifra_zaposlenog || ' ' || Naziv_zaposlenog,
    odjel = Sifra_odjela || ' ' || Naziv_odjela,
    posao = Sifra_posla || ' ' || Naziv_posla;

-- Obrišite stare kolone
ALTER TABLE zaposleni2
DROP COLUMN Sifra_zaposlenog;
ALTER TABLE zaposleni2
DROP COLUMN Naziv_zaposlenog;
ALTER TABLE zaposleni2
DROP COLUMN Sifra_odjela;
ALTER TABLE zaposleni2
DROP COLUMN Naziv_odjela;
ALTER TABLE zaposleni2
DROP COLUMN Sifra_posla;
ALTER TABLE zaposleni2
DROP COLUMN Naziv_posla;
ALTER TABLE zaposleni2
modify (zaposleni VARCHAR2(55) not null,
     odjel VARCHAR2(20) not null,
     posao VARCHAR2(75) not null);
     
describe zaposleni2;
--8. Promijeniti naziv tabele zaposleni2 u naziv zap_backup.
alter table zaposleni2
rename to zap_backup;
--9.Dodajte komentare za vaše kreirane tabele odjela i zaposlenih, koji precizno
--ozna?avaju šta koja od tabela zna?i i sadržava. 

-- Komentari za tabelu 'odjel'
COMMENT ON TABLE odjel IS 'Tabela koja sadrži informacije o odjelima u organizaciji';
-- Komentari za tabelu 'zaposleni'
COMMENT ON TABLE zaposleni IS 'Tabela koja sadrži informacije o zaposlenima u organizaciji';
--10.Dodajte komentare za vaše kreirane kolone tabela odjela i zaposlenih, koji precizno
--ozna?avaju šta koja od kolona zna?i i sadržava. 

-- Komentari kolona za tabelu 'odjel'
COMMENT ON COLUMN odjel.ID IS 'Jedinstveni identifikator odjela';
COMMENT ON COLUMN odjel.NAZIV IS 'Naziv odjela';
COMMENT ON COLUMN odjel.OPIS IS 'Kratki opis odjela';
COMMENT ON COLUMN odjel.DATUM IS 'Datum osnivanja odjela';
COMMENT ON COLUMN odjel.KORISNIK IS 'Korisni?ko ime osobe koja je kreirala odjel';
COMMENT ON COLUMN odjel.NAPOMENA IS 'Dodatna napomena o odjelu';
COMMENT ON COLUMN odjel.MANAGER_ID IS 'ID menadžera odjela';
COMMENT ON COLUMN odjel.LOCATION_ID IS 'ID lokacije odjela';
-- Komentari kolona za tabelu 'zaposleni'
COMMENT ON COLUMN zaposleni.ID IS 'Jedinstveni identifikator zaposlenog';
COMMENT ON COLUMN zaposleni.SIFRA_ZAPOSLENOG IS 'Šifra zaposlenog';
COMMENT ON COLUMN zaposleni.NAZIV_ZAPOSLENOG IS 'Ime i prezime zaposlenog';
COMMENT ON COLUMN zaposleni.GODINA_ZAPOSLENJA IS 'Godina zaposlenja';
COMMENT ON COLUMN zaposleni.MJESEC_ZAPOSLENJA IS 'Mjesec zaposlenja';
COMMENT ON COLUMN zaposleni.SIFRA_ODJELA IS 'Šifra odjela u kojem radi zaposleni';
COMMENT ON COLUMN zaposleni.NAZIV_ODJELA IS 'Naziv odjela u kojem radi zaposleni';
COMMENT ON COLUMN zaposleni.GRAD IS 'Grad u kojem radi zaposleni';
COMMENT ON COLUMN zaposleni.SIFRA_POSLA IS 'Šifra radnog mjesta';
COMMENT ON COLUMN zaposleni.NAZIV_POSLA IS 'Naziv radnog mjesta';
COMMENT ON COLUMN zaposleni.IZNOS_DODATAK_NA_PLATU IS 'Iznos dodatka na platu';
COMMENT ON COLUMN zaposleni.PLATA IS 'Plata zaposlenog';
COMMENT ON COLUMN zaposleni.KONTINENT IS 'Kontinent na kojem se nalazi zaposleni';
COMMENT ON COLUMN zaposleni.DATUM_UNOSA IS 'Datum unosa informacija o zaposlenom';
COMMENT ON COLUMN zaposleni.KORISNIK_UNIO IS 'Korisni?ko ime osobe koja je unijela informacije o zaposlenom';

--11. Proglasite kolone datum_unosa i korisnik_unio u vašoj zap_backup tabeli neupotrebljivim.
ALTER TABLE zap_backup SET UNUSED (datum_unosa, korisnik_unio);
describe zap_backup;
--12. Izlistati sve opisane komentare za vaše tabele odjela i zaposlenih. 
-- Prikaz svih komentara za tabelu 'odjel'
SELECT table_name, column_name, comments
FROM all_col_comments
WHERE table_name = 'ODJEL';

SELECT table_name, comments
FROM all_tab_comments
WHERE table_name = 'ODJEL';

-- Prikaz svih komentara za tabelu 'zaposleni'
SELECT table_name, column_name, comments
FROM all_col_comments
WHERE table_name = 'ZAPOSLENI';

SELECT table_name, comments
FROM all_tab_comments
WHERE table_name = 'ZAPOSLENI';
--12. Izbrisati sve neupotrebljive kolone u vašoj tabeli zaposlenih. 
ALTER TABLE zaposleni DROP UNUSED COLUMNS;
select * from zaposleni;