/*PS9 : Qui affiche pour chaque recette :
- Un message sous la forme : "Recette : (Nom de la recette), temps de préparation : (Temps)
- La liste des ingrédients avec pour chaque ingrédient le nom et la quantité
- Un message sous la forme : Sa méthode de préparation est : (Méthode)
- Si le prix de reviens pour la recette est inférieur à 50 DH afficher le message
'Prix intéressant'*/


select ceiling(rand()*20);

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