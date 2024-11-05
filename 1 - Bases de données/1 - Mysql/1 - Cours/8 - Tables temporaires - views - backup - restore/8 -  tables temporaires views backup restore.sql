#Les tables temporaires

	#ouvrir une base de données de tests
	use vols_203;

	#pilotes_tetuan sera une table permanance qui va contenir tous les pilotes qui habitent a tétouan
	create table pilotes_tetouan as select * from pilote where villepilote = 'tetouan';
    

    
    


	#pilotes casa sera une table temporaire qui va contenir durant la session en cours tous les pilotes qui habitent a casa
	#si on ouvre une autre session cette table ne sera pas disponible (elle est disponible juste dans la session en cours pour le l'utilisateur en cours)
	create temporary table pilotes_casa as select * from pilote where villepilote = 'casablanca';

	#exemple de creation d'une nouvelle table temporaire tva
	create temporary table tva (id int auto_increment primary key, name varchar(50), value double);
	insert into tva (name, value) values ('normal', 0.2),('service',0.14),('reduit',0.07);
	select * from tva;


#Les vues
	#on va créer une sous requette nommée t1 qu'on ne peut utiliser que dans le contexte de la requette principale

	#sous requette t1
	with t1 as (select numvol, villed, villea, typeav 
				from vol join avion using (numav))
			
	#requtte principal
	select count(*) from t1;


	#impossible d'utiliser t1 en dehors de la requette precedente
	select * from t1;


	#on peut enregistrer une requette sous forme d'une vue pour a reutiliser ultérieurement dans d'autres requettes
	create view req_t1 as select numvol, villed, villea, typeav 
				from vol join avion using (numav);

	#on retutilise notre requette lorsqu'on le souhaite
	select * from req_t1;

	#une requette ne stock pas de données, elle recupére ces données a partir des tables qui la composent

	create view req_pilote_tanger as select * from pilote where villepilote = 'tanger';
	#la requette nous donne les pilotes de tanger
	select * from req_pilote_tanger;
	#on change dans la table pilote
	update pilote set villepilote = 'tetouan' where villepilote = 'tanger';

	#la requette ne donne plus rien
	select * from req_pilote_tanger;

#Le backup (la sauvegarde)


#pour utiliser mysqldump il faut soit entrer dans le dossier  C:\Program Files\MySQL\MySQL Server x.x\bin
# ou ajouter C:\Program Files\MySQL\MySQL Server x.x\bin a path systeme dans les variables d'environnement
#tapez mysqldump en ligne de commande pour tester s'il existe.


#utilise le post locale et le port 3306
mysqldump -u root -p cuisine_203 > cuisine_203.sql

#ici on a précisé le host avec -h et le port avec -P (maj)
mysqldump -h 127.0.0.1 -P 3306 -u root -p cuisine_203 > cuisine_203B.sql

#ici on a fourni aussi le mot de passe il doit être collé a -p (min)
mysqldump -h 127.0.0.1 -P 3306 -u root -p123456 cuisine_202 > cuisine_202B.sql
mysqldump -u root -p123456 cuisine_202 > cuisine_202B.sql






# Le Restore (Restoration ou la récupération