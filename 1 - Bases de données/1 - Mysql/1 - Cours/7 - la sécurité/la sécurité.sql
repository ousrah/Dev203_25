# la gestion des utilisateur

create user 'zaid'@'localhost' identified by '123456';  # zaid ne peut se connecter sur ce serveur qu'a partir de la machine locale
create user 'redouan'@'%' identified by '123456';   #redouan peut se connecter sur ce serveur de n'importe ou 

create user 'test'@'localhost' identified by '123456';   
set password for 'test'@'localhost' = 'abdefg'; #modifier le mot de passe
drop user if exists 'test'@'localhost'; #supprimer l'utilisateur


grant all privileges on  bank_203.* to 'zaid'@'localhost';
revoke all privileges on bank_203.* from 'zaid'@'localhost';


grant all privileges on  cuisine_203.recettes to 'zaid'@'localhost';
revoke all privileges on cuisine_203.recettes from 'zaid'@'localhost';



