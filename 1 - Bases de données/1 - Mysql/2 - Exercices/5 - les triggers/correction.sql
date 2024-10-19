/*EX 1 - Soit la base de données suivante :  (Utilisez celle de la série des fonctions):
Pilote(numpilote,nom,titre,villepilote,daten,datedebut)
Vol(numvol,villed,villea,dated,datea, #numpil,#numav)
Avion(numav,typeav ,capav)
*/

use vols_203;

# 1 – Ajouter la table pilote le champ nb d’heures de vols ‘NBHV’ sous la forme  « 00:00:00 ».

alter table pilote add nbhv time default "00:00:00";
alter table vol modify dated datetime;
alter table vol modify datea datetime;

#2 – Ajouter un déclencheur qui calcule le nombre heures lorsqu’on ajoute un nouveau vol et qui augmente automatiquement le nb d’heures de vols du pilote qui a effectué le vol.

drop trigger if exists insertvol;
delimiter $$
create trigger insertvol after insert on vol for each row
begin 
	declare t time;
	select nbhv into t from pilote where numpilote = new.numpil;
	if t is null then
		set t = "00:00:00";
	end if;
	update pilote set NBHV = addtime(t,timediff(new.datea,new.dated)) where numpilote = new.numpil;
end $$
delimiter ;

select * from pilote;
select *  from vol;
insert into vol values (null,'x','y','2024-10-19 08:00:00', '2024-10-19 14:00:00',1,1);
insert into vol values (null,'y','x','2024-10-19 14:00:00', '2024-10-19 18:00:00',1,1);
insert into vol values (null,'z','x','2024-10-19 15:00:00', '2024-10-19 18:00:00',2,1);
insert into vol values (null,'y','z','2024-10-19 16:00:00', '2024-10-19 18:30:00',3,1);


# 3 – Si on supprime un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.

drop trigger if exists supVol;
delimiter $$
create trigger supVol after delete on vol for each row
begin 
	update pilote set NBHV = subtime(NBHV,timediff(old.datea,old.dated)) where numpilote = old.numpil;
end $$
delimiter ;

delete from vol where numvol =20;


#4 – Si on modifie la date de départ ou d’arrivée d’un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.
select * from vol;

drop trigger if exists UpdateVol;
delimiter $$
create trigger UpdateVol after update on vol for each row
begin 
	# update pilote set NBHV = subtime(NBHV,timediff(old.datea,old.dated)) where numpilote = old.numpil;
    # update pilote set NBHV = addtime(NBHV,timediff(new.datea,new.dated)) where numpilote = old.numpil;
    
    update pilote set NBHV = addtime(subtime(NBHV,timediff(old.datea,old.dated)),timediff(new.datea,new.dated)) where numpilote = old.numpil;

    
end $$
delimiter ;
update vol set dated = "2024-10-19 12:00:00", datea = "2024-10-19 12:30:00" where numvol = 21; 




/*EX 2 - Soit la base de données suivante :  (Utilisez celle de la série des PS):

DEPARTEMENT (ID_DEP, NOM_DEP, Ville)
EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE, #ID_DEP)*/

use employes_203;
select * from departement;
select * from employe;

# 1 – Ajouter le champs salaire moyen dans la table département.
alter table departement add salaire_moyen double default 0;


# 2 – On souhaite que le salaire moyen soit recalculé automatiquement si on ajoute un nouvel employé,
# on supprime ou on modifie le salaire d’un ou plusieurs employés. Proposez une solution.

drop trigger if exists insertemp;
delimiter $$
create trigger insertemp after insert on employe for each row
begin
	update  departement set salaire_moyen=(select avg(salaire) from employe where id_dep=new.id_dep) where id_dep=new.id_dep;
end $$
delimiter ;

drop trigger if exists supemp;
delimiter $$
create trigger supemp after delete on employe for each row
begin
	update  departement set salaire_moyen=(select avg(salaire) from employe where id_dep=old.id_dep) where id_dep=old.id_dep;
end $$
delimiter ;

drop trigger if exists updateemp;
delimiter $$
create trigger updateemp after update on employe for each row
begin
	update  departement set salaire_moyen=(select avg(salaire) from employe where id_dep=new.id_dep) where id_dep=new.id_dep;
end $$
delimiter ;



delete from employe;
select *  from employe;
select * from departement;
insert into employe values (null,'x','x',null,5000,1);
insert into employe values (null,'y','y',null,10000,1);
insert into employe values (null,'z','z',null,8000,2);

update employe set salaire = 8000 where id_emp = 12;
delete from employe where id_emp = 13;


/*EX 3 - Soit la base de données suivante : (Utilisez celle de la série des PS):
Recettes (NumRec, NomRec, MethodePreparation, TempsPreparation)
Ingrédients (NumIng, NomIng, PUIng, UniteMesureIng, NumFou)
Composition_Recette (NumRec, NumIng, QteUtilisee)
Fournisseur (NumFou, RSFou, AdrFou)*/


use cuisine_203;
# 1 – Ajoutez le champ prix à la table recettes.
select * from recettes;
alter table recettes add prix double default 0;

# 2 – On souhaite que le prix de la recette soit calculé automatiquement si on ajoute un nouvel ingrédient, 
#on supprime un ingrédient ou on modifie la quantité ou le prix d’un ou plusieurs ingrédients. Proposez une solution. 

#insertion de nouvel ingrédient dans la recette

drop trigger if exists insertIng ;
delimiter $$
create trigger insertIng after insert on Composition_recette for each row
begin
update Recettes
	set prix = (
    select sum(PUIng * QteUtilisee) from ingredients join Composition_recette using(NumIng) 
    where NumRec = new.NumRec
    )
    where NumRec =new.NumRec;
end $$
delimiter ;


#modification du prix de l'ingrédient

drop trigger if exists updateIng;
delimiter $$
create trigger updateIng after update on ingredients for each row
begin
#on a besoin d'un curseur pour traiter chaque recette qui utilise l'ingrédient modifié
update Recettes
	set prix = (
    select sum(PUIng * QteUtilisee) from ingredients join Composition_recette using(NumIng) 
    where NumRec = new.NumRec
    )
    where NumRec =new.NumRec;
end $$
delimiter ;


#modification de la quantité de la composition recette
drop trigger if exists updateComp;
delimiter $$
create trigger updateComp after update on composition_recette for each row
begin
update Recettes
	set prix = (
    select sum(PUIng * QteUtilisee) from ingredients join Composition_recette using(NumIng) 
    where NumRec = new.NumRec
    )
    where NumRec =new.NumRec;
end $$
delimiter ;


#suppression d'un ingredient de la recette
drop trigger if exists deleteComp;
delimiter $$
create trigger deleteComp after delete on composition_recette for each row
begin
update Recettes
	set prix = (
    select sum(PUIng * QteUtilisee) from ingredients join Composition_recette using(NumIng) 
    where NumRec = old.NumRec
    )
    where NumRec =old.NumRec;
end $$
delimiter ;


select * from recettes;

select * from composition_recette;

insert into composition_recette values (1,1,1);
insert into composition_recette values (1,2,1);
delete from composition_recette where  numrec=1 and numing=2;

update composition_recette set qteutilisee = 2 where numrec=1 and numing=1; 
select * from ingredients;