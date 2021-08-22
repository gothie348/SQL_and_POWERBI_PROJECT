---Q2: Calculate the number of health facilities per commune.
SELECT co."commune",count(s.facdesc) as facilities
FROM spa as s
INNER JOIN commune as co
ON s."commune_id"= co."commune_id"
GROUP BY commune
ORDER BY facilities DESC;

---Q3: Calculate the number of health facilities by commune and by type of health facility.
select  co."commune", s."facdesc_1", count(s."facdesc") as facilities
from spa as s
inner join commune as co
on s."commune_id" = co."commune_id"
group by co."commune", s."facdesc_1"
order by facilities DESC;

---Q4 Calculate the number of health facilities by municipality and by department.
select  d."departement", co."commune" as municipality, count(s."facdesc") as facilities
from spa as s
inner join commune as co
on s."commune_id" = co."commune_id"
inner join departement as d
on co."departement_id"=d."departement_id"
group by d."departement", co."commune"
order by d."departement";

---Q5: Calculate the number of sites by type (mga) and by department.
select d."departement", m."mga_type" as sector, count(s."facdesc") as sites
from spa as s
inner join commune as co
on s."commune_id" = co."commune_id"
inner join departement as d
on co."departement_id"=d."departement_id"
inner join mga as m
on s."mga"=m."mga"
group by d."departement", m."mga"
order by d."departement";

---Q6: Calculate the number of sites with an ambulance by commune and by department (ambulance = 1.0).
select d."departement", co."commune", count (s."facdesc") as sites
from spa as s
inner join commune as co
on s."commune_id"=co."commune_id"
inner join departement as d
on co."departement_id"= d."departement_id"
where s."ambulance" = 1.0
group by d."departement", co."commune"
order by d."departement";

---Q7. Calculate the number of hospitals per 10k inhabitants by department.
with sum_pop as
	(select co."departement_id", sum(co."population") as com
	from commune as co
	group by co."departement_id")
select d."departement", count(*) as hospitals, sp."com",
		round((count(s."facdesc")*10000/com), 5) as Hopital_10000_habs
from spa as s
inner join commune as co
on s."commune_id"=co."commune_id"
inner join departement as d
on co."departement_id"= d."departement_id"
inner join sum_pop as sp
on d."departement_id"=sp."departement_id"
where s."facdesc_1" = 'HOPITAL'
group by d."departement", com
order by d."departement";

---Q8: Calculate the number of sites per 10k inhabitants per department
with sum_pop as
	(select co."departement_id", sum(co."population") as com
	from commune as co
	group by co."departement_id")
select d."departement", count(s."facdesc") as sites, com,
		round((count(s."facdesc")*10000/com), 5) as sites_10000_habs
from spa as s
inner join commune as co
on s."commune_id"=co."commune_id"
inner join departement as d
on co."departement_id"= d."departement_id"
inner join sum_pop as sp
on d."departement_id"=sp."departement_id"
group by d."departement", com
order by com desc;

---Q9: Calculate the number of beb per 1,000 inhabitants per department.
with sum_pop as
	(select co."departement_id", sum(co."population") as com
	from commune as co
	group by co."departement_id")
select d."departement", count(s."num_beds") as beds, com,
		round((count(s."num_beds")*1000/com), 5) as Beds_1000_habs
from spa as s
inner join commune as co
on s."commune_id"=co."commune_id"
inner join departement as d
on co."departement_id"= d."departement_id"
inner join sum_pop as sp
on d."departement_id"=sp."departement_id"
group by d."departement", com
order by com desc;

---Q10.How many communes have fewer dispensaries than hospitals?
with sum_hop as
	(select co."commune", co."commune_id", count(s."facdesc") as HOPITAL
	from commune as co
	inner join spa as s
	on co."commune_id"=s."commune_id"
	where facdesc_1 = 'HOPITAL'
	group by co."commune", co."commune_id"
	order by HOPITAL desc),
sum_dis as
	(select co."commune", co."commune_id", count(s."facdesc") as DISPENSAIRE
	from commune as co
	inner join spa as s
	on co."commune_id"=s."commune_id"
	where facdesc_1 = 'DISPENSAIRE'
	group by co."commune", co."commune_id"
	order by DISPENSAIRE desc)
select sh."commune", HOPITAL, DISPENSAIRE
from sum_hop as sh
inner join sum_dis as sd
on sh."commune_id"=sd."commune_id"
group by sh."commune", HOPITAL, DISPENSAIRE
having HOPITAL>DISPENSAIRE
order by commune;



---Q11:How many  Letality rate per month?
select round((sum(covid."deces")/(sum(covid."cas_confirmes"))),3) as tx_letalite, 
		dt."month"
from covid
inner join date_table as dt
on covid."Date_Id"=dt."Date_Id"
group by dt."month";


---Q12: How many Death rate per month?
select round((sum(covid."deces")/(sum(c."population"))),8) as tx_mortalite, 
		dt."month"
from covid
inner join date_table as dt
on covid."Date_Id"=dt."Date_Id"
inner join departement as d
on covid."departement_id"=d."departement_id"
inner join commune as c
on d."departement_id" = c."departement_id"
group by dt."month";

---Q13: How many Prevalence per month?
select dt."month", round(((sum(covid."cas_suspects" + covid."cas_confirmes"))/(sum(c."population"))),6) as prevalence 
from covid
inner join date_table as dt
on covid."Date_Id"=dt."Date_Id"
inner join departement as d
on covid."departement_id"=d."departement_id"
inner join commune as c
on d."departement_id" = c."departement_id"
group by dt."month"
order by prevalence desc;

---Q14: How many Prevalence by department?
select d."departement", round(((sum(covid."cas_suspects" + covid."cas_confirmes"))/(sum(c."population"))),8) as prevalence 
from covid
inner join date_table as dt
on covid."Date_Id"=dt."Date_Id"
inner join departement as d
on covid."departement_id"=d."departement_id"
inner join commune as c
on d."departement_id" = c."departement_id"
group by d."departement"
order by prevalence desc

---Q15 What is the variation of the prevalence per week
select dt."week", round(((sum(covid."cas_suspects" + covid."cas_confirmes"))/(sum(c."population"))),8) as prevalence 
from covid
inner join date_table as dt
on covid."Date_Id"=dt."Date_Id"
inner join departement as d
on covid."departement_id"=d."departement_id"
inner join commune as c
on d."departement_id" = c."departement_id"
group by dt."week"
order by dt."week";

