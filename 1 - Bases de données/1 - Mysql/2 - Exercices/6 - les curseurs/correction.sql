


/*PS9 : Qui affiche pour chaque recette :
- Un message sous la forme : "Recette : (Nom de la recette), temps de préparation : (Temps)
- La liste des ingrédients avec pour chaque ingrédient le nom et la quantité
- Un message sous la forme : Sa méthode de préparation est : (Méthode)
- Si le prix de reviens pour la recette est inférieur à 50 DH afficher le message
'Prix intéressant'*/




drop procedure if exists PS9;
delimiter $$
create procedure PS9()
begin
	declare flag boolean default false;
    declare num int;
    declare prix double ;
    declare methode varchar(50);
    declare c cursor for select numrec, methodepreparation from recettes;
    declare continue handler for not found set flag = true;
    open c;
		lp : loop
			fetch c into num, methode;
            if flag then
				leave lp;
			end if;
            select concat('Recette : ',nomrec, ' - Temps :',tempspreparation) as message from recettes where NumRec=num ;
			select nomIng,qteUtilisee from composition_recette join ingredients using(numIng) where NumRec=num ;
            select concat(" Sa méthode de préparation est : ", methode) as "méthode"; 
            select sum(PUIng*QteUtilisee) into prix from ingredients join composition_recette using (NumIng) where NumRec=num ;
            if prix < 5 then
				select concat('Prix interessant : ', format(prix,2)) as message ;
            end if ;
        end loop lp;
    close c;
end$$
delimiter ;

select * from composition_recette;


call PS9();
select * from recettes;


/*2 – Ajouter le trigger qui permet de modifier le prix des recettes  lorsqu'on change le prix unitaire d'un ingrédient ( voir le dernier exercice de la série des triggers)
*/

use cuisine_203;

 drop trigger if exists E2;
 delimiter $$
 create trigger E2 after update on ingredients for each row
	begin
		declare flag boolean default false;
		declare idRec int;
		declare nvPrix double;

		declare c cursor for  select numrec
								from composition_recette
								where numing=new.numing;
		declare continue handler for not found set flag=true;

		open c;
			b:loop
				fetch c into idRec;
				if flag then 
					leave b;
				end if;
				select sum(puing*qteutilisee) into nvPrix from ingredients join composition_recette using(numing) where numrec=idrec;
				update recettes set prix= nvPrix where numrec= idRec;
			end loop;
		close c;
	end $$
delimiter ;

update ingredients set puing = 1.2 where numing = 2;


# Bases de données gestion vols

/*1)	Réalisez un curseur  qui extrait la liste des pilotes avec pour informations l’identifiant, le nom et le salaire du pilote ;
Affichez les informations à l’aide de l’instruction Select (print)
*/

use vols_203;
select * from pilote;
alter table pilote add salaire double;
update pilote set salaire = 50000 where numpilote = 1;
update pilote set salaire = 80000 where numpilote = 2;
update pilote set salaire = 90000 where numpilote = 3;

drop procedure if exists E3_Q1;
delimiter $$ 
create procedure E3_Q1()
begin 
	declare id int ;
    declare pname varchar(50);
    declare psalaire double ;
    declare flag boolean default false ;
    declare c1 cursor for select numpilote,nom,salaire from pilote ;
    declare continue handler for not found set flag=true;
    open c1 ;
		b:loop
			fetch c1 into id,pname,psalaire;
            if flag then 
				leave b;
			end if;
            select id,pname,psalaire;
        end loop b;
    close c1;
end $$ 
delimiter ;  

call E3_Q1();

select ceiling(rand()*20);


/*2)	Complétez le script précédent en imbriquant un deuxième curseur qui va préciser pour chaque pilote, quels sont les vols effectués par celui-ci.

Vous imprimerez alors, pour chaque pilote une liste sous la forme suivante :
- Le pilote ‘ xxxxx xxxxxxxxxxxxxxxxx est affecté aux vols :
       Départ : xxxx  Arrivée : xxxx
       Départ : xxxx  Arrivée : xxxx
       Départ : xxxx  Arrivée : xxxx
-Le pilote ‘ YYY YYYYYYYY est affecté aux vols :
       Départ : xxxx  Arrivée : xxxx
       Départ : xxxx  Arrivée : xxxx*/

select * from vol where numpil= 3;
drop procedure if exists E3_Q2;
delimiter $$ 
create procedure E3_Q2()
begin 
	declare id int ;
    declare pname varchar(50);
    declare psalaire double ;
    declare flag boolean default false ;
    declare c1 cursor for select numpilote,nom,salaire from pilote ;
	declare continue handler for not found set flag=true;
    open c1 ;
		b:loop
			fetch c1 into id,pname,psalaire;
            if flag then 
				leave b;
			end if;
            select id, pname, psalaire;
            select concat("le pilote ", pname," est affecté aux vols : ") as "pilote";
            begin
				declare flag2 boolean default false;
				declare va varchar(50);
                declare vd varchar(50);
                declare c2 cursor for select villea,villed from vol where numpil = id;
				declare continue handler for not found set flag2=true;
				open c2 ;
					b2:loop
						fetch c2 into va, vd ;
						if flag2 then
							leave b2;
						end if ;   
						select concat("Depart : " ,vd," - Arrive : " ,va) as "voyage";
					end loop b2;
				close c2;
            end ; 
        end loop b;
    close c1;
end $$ 
delimiter ;  

call E3_Q2();





/*3)	Vous allez modifier le curseur précédent pour pouvoir mettre à jour le salaire 
du pilote. Vous afficherz une ligne supplémentaire à la suite de la liste des vols en 
précisant l’ancien et le nouveau salaire du pilote.
Le salaire brut du pilote est fonction du nombre de vols auxquels il est affecté :
	Si 0 alors le salaire est 5 000
	Si entre 1 et 3,  salaire de 7 000
	Plus de 3, salaire de 8000
*/
drop procedure if exists E3_Q3;
delimiter $$ 
create procedure E3_Q3()
begin 
	declare id int ;
    declare pname varchar(50);
    declare psalaire double ;
    declare nvsalaire double;
    declare volcount int;
    declare flag boolean default false ;
    declare c1 cursor for select numpilote,nom,salaire from pilote ;
	declare continue handler for not found set flag=true;
    open c1 ;
		b:loop
			fetch c1 into id,pname,psalaire;
            if flag then 
				leave b;
			end if;
            select id, pname, psalaire;
            select concat("le pilote ", pname," est affecté aux vols : ") as "pilote";
            begin
				declare flag2 boolean default false;
				declare va varchar(50);
                declare vd varchar(50);
                declare c2 cursor for select villea,villed from vol where numpil = id;
				declare continue handler for not found set flag2=true;
                set volcount = 0;
				open c2 ;
					b2:loop
						fetch c2 into va, vd ;
						if flag2 then
							leave b2;
						end if ; 
                        set volcount = volcount+1;
						select concat("Depart : " ,vd," - Arrive : " ,va) as "voyage";
					end loop b2;
				close c2;
            end ; 
			#select count(*) into volcount from vol where numpil=id;
			if volcount =0 then
				set nvsalaire= 5000;
			elseif volcount between 1 and 3 then 
				set nvsalaire = 7000;
			else 
				set nvsalaire=8000;
			end if;
            update pilote set salaire = nvsalaire where numpilote = id;
            select concat("ancien salaire : ",psalaire," nouveau salaire :", nvsalaire);
        end loop b;
    close c1;
end $$ 
delimiter ;  

call E3_Q3();

update pilote set salaire = 0;
select * from pilote;

select * from vol where numpil = 1;

/*Exercice 2
Soit la base de données suivante

Employé :

Matricule	nom	prénom	état
1453	Lemrani	Kamal	fatigué
4532	Senhaji	sara	En forme
			…
			..

Groupe :
Matricule	Groupe
1453	Administrateur
1453	Chef
4532	Besoin vacances
…	
On désire ajouter les employés dont l’état est fatigué dans le groupe ‘besoin vacances’ dans la table Groupe;
Utiliser un curseur ;*/

drop database if exists vacances_203;
create database vacances_203 collate utf8mb4_general_ci;
use vacances_203;

create table employe (matricule int primary key, nom varchar(100), etat  varchar(100));
create table groupe (matricule int , groupe varchar(100), constraint fk_groupe_employe foreign key (matricule) references employe(matricule) on delete cascade on update cascade);

insert into employe values 
(1453,	'amal'	,'fatigué'),
(4532	,'sara'	,'En forme'),
(1454,	'Kamal'	,'fatigué'),
(4535	,'karima'	,'En forme'),
(1456,	'hasna'	,'fatigué'),
(4537	,'moad'	,'En forme'),
(1458,	'ziad'	,'fatigué'),
(4539	,'nada'	,'En forme'),
(1450,	'omar'	,'fatigué'),
(4531	,'mouna'	,'En forme');


select * from employe;

select * from groupe;

drop procedure if exists E4Q1;
delimiter $$
create procedure E4Q1 ()
begin
  declare id int;
  declare flag boolean default false;
  declare cur cursor for   select matricule from employe where etat="fatigué";
  declare continue handler for not found set flag=true;
  open cur;
	  label:loop
		  fetch cur into id;
		  if flag then
			 leave label;
		  end if;
		  insert into groupe values (id,"besoin_vacance");
	  end loop label;
  close cur;
end $$
delimiter ;

call E4Q1;

select * from employe where etat = 'fatigue';
select * from groupe;

#on peut resoudre ce problème sans utiser un curseur

delete from groupe;

insert into groupe select matricule , 'besoin_vacances' from employe where etat = 'fatigué';