--1.Kreirajte va�u tabelu zaposlenih, sa analognim podacima kao i tabela employees,
--gdje ?e te dodati novu kolonu �id� nad kojom ?e biti definisan primary key.
--Odaberite adekvatan tip podataka �id� kolone prema planiranim i/ili uba?enim vrijednostima.
drop table zap;
create table zap
as select * from employees;
delete from zap;
alter table zap
add (id number, constraint zap_id_pk primary key(id));
alter table zap
drop column employee_id;

insert into zap (id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
(select * from employees); 
select * from zap;
--2. Kreirajte va�u tabelu odjela, sa analognim podacima kao i tabela departments, gdje
--?e te dodati nove kolone �id i datum� nad kojom ?e biti definisan primary key.
--Odaberite adekvatne tipove podataka za nazna?ene kolone.
drop table odjeli;
create table odjeli
as select * from departments;
delete from odjeli;
alter table odjeli add (id number, datum date, constraint odjeli_id_datum_pk primary key (id, datum));
alter table odjeli drop column department_id;
insert into odjeli (id, department_name, manager_id, location_id, datum)
select d.department_id, d.department_name, d.manager_id, d.location_id, sysdate
from departments d;
select * from odjeli;
--3. Re-dizajnirajte va�u tabelu zaposlenih tako da je mogu?e kreirati foreign key
--izme?u va�e tabele zaposlenih i odjela. Neophodno je a�urirati sve slogove tabele
--zaposlenih kako bi se prenijele potrebne informacije iz va�e table odjela u va�u tabelu zaposlenih. 
alter table zap
add (odjel number, datum_odjela date, 
    constraint zap_odjel_fk foreign key (odjel, datum_odjela)
    references odjeli (id, datum));
update zap z
set (z.odjel, z.datum_odjela) = (select o.id, o.datum
                                 from odjeli o
                                 where o.id = z.department_id);
alter table zap
drop column department_id;
--4. Provjerite koji sve constraint-i postoje nad va�om �emom baze potom nad �emom �hr�,
--a potom nad �emom �test�. Da li svaka tabela u �emi �hr� posjeduje primary key?. 
select * 
from user_constraints;
select *
from all_constraints
where owner = 'HR' or owner = 'TEST';
--5. Prika�ite sve objekte koji imaju neke veze sa tabelom EMPLOYEES i DEPARTMENTS
--iz �eme �hr�. 
select * 
from all_constraints
where owner = 'HR' and table_name in ('EMPLOYEES', 'DEPARTMENTS');
--6. Modificirajte tabelu zaposlenih tako �to ?e te dodati novu kolonu plata_dodatak koji
--?e sadr�avati platu uve?anu za dodatak na platu samo za zaposlene iz Amerike. 
alter table zap
add plata_dodatak number;
update zap z
set z.plata_dodatak = (select decode(r.region_name,
                              'Americas', z2.salary*(1 + nvl(z2.commission_pct, 0)),
                              z2.salary)
                      from zap z2, odjeli o, locations l, countries c, regions r
                      where z2.id = z.id and z2.odjel = o.id and o.location_id = l.location_id and l.country_id = c.country_id and c.region_id = r.region_id);
select * from zap;
--7. Dodajte CHECK constraint za kolonu kreiranu u 6 zadatku za razuman raspon vrijednosti.
alter table zap
add constraint zap_pd_check
check (plata_dodatak between 0 and 40000);
--8. Kreirajte pogled sa nazivom zap_pog sa sljede?im kolonama: �ifra zaposlenog,
--naziv zaposlenog i naziv odjela, za sve zaposlene koji primaju platu ve?u od
--prosje?ne plate odjela u kojem rade.
create view sap_pog
as  select z.id, z.first_name || ' ' || z.last_name "naziv",
    o.department_name
from zap z, odjeli o
where z.odjel = o.id and z.salary > (select avg(salary)
                                     from zap z2
                                     where z.odjel = z2.odjel);
--9. Prika�ite sadr�aj kreiranog pogleda. Da li je mogu?e kombinovati poglede s
--osnovnim tabelama baze.
select * from odjeli;
select * 
from sap_pog zp, zap z
where zp.id = z.id;
--10. Kreirajte pogled koji ?e vratit naziv posla, naziv odjela, prosje?nu platu i iznos
--dodataka na platu po datim poslovima i odjelima za sve poslove i odjele koji u
--imenu sadr�e slova �a�, �b�, i �c� na bilo kojoj poziciji. Pogled se mo�e koristiti samo za pregled. 
create view posao_pogled
as select j.job_title, o.department_name, avg(z.salary) "avg", z.salary*nvl(z.commission_pct,0) "dodatak"
from zap z, odjeli o, jobs j
where o.id = z.odjel and z.job_id = j.job_id
    and regexp_like(o.department_name, '[abc]') and regexp_like(j.job_title, '[abc]')
group by j.job_title, o.department_name, z.salary*nvl(z.commission_pct,0)
with read only;
select * from posao_pogled; 
--11. Modificirajte predhodni pogled tako da uvedete novu kolonu koja ?e sadr�avati
--prosje?nu platu po odjelima 
create or replace view posao_pogled
as select j.job_title, o.department_name, avg(z.salary) "avg", z.salary*nvl(z.commission_pct,0) "dodatak", plate.avg
from zap z, odjeli o, jobs j, (select avg(salary) avg, odjel from zap group by odjel) plate
where o.id = z.odjel and z.job_id = j.job_id and z.odjel = plate.odjel
    and regexp_like(o.department_name, '[abc]') and regexp_like(j.job_title, '[abc]')
group by j.job_title, o.department_name, z.salary*nvl(z.commission_pct,0), plate.avg;
select * from posao_pogled;
--12. Modificirajte predhodni pogled tako da novo-kreirana kolona nosi naziv �prosje?na plata odjela�
create or replace view posao_pogled
as select j.job_title, o.department_name, avg(z.salary) "avg", z.salary*nvl(z.commission_pct,0) "dodatak", plate.avg "prosjecna plata odjela"
from zap z, odjeli o, jobs j, (select avg(salary) avg, odjel from zap group by odjel) plate
where o.id = z.odjel and z.job_id = j.job_id and z.odjel = plate.odjel
    and regexp_like(o.department_name, '[abc]') and regexp_like(j.job_title, '[abc]')
group by j.job_title, o.department_name, z.salary*nvl(z.commission_pct,0), plate.avg;
select * from posao_pogled;
--13. Kreirajte pogled koji ?e vratiti naziv �efa, broj zaposlenih koji su podre?eni �efu,
--kao i minimalnu i maksimalnu platu odjela u kojem nazna?eni �ef radi. 
create view sefovi_pogled
as select m.first_name || ' ' || m.last_name "ime", Count(z.id) suma, plate.maksimum, plate.minimum
from zap z, zap m,
(select max(z2.salary) as maksimum, min(z2.salary) as minimum, odjel
 from zap z2
 group by odjel) plate
    where z.manager_id = m.id and m.odjel = plate.odjel
    group by m.first_name || ' ' || m.last_name, plate.maksimum, plate.minimum;

select * from sefovi_pogled;
--14. Modificirajte predhodni primjer tako da se pogled mo�e koristiti samo za ?itanje, i
--dodajte novu kolone koje ?e sadr�avati sumarnu platu sa dodacima na platu za sve
--zaposlene kojima je nazna?eni �ef nadre?en. 
create or replace view sefovi_pogled
as select m.first_name || ' ' || m.last_name as ime, 
              Count(z.id) as suma, 
              plate.maksimum, 
              plate.minimum, 
              sume.suma as suma_zarada
from zap z, zap m,
     (select max(z2.salary) as maksimum, min(z2.salary) as minimum, odjel
      from zap z2
      group by odjel) plate,
     (select sum(z2.salary) as suma, z2.manager_id
      from zap z2
      group by manager_id) sume
where z.manager_id = m.id and m.odjel = plate.odjel and m.id = sume.manager_id
group by m.first_name || ' ' || m.last_name, plate.maksimum, plate.minimum, sume.suma
with read only;
select * from sefovi_pogled;