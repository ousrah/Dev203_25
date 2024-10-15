drop database if exists salles_203;
create database salles_203 collate utf8mb4_general_ci;
use salles_203;


create table Salle (NumSalle int primary key,
 Etage int, NombreChaises int);
 
create table Transfert (
NumSalleOrigine int, 
NumSalleDestination int, 
DateTransfert date , 
NbChaisesTransférées int,
constraint fk_saleorigine foreign key (NumSalleOrigine) references salle(numSalle),
constraint fk_saleDestination foreign key (NumSalleDestination) references salle(numSalle)
);

alter table salle add constraint chk_nbChainse check( NombreChaises between 20 and 30 );
insert into salle values (1,1,24),(2,1,26), (3,1,26),(4,2,28);

drop procedure if exists transf;
delimiter $$
	create procedure transf(SalleOrigine int, salleDest int, nbChaises int ,Datetransfert date)
	begin
		declare exit handler for sqlexception
        begin 
			select "Impossible d’effectuer le transfert des chaises";
            rollback;
        end;
		start transaction;
			update salle set NombreChaises = NombreChaises + nbChaises where NumSalle = salleDest;
            update salle set NombreChaises = NombreChaises - nbChaises where NumSalle = SalleOrigine;
			insert into transfert value (SalleOrigine,salleDest,Datetransfert, nbChaises);
		commit;
    end $$
delimiter ;
call transf(2,3,4,curdate());
select * from salle;
select * from transfert;
