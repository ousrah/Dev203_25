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
use courses203;



drop function if exists E1Degre;
delimiter &&
create function E1Degre(a float,b float)
returns varchar(50)
deterministic
begin 
	if a=0 then
		if b=0 then
			return "la solution est l'ensemble R";
		else	
			return "impossible";
		end if;
	else
		return concat("il y a un solution :",-b/a);
	end if;
end &&
delimiter ;

select E1Degre(5,4)




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

drop function if exists SolveEquation2Grade;
 delimiter $$
 create function SolveEquation2Grade(a int ,b int, c int)
 returns varchar(100)
 DETERMINISTIC
 begin
    DECLARE delta float;

    if(a=0) then
          if b=0 then
               if c=0 then
                  return "R";
		      ELSE
                 return "Impossible";
		      end if;
	      else
		   return (-c/b);
	    end if;
	else
		set delta=b*b-4*a*c;
		if delta<0 then 
				return "impossible";
		elseif delta=0 then
				return -b/(2*a);
		ELSE
				return concat("x1 = ",(-b-sqrt(delta))/(2*a)," ,x2= ",(-b+sqrt(delta))/(2*a));
		end if;
	end if;
 end $$
 delimiter ;
 select SolveEquation2Grade(0,0,0);
 select SolveEquation2Grade(0,0,5);
 select SolveEquation2Grade(0,2,8);
 select SolveEquation2Grade(1,2,-3);
 select SolveEquation2Grade(4,4,1);
 select SolveEquation2Grade(1,2,3);

#exercice ecrire une fonction qui recupère le numero d'une journée et qui affiche son nom en arabe.

"الأحد الإثنبن الثلاثاء الأربعاء الخميس الجمعة السبت";

# eviter de faire des comparaisons commen l'algorithme suivant

drop function if exists jour;
delimiter $$
create function jour(a int)
returns varchar(50)
deterministic
begin 
	declare j varchar(50);
	if a=1 then 
		set j =  "الأحد";
	end if;
	if a=2 then
	  set j =   "الإثنبن";
	end if;  
	if a=3 then
	  set j =   "الثلاثاء";
	end if;
	if a=4 then
	  set j =   "الأربعاء";
	end if;
	if a=5 then
	  set j =   "الخميس";
	end if;
	if a=6 then
	  set j =   "الجمعة";
	end if;
	if a=7 then
	  set j =   "السبت";
	end if;
	if a<1 or a>7 then
	 set j =   "Erreur";
	end if;
	return j;
end $$
delimiter ;
select jour(7);


#solution optimale

drop function if exists jour;
delimiter $$
create function jour(a int)
returns varchar(50)
deterministic
begin 
declare j varchar(50);
if a=1 then set j =  "الأحد";
elseif a=2 then  set j =   "الإثنبن";
elseif a=3 then  set j =   "الثلاثاء";
elseif a=4 then  set j =   "الأربعاء";
elseif a=5 then  set j =   "الخميس";
elseif a=6 then  set j =   "الجمعة";
elseif a=7 then  set j =   "السبت";
else  set j =   "Erreur";
end if;
return j;
end $$
delimiter ;
select jour(1);

#utilisation de case (forme1)

drop function if exists jour;
delimiter $$
create function jour(a int)
returns varchar(50)
deterministic
begin
declare j varchar(50);
set j = case a
when 1 then "الأحد"
when 2 then  "الإثنبن"
when 3 then  "الثلاثاء"
when 4 then  "الأربعاء"
when 5 then  "الخميس"
when 6 then  "الجمعة"
when 7 then  "السبت"
else "Erreur"
end ;
return j;
end $$
delimiter ;
select jour(3);




#utilisation de case (forme 2)

drop function if exists jour;
delimiter $$
create function jour(a int)
returns varchar(50)
deterministic
begin
declare j varchar(50);
set j = case
when a=1 then "الأحد"
when a=2 then  "الإثنبن"
when a=3 then  "الثلاثاء"
when a=4 then  "الأربعاء"
when a=5 then  "الخميس"
when a=6 then  "الجمعة"
when a=7 then  "السبت"
else "Erreur"
end ;
return j;
end $$
delimiter ;
select jour(1);



# equation 2eme degres avec case

drop function if exists SolveEquation2Grade;
 delimiter $$
 create function SolveEquation2Grade(a int ,b int, c int)
 returns varchar(100)
 DETERMINISTIC
 begin
    DECLARE delta float;
	declare r varchar(50);
    if(a=0) then
          if b=0 then
               if c=0 then
                  set r =  "R";
		      ELSE
                 set r =  "Impossible";
		      end if;
	      else
		    set r =  (-c/b);
	    end if;
	else
		set delta=b*b-4*a*c;
        set r =  case 
			when delta<0 then 		 "impossible"
			when delta=0 then		-b/(2*a)
			else	concat("x1 = ",(-b-sqrt(delta))/(2*a)," ,x2= ",(-b+sqrt(delta))/(2*a))
		end ;
	end if;
    return r;
 end $$
 delimiter ;
 select SolveEquation2Grade(0,0,0);
 select SolveEquation2Grade(0,0,5);
 select SolveEquation2Grade(0,2,8);
 select SolveEquation2Grade(1,2,-3);
 select SolveEquation2Grade(4,4,1);
 select SolveEquation2Grade(1,2,3);




# Les boucles 
#E1 - #ecrire une fonction qui calcule la somme des premiers entiers inférieur à n;
#utiliser les trois formes des boucles while, repeat et loop;












# la boucle while 
drop function if exists somme;
delimiter $$
create function somme(n int)
returns bigint
deterministic
begin
	declare s bigint default 0;
    declare i int default 1;
    while i<=n do
		set s= s + i;
        set i= i+1;
	end while;
	return s;
end $$
delimiter ;

select somme(5);
# la boucle repeat



drop function if exists somme;
delimiter $$
create function somme(n int)
returns bigint
deterministic
begin
	declare s bigint default 0;
    declare i int default 0;
    repeat 
		set s= s + i;
        set i= i+1;
	until i>n end repeat;
	return s;
end $$
delimiter ;

select somme(5);
select somme(4);
select somme(3);
select somme(2);
select somme(1);
select somme(0);


# la boucle loop



drop function if exists somme;
delimiter $$
create function somme(n int)
returns bigint
deterministic
begin
	declare s bigint default 0;
    declare i int default 0;
    l1:loop
		set s= s + i;
        set i= i+1;
        if i>n then
			leave l1;
        end if;
	end loop;
	return s;
end $$
delimiter ;

select somme(5);
select somme(4);
select somme(3);
select somme(2);
select somme(1);
select somme(0);



#E2 - #ecrire une fonction qui calcule la somme des premiers entiers paires inférieur ou égale à n;

drop function if exists somme;
delimiter $$
create function somme(n int)
returns bigint
deterministic
begin
	declare s bigint default 0;
    declare i int default 0;
    while i<=n do
		if i%2=0 then 
			set s= s + i;
        end if;
        set i= i+1;
	end while;
	return s;
end $$
delimiter ;

select somme(6);





#E3 - #ecrire une fonction qui calcule le factoriel d'un entier;
#Rappel 5! = 5x4x3x2;
# 1! = 1;
# 0! = 1;

drop function if exists facto;
delimiter $$
create function facto(n int)
returns bigint
deterministic
begin
	declare f bigint default 1;
    declare i int default 1;
    while i<=n  do
		set f= f * i;
        set i= i+1;
	end while;
	return f;
end $$
delimiter ;
select facto(5);
select facto(0);
select facto(1);




# les fonctions



set @x=5;
select somme(@x);
select facto(@x);


select dotation_session into @d from session where id_session = 1;
select somme(@d);

drop function if exists getDotation;
delimiter $$
create function getDotation(id int)
	returns float
    reads sql data
begin
	declare d float;
    -- select dotation_session into d from session where id_session = id;
    set d = (select dotation_session  from session where id_session = id);  # when select returns a scalar value
    
    return d;
end $$
delimiter ;

select getDotation(1);
select getDotation(1) into @d;
select @d


#les procedures stockées

# les transactions

#les triggers (les déclencheurs)

#la gestion des erreurs

#les curseurs

# la gestion des utilisateurs

# la sauvegarde et la restauration




