--a) Napisati upit koji će prikazati naziv kupca i ukupan iznos fakture za sve one kupce
--čiji broj telefona sarži dvije cifre 9 na bilo kojem mjestu. U ispisu se trebaju pojaviti
--i oni kupci koji nisu realizirali niti jednu fakturu.

SELECT 
    fl.ime || ' ' || fl.prezime naziv_kupca,
    sum(nvl(fa.iznos,0)) iznos_fakture
from kupac k
left join fizickoLice fl on fl.fizicko_lice_id = k.kupac_id
left join faktura fa on k.kupac_id = fa.kupac_id
where k.broj_telefona like '%9%9%'
group by fl.ime, fl.prezime, k.kupac_id;