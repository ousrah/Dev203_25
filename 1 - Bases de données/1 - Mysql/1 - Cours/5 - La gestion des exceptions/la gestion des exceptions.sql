drop database if exists commerce;
create database commerce collate utf8mb4_general_ci;
use commerce;

create table produit(id int auto_increment primary key,
nom varchar(50) not null unique);


drop procedure if exists insert_produit;
delimiter $$
create procedure insert_produit(n varchar(50))
begin
	insert into produit value (null,n);
end $$
delimiter ;





# gestion des exceptions en général (ne fait pas la distinction entre les types d'erreurs
drop procedure if exists insert_produit;
delimiter $$
create procedure insert_produit(n varchar(50))
begin
	declare exit handler for sqlexception
    begin
		select "erreur d'insertion";
    end;
	insert into produit value (null,n);
    select "insertion effectuée avec succes";
end $$
delimiter ;



# gestion des exceptions en général (ne fait pas la distinction entre les types d'erreurs
drop procedure if exists insert_produit;
delimiter $$
create procedure insert_produit(n varchar(50))
begin
	declare flag boolean default false;
    begin
		declare exit handler for 1048 set flag = true;
        declare exit handler for 1062 set flag = true;
        insert into produit value (null,n);
    end;
    if flag then
		select "erreur d'insertion";
	else
		select "insertion effectuée avec success";
    end if;
end $$
delimiter ;


drop procedure if exists insert_produit;
delimiter $$
create procedure insert_produit(n varchar(50))
begin
	declare msg varchar(100) default '';
    begin
		declare exit handler for 1048 set msg = "le nom du produit ne peut pas être null";
        declare exit handler for 1062 set msg = concat("le produit ",n," existe déjà dans la table");
        insert into produit value (null,n);
    end;
    if msg != '' then
		select msg;
	else
		select "insertion effectuée avec success";
    end if;
end $$
delimiter ;



call insert_produit ('pc');
call insert_produit (null); #1048
call insert_produit ('imprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimante'); 
call insert_produit ('pc'); #1062
call insert_produit ('souris'); 
call insert_produit ('clavier'); 
call insert_produit ('claculatrice'); 


select * from produit;