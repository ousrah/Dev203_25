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


#capturer le message d'erreur avec un diagnostic
# référence des sqlstate pour mysql https://www.briandunning.com/error-codes/?source=MySQL
drop procedure if exists insert_produit;
delimiter $$
create procedure insert_produit(n varchar(50))
begin
	declare flag boolean default false;
	declare v_errno int;
    declare v_msg varchar(250);
    declare v_sqlstate varchar(5);
    begin
		declare exit handler for sqlexception
        begin
			get diagnostics condition 1
				 v_sqlstate = returned_sqlstate,
                 v_errno = mysql_errno,
                 v_msg = message_text;
			set flag = true;
        end;
        insert into produit value (null,n);
        select "insertion effectuée avec success";
    end;
    if flag then
		select  concat("message d'erreur : ", v_msg, " - numero d'erreur: " , v_errno, " - etat d'erreur :  ", v_sqlstate) as "error";
	end if;
		
   
end $$
delimiter ;



#sqlstate

drop procedure if exists insert_produit;
delimiter $$
create procedure insert_produit(n varchar(50))
begin
	declare flag boolean default false;
	declare v_errno int;
    declare v_msg varchar(250);
    declare v_sqlstate varchar(5);
    begin
		declare exit handler for sqlstate '23000'  #, sqlstate '02000'
        begin
			get diagnostics condition 1
				 v_sqlstate = returned_sqlstate,
                 v_errno = mysql_errno,
                 v_msg = message_text;
			set flag = true;
        end;
        
         insert into produit value (null,n);
        select "insertion effectuée avec success";
    end;
    if flag then
		select  concat("message d'erreur : ", v_msg, " - numero d'erreur: " , v_errno, " - etat d'erreur :  ", v_sqlstate) as "error";
	end if;
		
   
end $$
delimiter ;




# not found
drop procedure if exists get_produit;
delimiter $$
create procedure get_produit(n int, out designation varchar(50))
begin
	declare flag boolean default false;
	declare v_errno int;
    declare v_msg varchar(250);
    declare v_sqlstate varchar(5);
    begin
		declare exit handler for not found
        begin
			get diagnostics condition 1
				 v_sqlstate = returned_sqlstate,
                 v_errno = mysql_errno,
                 v_msg = message_text;
			set flag = true;
        end;
        
        select nom into designation from produit where id = n;
    end;
    if flag then
		select  concat("message d'erreur : ", v_msg, " - numero d'erreur: " , v_errno, " - etat d'erreur :  ", v_sqlstate) as "error";
	end if;
		
   
end $$
delimiter ;


call get_produit(288, @x);
select @x;




drop procedure if exists division;
delimiter $$
create procedure division (a int, b int)
begin
	declare divi condition for sqlstate '11111';
    declare continue handler for divi
    resignal set message_text = "impossible de diviser par zero";
	if (b=0) then
		#déclancher une erruer
		signal divi;
	else
		select a / b;
	end if;
end $$
delimiter ;


call division (1,0);


select * from produit;

call insert_produit ('pc');
call insert_produit (null); #1048
call insert_produit ('imprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimanteimprimante'); 
call insert_produit ('pc'); #1062
call insert_produit ('souris'); 
call insert_produit ('clavier'); 
call insert_produit ('claculatrice'); 
call insert_produit ('table'); 
call insert_produit ('chaise'); 
call insert_produit ('armoire'); 

select * from produit;