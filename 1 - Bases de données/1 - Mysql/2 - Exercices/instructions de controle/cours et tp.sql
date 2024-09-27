# les instructions de controle

#les blocks en mysql
drop function if exists hello;
delimiter $$
	create function hello()
		returns varchar(50)
		deterministic
	begin
		return "bonjour";
	end $$
delimiter ;

select hello();


# la declaration

drop function if exists addition;
delimiter $$
	create function addition()
		returns int
        deterministic
	begin
		declare a int default 4;
        declare b int default 5;
		return a+b;
    end $$
delimiter ;

select addition();




drop function if exists salutation;
delimiter $$
	create function salutation()
		returns varchar(50)
        deterministic
	begin
		declare hello varchar(50) default "bonjour";
        declare name  varchar(50)  default "mouna";
		return concat(hello," ",name);
    end $$
delimiter ;

select salutation();

#l'affectation

drop function if exists multiplication;
delimiter $$
	create function multiplication()
		returns bigint
        deterministic
	begin
        declare a int;
        declare b int;
		declare c int;
        set a = 3;
        set b = 5;
        set c = a*b;
        return c;
	end $$
delimiter ;

select multiplication();


drop function if exists soustraction;
delimiter $$
create function soustraction()
	returns int
    deterministic
    begin
		declare a,b,c int;
        set a = 5;
        select 6 into b;
        select b-a into c;
        return c;
    end $$
delimiter ;


select soustraction();



drop function if exists soustraction;
delimiter $$
create function soustraction()
	returns int
    deterministic
    begin
		declare a,b,c int;
        set a = 5 , b = 6;
        select b-a into c;
        return c;
    end $$
delimiter ;
select soustraction();

#La condition si

drop function if exists compare;
delimiter $$
	create function compare()
		returns int
        deterministic
	begin
		declare a ,b,c int;
        set a = 5,b=6;
        if a>b then
			set c = a;
        else
			set c = b;
        end if;
		return c;
    end $$
delimiter ;

select compare();



drop function if exists compare2;
delimiter $$
	create function compare2(a int, b int)
		returns int
        deterministic
	begin
		declare c int;
        if a>b then
			set c = a;
        else
			set c = b;
        end if;
		return c;
    end $$
delimiter ;

select compare2(13,4);

#exercice 1 :
#------------
/*
on souhaite ecrire une fonction qui accept trois entiers et qui 
retourne leur plus grande valeur
*/
select ceil(rand()*20);

drop function if exists calculmaximum ;
delimiter && 
create function calculmaximum (a int, b int ,c int ) 
	returns int
    deterministic
    begin
    declare d int ;
    if (a > b and a > c ) then 
		set d = a ;
    elseif( b>a and b> c) then
		set d = b ;
    else 
		set d= c;
    end if ;
    return d;
    end && 
delimiter ;

select calculmaximum(4,5,9); #9 operations
select calculmaximum(4,15,9); #9 operations
select calculmaximum(44,15,9); #6 operations

drop function if exists calculmaximum ;
delimiter && 
create function calculmaximum (a int, b int ,c int ) 
	returns int
    deterministic
    begin
    if (a > b and a > c ) then 
		return a ;
    elseif( b>a and b> c) then
		return b ;
    else 
		return c;
    end if ;
    end && 
delimiter ;

select calculmaximum(4,5,9); #7 operations
select calculmaximum(4,15,9); #7 operations
select calculmaximum(44,15,9); #4 operations



drop function if exists calculmaximum ;
delimiter && 
create function calculmaximum (a int, b int ,c int ) 
	returns int
    deterministic
    begin
		declare d int;
		set d = a;
		if b > d  then 
			set d = b;
		end if;
		if c > d then
			return c;
		end if;
		return d;
    end && 
delimiter ;

select calculmaximum(4,5,9); #6 operations
select calculmaximum(4,15,9); #5 operations
select calculmaximum(44,15,9); #5 operations



drop function if exists calculmaximum ;
delimiter && 
create function calculmaximum (a int, b int ,c int ) 
	returns int
    deterministic
    begin
		if a > b  then 
			if a > c then
				return a;
			else
				return c;
			end if;
		else
			if b>c then
				return b;
			else
				return c;
			end if;
		end if;
    end && 
delimiter ;

select calculmaximum(4,5,9); #3 operations
select calculmaximum(4,15,9); #3 operations
select calculmaximum(44,15,9); #3 operations



#exercice 2 :
/*
un patron décide de participer aux prix de repas de ces employer 
il instaure les règles suivantes :
le pourcentage de la participation par defaut est 20% du prix de repas
si le salaire est inférieur à 2500 dh le taux est augmenté de 15%
si l'employé est marié le taux est augmenté de 5%
pour chaque enfant a charge le taux est augmenté de 10%
le plafond maximal est 60%
on souhaite ecrire une fonction qui reçoit tous les paramètres 
et qui affiche le montant de la participation selon 
le prix de repas acheté par l'employé
*/


drop function if exists participation_repas;
delimiter $$
	create function participation_repas(repas float, salaire float,etat varchar(1),enfants int)
		returns float
		deterministic
    begin
		declare taux float;
        set taux=0.2;
        if salaire<2500 then 
			set taux=taux+.15;
        end if;
        if etat="o" then 
			set taux=taux+0.05;
        end if;
		set taux=taux+(enfants*0.1);
        if taux>0.6 then 
			set taux=0.6;
        end if;
		return repas*taux;
    end $$
delimiter ;

select participation_repas(100,5000,"o",4);





#exercice 3
/*
ecrire une fonction qui permet de resoudre une equation premier degrès
Ax+B=0

3x+2=0

Rappels mathématique
si A = 0 et B = 0  x = R
si A = 0 et B <> 0 x = impossible
si A <>  0 x = -b/a
*/


#exercice 4
/*
ecrire une fonction qui permet de resoudre une equation deuxième degrès
Ax²+Bx+C=0
2x²+3x+0=0

Rappels mathématique
si A = 0 et B = 0 et C = 0  x1 = x2 = R
si A = 0 et B = 0  et C <> 0 x1 = x2 = impossible
si A = 0 et B <> 0  x= -c/b
si A <> 0 
	 delta  = B²-4AC
     si delta < 0 x1 = impossible
     si delta = 0 x1 = x2 = -b/2a
      si delta > 0 x1 = (-b-racine(delta))/2a  et x2 =  (-b+racine(delta))/2a   
    */


# Les boucles while et repeat

# les fonctions





#les procedures stockées

# les transactions

#les triggers (les déclencheurs)

#la gestion des erreurs

#les curseurs

# la gestion des utilisateurs

# la sauvegarde et la restauration




