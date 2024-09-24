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

-- F.	Les parents du cheval qui a remporté le plus grand nombre de compétitions

-- G.	Le montant total remporté par 'black' dans toutes les compétitions qu'il a remporté

-- H.	La catégorie que le cheval 'black' remporte le plus
