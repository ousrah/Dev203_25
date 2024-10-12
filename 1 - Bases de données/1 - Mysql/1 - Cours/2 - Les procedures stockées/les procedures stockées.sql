


use employes_203;

drop procedure if exists ls_bydep;
delimiter $$
create procedure ls_bydep(id int)
begin
	select * from departement where id_dep = id;
	select * from employe where id_dep = id;
end $$
delimiter ;

call ls_bydep(4);


drop procedure if exists somme;
delimiter $$
create procedure somme(a int, b int)
begin
	select a + b into @c;
end $$
delimiter ;

call somme (3,15);

select @c;




drop procedure if exists somme;
delimiter $$
create procedure somme( a int, b int,out c int)
begin
	set c =  a + b ;
end $$
delimiter ;

call somme (3,15,@y);

select @y;



drop procedure if exists maths;
delimiter $$
create procedure maths( a int, b int,out c int, out m int)
begin
	set c =  a + b ;
    set m =  a * b;
end $$
delimiter ;

call maths(3,15,@y, @z);

select @y, @z;