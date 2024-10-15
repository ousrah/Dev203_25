drop database if exists ventes_203;
create database ventes_203 collate utf8mb4_general_ci;
use ventes_203;


create table product (
	id_product int auto_increment primary key,
	name varchar(50),
    stock int, 
    price double,
    check (stock > 0));

create table vente(
	id_vente int auto_increment primary key,
	qte int, 
	id_product int, 
	constraint fk_vente_product foreign key (id_product) references product(id_product) on delete cascade on update cascade
);

insert into product values 
(1,"pc",10,8000),
(2,"impirmante",20,4000),
(3,"scanner",30,3000),
(4,"table",100,1000),
(5,"disque dur",5,800),
(6,"clavier",8,500);

select * from product;
select * from vente;




-- trigger d'insertion
drop trigger if exists insertvente;
delimiter $$
create trigger insertvente  after insert on vente for each row
begin
	update product set stock = stock-new.qte where id_product = new.id_product;
end $$
delimiter ;

insert into vente value(null,1,1), (null,1,3), (null,1,4);


-- trigger de suppression
drop trigger if exists deletevente;
delimiter $$
create trigger deletevente  after delete on vente for each row
begin
	update product set stock = stock+old.qte where id_product = old.id_product;
end $$
delimiter ;

delete from vente where id_vente = 7;


-- trigger de modification

drop trigger if exists updatevente;
delimiter $$
create trigger updatevente  after update on vente for each row
begin
	update product set stock = stock+old.qte-new.qte where id_product = old.id_product;
end $$
delimiter ;

update vente set qte = 3 where id_vente = 6;
