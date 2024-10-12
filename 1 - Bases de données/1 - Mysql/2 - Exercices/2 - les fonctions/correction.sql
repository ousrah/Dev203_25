/*Exercice 1 :
Écrire une fonction qui renvoie une chaine qui sera exprimée sous la forme Jour, Mois et Année à partir 
d’une date passée comme paramètre où :
­	Mois est exprimé en toutes lettres
exemple : décembre 
Exemple : 12/09/2011 -----> 12 septembre 2011*/


drop function if exists date2car;
delimiter $$
	create function date2car(d date)
		returns varchar(100)
        deterministic
	begin
		declare j int default day(d);
        declare m int default month(d);
        declare a int default year(d);
        declare res varchar(100);

        set res = case m 
			when 1 then 'janvier'
            when 2 then 'fevrier'
            when 3 then 'mars'
            when 4 then 'avril'
            when 5 then 'mai'
            when 6 then 'juin'
            when 7 then 'juillet'
            when 8 then 'aout'
            when 9 then 'septembre'
            when 10 then 'octobre'
            when 11 then 'novembre'
            when 12 then 'decembre'
            else 'erreur'
		end;
            return concat(j,' ', res, ' ', a);
            
		end $$
	delimiter ;
    select date2car('2024-5-15');




drop function if exists date2car;
delimiter $$
create function date2car(d date)
	returns varchar(100)
    deterministic
    begin
		declare oldTimeSystem varchar(10) default @@lc_time_names;
        declare res varchar(50);
		set lc_time_names = 'fr_FR';
		set res =  date_format(d,'%W %d %M %Y');
        set lc_time_names = oldTimeSystem;
        return res;
	end $$
delimiter ;
    select date2car('2024-5-15');
	
    

/*Exercice 2:
Ecrire une fonction qui reçoit deux dates comme paramètre et calcule l’écart en fonction de l’unité de calcul passée à la fonction ;
L’unité de calcul peut être de type : jour, mois, année, heure, minute, seconde*/
drop function if exists ecart;
delimiter $$
create function ecart(d1 date , d2 date,unite varchar(50))
	returns int 
	deterministic
begin 
	declare d int;
    set d = case unite
		when 'jour' then 	timestampdiff(day,d1,d2) 
		when 'mois' then 	timestampdiff(month,d1,d2) 
		when 'annee' then 	timestampdiff(year,d1,d2) 
		when 'heure' then 	timestampdiff(hour,d1,d2) 
		when 'minute' then 	timestampdiff(minute,d1,d2) 
		when 'seconde' then 	timestampdiff(second,d1,d2) 
		else  -1
    end;
	return d ;
end $$
delimiter ;

select ecart('2010-12-02','2024-04-13','jour')


/*Exercice 3 : application sur la bd ‘gestion_vols’
Gestion vol
Pilote(numpilote,nom,titre,villepilote,daten,datedebut)
Vol(numvol,villed,villea,dated,datea, #numpil,#numav)
Avion(numav,typeav ,capav)*/




drop database if exists vols_203;

create database vols_203 collate utf8mb4_general_ci;
use vols_203;

create table Pilote(
numpilote int auto_increment primary key,
nom varchar(50) ,
titre varchar(50) ,
villepilote varchar(50) ,
daten date,
datedebut date);

create table Vol(numvol int auto_increment primary key,
villed varchar(50) ,
villea varchar(50) ,
dated date ,
datea date , 
numpil int not null,
numav int not null);

create table Avion(numav int auto_increment primary key,
typeav  varchar(50) ,
capav int);

alter table vol add constraint fk_vol_pilote foreign key(numpil) references pilote(numpilote);
alter table vol add constraint fk_vol_avion foreign key(numav) references avion(numav);


insert into avion values (1,'boeing',350),
						(2,'caravel',50),
                        (3,'airbus',500),
                        (4,'test',350);
                        
insert into pilote values (1,'hassan','M.','tetouan','2000-01-01','2022-01-01'),
						(2,'saida','Mme.','casablanca','1980-01-01','2002-01-01'),
						(3,'youssef','M.','tanger','1983-01-01','2002-01-01');



insert into vol values (1,'tetouan','casablanca','2023-09-10','2023-09-10',1,1),
						(2,'casablanca','tetouan','2023-09-10','2023-09-10',1,1),
						(3,'tanger','casablanca','2023-09-11','2023-09-11',2,2),
						(4,'casablanca','tanger','2023-09-11','2023-09-11',2,2),
						(5,'agadir','casablanca','2023-09-11','2023-09-11',3,3),
						(6,'casablanca','agadir','2023-09-11','2023-09-11',3,3),
                        (7,'tetouan','casablanca','2023-09-10','2023-09-12',1,1),
						(8,'casablanca','tetouan','2023-09-10','2023-09-12',1,1),
						(9,'tanger','casablanca','2023-09-11','2023-09-13',1,2),
						(10,'casablanca','tanger','2023-09-11','2023-09-13',1,2),
						(11,'agadir','casablanca','2023-09-11','2023-09-13',3,3),
						(12,'casablanca','agadir','2023-09-11','2023-09-13',3,3),
                        (13,'tetouan','casablanca','2023-09-10','2023-09-15',2,1),
						(14,'casablanca','tetouan','2023-09-10','2023-09-15',3,1);  




select ceiling(rand()*19);
#1.	Ecrire une fonction qui retourne le nombre de pilotes ayant effectué 
#un nombre de vols supérieur à un nombre donné comme paramètre ;
drop function if exists E3Q1;
delimiter $$
create function E3Q1(nb int)
	returns int
	reads sql data
begin
	declare d int;
	with f as (select numpil, count(numvol) 
			from pilote 
			join vol on pilote.numpilote = vol.numpil 
			group by numpil
			having count(numvol) > nb) 
	select count(*) into d from f;
	return d;
end $$
delimiter ;
select E3Q1(2);











#2.	Ecrire une fonction qui retourne la durée de travail d’un pilote
# dont l’identifiant est passé comme paramètre ;

-- la requete


drop function if exists E3Q2;
delimiter $$
create function E3Q2(nb int)
	returns int
	reads sql data
begin
	declare d int;
	select datediff(curdate(),datedebut) as dureeTravail into d 
    from pilote 
    where pilote.numpilote=nb;
	return d;
end $$
delimiter ;
select E3Q(3);
#3.	Ecrire une fonction qui renvoie le nombre des avions qui ne sont pas affectés à des vols ;

drop function if exists E3Q3;
delimiter $$
create function E3Q3()
	returns int
	reads sql data
begin
	declare d int;
	select count(numav) into d from avion
	where numav not in(select numav from vol);
	
	return d;
end $$
delimiter ;

select E3Q3();



#4.	Ecrire une fonction qui retourne le numero du plus ancien pilote qui a piloté 
# l’avion dont le numero est passé en paramètre ;


select p.numpilote , datedebut from pilote p join vol v on p.numpilote=v.numpil
join avion a using(numav)
where a.numav = 1
order by timestampdiff(day,datedebut,curdate()) desc
; 






drop function if exists E3Q4;
delimiter $$
create function E3Q4(av int)
returns int
reads sql data
begin
	declare d  int;
	with t1 as (select numpilote, datedebut from pilote where numpilote in (select numpil from vol where numav = av)),
	t2 as (select min(datedebut) as datedebut from t1)
	select t1.numpilote into d from t1 join t2 using (datedebut)
	limit 1;
	return d;
end $$
delimiter ;
select E3Q4(1);


#5.	Ecrire une fonction table qui retourne le nombre des pilotes dont le salaire est inférieur à une valeur passée comme paramètre ;
#impossible dans my sql

/*Exercice 4:
Considérant la base de données suivante :
DEPARTEMENT (ID_DEP, NOM_DEP, Ville)
EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE,#ID_DEP)
*/


drop database if exists employes_203;

create database employes_203 COLLATE "utf8mb4_general_ci";
use employes_203;


create table DEPARTEMENT (
ID_DEP int auto_increment primary key, 
NOM_DEP varchar(50), 
Ville varchar(50));

create table EMPLOYE (
ID_EMP int auto_increment primary key, 
NOM_EMP varchar(50), 
PRENOM_EMP varchar(50), 
DATE_NAIS_EMP date, 
SALAIRE float,
ID_DEP int ,
constraint fkEmployeDepartement foreign key (ID_DEP) references DEPARTEMENT(ID_DEP));

insert into DEPARTEMENT (nom_dep, ville) values 
		('FINANCIER','Tanger'),
		('Informatique','Tétouan'),
		('Marketing','Martil'),
		('GRH','Mdiq');

insert into EMPLOYE (NOM_EMP , PRENOM_EMP , DATE_NAIS_EMP , SALAIRE ,ID_DEP ) values 
('said','said','1990/1/1',8000,1),
('hassan','hassan','1990/1/1',8500,1),
('khalid','khalid','1990/1/1',7000,2),
('souad','souad','1990/1/1',6500,2),
('Farida','Farida','1990/1/1',5000,3),
('Amal','Amal','1990/1/1',6000,4),
('Mohamed','Mohamed','1990/1/1',7000,4);


#1.	Créer une fonction qui retourne le nombre d’employés


drop function if exists E4Q1;
delimiter $$
create function E4Q1()
returns int
reads sql data
begin
	declare d  int;
	select count(*) into d from employe;
	return d;
end $$
delimiter ;
select E4Q1();



#2.	Créer une fonction qui retourne la somme des salaires de tous les employés

drop function if exists E4Q2;
delimiter $$
create function E4Q2()
returns double
reads sql data
begin
	declare d  double;
	select sum(salaire) into d from employe;
	return d;
end $$
delimiter ;
select E4Q2();



#3.	Créer une fonction pour retourner le salaire minimum de tous les employés

drop function if exists E4Q3;
delimiter $$
create function E4Q3()
returns double
reads sql data
begin
	declare d  double;
	select min(salaire) into d from employe;
	return d;
end $$
delimiter ;
select E4Q3();




#4.	Créer une fonction pour retourner le salaire maximum de tous les employés


drop function if exists E4Q4;
delimiter $$
create function E4Q4()
returns double
reads sql data
begin
	declare d  double;
	select max(salaire) into d from employe;
	return d;
end $$
delimiter ;
select E4Q4();

/*5.	En utilisant les fonctions créées précédemment,
 Créer une requête pour afficher le nombre des employés,
 la somme des salaires, l
 e salaire minimum et le salaire maximum*/
select E4Q1() as nombreDesEmployes,E4Q2() as sommeDesSalaires,E4Q3() as salaireMin, E4Q4() as salaireMAx;


#6.	Créer une fonction pour retourner le nombre d’employés d’un département donné.
drop function if exists E4Q6;
delimiter $$
create function E4Q6(de int)
returns double
reads sql data
begin
	declare d  int;
		select count(*) into d from employe where de=Employe.id_dep;
	return d;
end $$
delimiter ;
select E4Q6(1);




#7.	Créer une fonction la somme des salaires des employés d’un département donné
drop function if exists E4Q7;
delimiter $$
create function E4Q7(de int)
returns double
reads sql data
begin
	declare d  int;
		select sum(salaire) into d from employe where de=Employe.id_dep;
	return d;
end $$
delimiter ;
select E4Q7(1);

#8.	Créer une fonction pour retourner le salaire minimum des employés d’un département donné
drop function if exists E4Q8;
delimiter $$
create function E4Q8(de int)
returns double
reads sql data
begin
	declare d  int;
		select min(salaire) into d from employe where de=Employe.id_dep;
	return d;
end $$
delimiter ;
select E4Q8(1);

#9.	Créer une fonction pour retourner le salaire maximum des employés d’un département.

drop function if exists E4Q9;
delimiter $$
create function E4Q9(de int)
returns double
reads sql data
begin
	declare d  int;
		select max(salaire) into d from employe where de=Employe.id_dep;
	return d;
end $$
delimiter ;
select E4Q9(1);


/*10.	En utilisant les fonctions créées précédemment,
 Créer une requête pour afficher pour les éléments suivants : 
a.	Le nom de département en majuscule. 
b.	La somme des salaires du département
c.	Le salaire minimum
d.	Le salaire maximum */


select upper(nom_dep) NomDepartement,
		E4Q7(ID_DEP) somme_des_salaires,
        E4Q8(ID_DEP) salaire_min,
        E4Q9(ID_DEP) SALAIRE_MAX 
	From departement  ;



#11.	Créer une fonction qui accepte comme paramètres 2 chaines 
# de caractères et elle retourne les deux chaines en majuscules concaténé
# avec un espace entre eux.


drop function if exists E4Q11;
delimiter $$
create function E4Q11(ch1 varchar(50), ch2 varchar(50))
	returns varchar(255)
	deterministic
	begin
		return ucase(concat(ch1, " ", ch2));
	end $$
delimiter ;

select E4Q11("mohamed","el kaid");


