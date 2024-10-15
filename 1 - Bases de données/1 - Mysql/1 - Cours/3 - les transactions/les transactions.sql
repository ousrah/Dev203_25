

-- gestion des erreurs


drop procedure if exists affectation;
delimiter $$
create procedure affectation(x int)
begin
	declare y smallint; 
	declare exit handler for sqlexception
    begin
		select "prière de passer une valeur de type smallint";
	end;
    set y = x;
    select y;
end $$
delimiter ;
call affectation(4548758);




drop database if exists bank_203;
create database bank_203 collate utf8mb4_general_ci;
use bank_203;

drop table if exists account;
create table account (
account_number int primary key ,
funds decimal(8,2),
check (funds>=0),
check (funds<=50000));
    insert into account value (1,10000);
    insert into account value (2,10000);
    
    
    drop procedure if exists transfert;
    delimiter $$
	create procedure transfert(toAcc int, fromAcc int, amount double)
    begin
    declare exit handler for sqlexception
    begin
		select "operation annulée" as message;
        rollback;
    end;
		start transaction;
			update account set funds = funds + amount where account_number = toAcc;
			update account set funds = funds - amount where account_number = fromAcc;
		commit;
		select "Transfert effectuée avec succes" as message;
    end $$
    delimiter ;
    
    
    select * from account;
    call transfert(2,1,2000);
     call transfert(2,1,5000);
     call transfert(2,1,5000);
    
    