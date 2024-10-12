use courses203;

select ceiling(rand()*20);
-- A.	la liste de tous les cheveaux.
select * from cheval;

-- B.	la listes de champs qui peuvent acceuillir la catégorie "trot attelé"

select * from champ join organise using (id_champ)
					join categorie using(id_categorie)
                    where nom_categorie='trot attelé';


-- C.	la liste des cheveaux qui participent a la course "prix d'amérique" 
-- de la session 'Mars 2024' triés par classement

select cheval.*, classement from cheval join participe using (id_cheval)
							join session using (id_session)
							join course using(id_course)
							where nom_session="Mars 2024" and nom_course ="prix d'amérique"
							order by classement asc;





-- D.	la liste des jockeys qui ont monté le cheval "black" durant tout son historique
select distinct j.* from jockey j
join participe p using(ID_jockey) 
join cheval ch using(ID_cheval) 
where ch.NOM_CHEVAL="black";

select j.* from jockey j
join participe p on j.id_jockey=p.id_jockey
join cheval ch on p.id_cheval=ch.id_cheval
where ch.NOM_CHEVAL="black";

select * from jockey 
	where id_jockey in (select id_jockey 
						from participe 
                        where id_cheval in (select id_cheval 
											from cheval 
                                            where nom_cheval='black')
						);


with a as (
	select id_jockey, ch.nom_cheval from cheval ch join participe p using(id_cheval)
    where ch.nom_cheval="Black"
)
select j.*,a.nom_cheval from jockey j join a using(id_jockey);

select * from participe order by id_cheval;

-- E.	Le cheval qui a remporté le plus grand nombre de compétitions

with t1 as (select ch.id_cheval,ch.nom_cheval, count(ch.id_cheval) as nb_des_trophies from cheval ch
join participe p using(id_cheval)
where p.CLASSEMENT=1
group by ch.ID_CHEVAL, ch.nom_cheval)
select * from t1 where nb_des_trophies in ( select max(nb_des_trophies) 
											from t1);

select * from parent where id_cheval = 1;
-- F.	Les parents du cheval qui a remporté le plus grand nombre de compétitions

select c1.NOM_CHEVAL, c2.* from cheval c1 
			join parent p using(id_cheval)
			join cheval c2 on p.id_parent  = c2.id_cheval                                           
			where c1.id_cheval in (1,4);
            
            
with t1 as (select ch.id_cheval,ch.nom_cheval, count(ch.id_cheval) as nb_des_trophies from cheval ch
join participe p using(id_cheval)
where p.CLASSEMENT=1
group by ch.ID_CHEVAL, ch.nom_cheval),
champion as (select * from t1 where nb_des_trophies in ( select max(nb_des_trophies) 
											from t1))
select champion.nom_cheval, les_parents.*  
from champion  
left join parent using(id_cheval)
left join cheval les_parents on les_parents.id_cheval = parent.id_parent;

	
            
-- G.	Le montant total remporté par 'black' dans toutes les compétitions qu'il a remporté

select sum(dotation_session)
from cheval 
join participe using(id_cheval) 
join session using(id_session)
where nom_cheval = 'black'
and classement = 1;

-- H.	La catégorie que le cheval 'black' remporte le plus

with nb_vic_par_categorie as (select nom_categorie, count(id_categorie) as nb_victoires from cheval 
join participe using(id_cheval)
join session using(id_session)
join course using (id_course)
join categorie using(id_categorie)
where nom_cheval = 'black'
and classement = 1
group by nom_categorie),
max as (select max(nb_victoires) as nb_victoires from nb_vic_par_categorie)
select * from nb_vic_par_categorie join max using(nb_victoires);



