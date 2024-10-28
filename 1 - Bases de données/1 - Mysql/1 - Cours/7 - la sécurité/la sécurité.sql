# la gestion des utilisateur

create user 'zaid'@'localhost' identified by '123456';  # zaid ne peut se connecter sur ce serveur qu'a partir de la machine locale
create user 'redouan'@'%' identified by '123456';   #redouan peut se connecter sur ce serveur de n'importe ou 

create user 'test'@'localhost' identified by '123456';   
set password for 'test'@'localhost' = 'abdefg'; #modifier le mot de passe
drop user if exists 'test'@'localhost'; #supprimer l'utilisateur


#donner tous les droits sur la base de données bank_203 pour zaid
grant all privileges on  bank_203.* to 'zaid'@'localhost';

#enlever tous les droits sur la base de données bank_203 de zaid
revoke all privileges on bank_203.* from 'zaid'@'localhost';

#donner tous les droits sur la  table recette de la bd cuisine_203 pour zaid
grant all privileges on  cuisine_203.recettes to 'zaid'@'localhost';

#enlever tous les droits sur la  table recette de la bd cuisine_203 de zaid
revoke all privileges on cuisine_203.recettes from 'zaid'@'localhost';

#afficher tous les droits attibués a zaid
show grants for 'zaid'@'localhost';
grant all privileges on  cuisine_203.recettes to 'zaid'@'localhost';
show grants for 'zaid'@'localhost';
grant all privileges on  bank_203.* to 'zaid'@'localhost';
show grants for 'zaid'@'localhost';


revoke all privileges on cuisine_203.recettes from 'zaid'@'localhost';

#donner des droits spécifiques aux utilisateurs
grant select on cuisine_203.recettes to 'zaid'@'localhost';
grant update on cuisine_203.recettes to 'zaid'@'localhost';
grant delete, insert on cuisine_203.recettes to 'zaid'@'localhost';


#donner les droits a un utilisateurs sur des champs spécifiques d'une table
grant select(numing, noming)  on cuisine_203.ingredients to 'zaid'@'localhost';
grant update(noming)  on cuisine_203.ingredients to 'zaid'@'localhost';


#un utilisateur normal ne peut pas créer une base de données;
# c'est le root qui doit créer la base et lui donner tous les droits sur cette base de données
create database testZaid collate utf8mb4_general_ci;
grant all privileges on testZaid.* to 'zaid'@'localhost';

#pour rafraichir les droits d'un utilisateur connecté
flush privileges;


#creation de plusieurs utilisateurs
create user u1@localhost identified by '123456';
create user u2@localhost identified by '123456';
create user u3@localhost identified by '123456';

#creation d'un role
create role lecture@localhost;

#donner les droits a un role
grant select on cuisine_203.* to lecture@localhost;

#ajouter un role a plusieurs utilisateurs
grant lecture@localhost to u1@localhost;
grant lecture@localhost to u2@localhost;
grant lecture@localhost to u3@localhost;

#valider les roles des utilisateurs
set default role all to u1@localhost;
set default role all to u2@localhost;
set default role all to u3@localhost;

#donner le droit d'eriture a tous les utilisateus

create role ecriture@localhost;
grant update, insert on cuisine_203.* to ecriture@localhost;

grant ecriture@localhost to u1@localhost;
grant ecriture@localhost to u2@localhost;
grant ecriture@localhost to u3@localhost;

set default role all to u1@localhost;
set default role all to u2@localhost;
set default role all to u3@localhost;

show grants for 'u1'@'localhost';

grant select on bank_203.* to u1@localhost;
show grants for 'u1'@'localhost';
