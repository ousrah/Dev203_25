
select ceiling(rand()*20) as student;

-- A.	La liste des bien de type ‘villa’

-- methode 1 avec using

select b.*,t.nom_type 
from bien b 
 join type t using(id_type)
where t.nom_type='villa';

-- methode 2 avec on
select b.*,t.nom_type 
from bien b 
inner join type t on b.id_type=t.id_type
where t.nom_type='villa';

-- methode 3 ensembliste (sous requette)
select * from bien 
where id_type in (select id_type from type
                  where nom_type='villa');

-- methode 4 avec "with"
with t as (select id_type, nom_type from type where nom_type ='villa')
select b.*, nom_type from bien b join t using(id_type);



-- B.	La liste des appartements qui se trouve à Tétouan

select b.* from bien b
join quartier q on q.id_quartier = b.id_quartier
join ville v on  v.id_ville = q.id_ville
join type t on t.id_type = b.id_type
where v.nom_ville = 'tetouan' and t.nom_type = 'appartement';

select b.* from bien b
join quartier q using(id_quartier)
join ville v  using(id_ville)
join type t  using(id_type)
where v.nom_ville = 'tetouan' and t.nom_type = 'appartement';



select * from bien
where id_type in (	select id_type 
					from type 
                    where nom_type='appartement'
				)
and id_quartier in (
					select id_quartier 
                    from quartier 
                    where id_ville in (
								select id_ville 
                                from ville 
                                where nom_ville = 'tetouan'
									)
					);


with 
t as (	select id_type 
		from type 
        where nom_type = 'appartement'),
q as (	select q.id_quartier 
		from quartier q 
        join ville v using(id_ville) 
        where nom_ville='tetouan')
select b.* 
from bien b 
join t using (id_type)
join q using(id_quartier);

-- C.	La liste des appartements loués par M. Marchoud Ali

select b.* from bien b join type using (id_type)
        join contrat c using (reference)
        join client cl on c.id_client=cl.id_client
        where nom_type="appartement" and
        nom_client="marchoud" and prenom_client="ali";
        
with t as ( select id_type from type where nom_type ='appartement'),
c as (select reference 
		from client 
        join contrat using(id_client) 
        where nom_client='marchoud' and prenom_client='ali')

select b.* from bien b 
join t using(id_type)
join c using(reference);        



-- D.	Le nombre des appartements loués dans le mois en cours

select count(*) from contrat
join bien on bien.reference=contrat.reference
join type on type.id_type=bien.id_type
where nom_type='appartement' and
month(date_creation)=month(current_date()) and 
year(date_creation)=year(current_date())  ;



select count(*) from contrat 
join (	select reference 
		from bien join type using(id_type) 
        where nom_type='appartement') b using(reference)
where month(date_creation)=month(current_date()) and 
year(date_creation)=year(current_date())  ;


with b as (	select reference 
		from bien join type using(id_type) 
        where nom_type='appartement')
        
select count(*) from contrat 
join  b using(reference)
where month(date_creation)=month(current_date()) and 
year(date_creation)=year(current_date())  ;



-- E.	Les appartements disponibles actuellement à Martil dont le loyer est inférieur 
-- à 2000 DH triés du moins chère au plus chère

SELECT *
FROM bien b
    join quartier q ON b.id_quartier = q.id_quartier
    join ville v ON q.id_ville=v.id_ville
    join type t on b.id_type=t.id_type
    left join contrat using(reference)
    where v.nom_ville='martil'
    and t.nom_type='appartement'
    and b.loyer<2000
    and (id_contrat is null or date_sortie< curdate())
    ORDER BY b.loyer asc;
    
-- F.	La liste des biens qui n’ont jamais été loués
select * from bien
where reference not in (select distinct reference from contrat);

select b.* from bien b
left join contrat c using(reference)
where c.id_contrat is null;


-- G.	La somme des loyers du mois en cours
select sum(loyer_contrat)
from contrat c
join bien using(reference)
where month(c.date_entree)= month(curdate())
and year(c.date_entree)= year(curdate())
and (date_sortie is null or date_sortie >= curdate());