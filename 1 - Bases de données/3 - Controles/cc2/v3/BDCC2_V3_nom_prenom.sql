#1.	Fonctions
#A. Créez une fonction get_total_interventions qui prend en paramètre tech_id (ID d'un technicien) et retourne le nombre total d'interventions réalisées par ce technicien. (2 points)


#B. Créez une fonction get_piece_stock qui prend en paramètre piece_id (ID d'une pièce) et retourne le stock actuel de cette pièce. (2 points)


#2.	Procédures Stockées
#A. Créez une procédure stockée update_piece_stock qui prend en paramètres piece_id et quantity et met à jour le stock de la pièce spécifiée en soustrayant la quantité passée en paramètre. (2 points)


#B. Créez une procédure add_intervention qui prend en paramètres equip_id et tech_id, et ajoute une intervention dans la table interventions. (2 points)


#3.	Triggers
#A. Créez un trigger after_insert_intervention qui se déclenche après l'insertion d'une intervention dans la table interventions. Ce trigger doit mettre à jour le statut de l'équipement en maintenance. (2 points)


#B. Créez un trigger after_end_intervention qui se déclenche après la mise à jour d'une intervention pour marquer celle-ci comme terminée. Ce trigger doit mettre à jour le statut de l'équipement en opérationnel. (2 points)

#4.	Transactions
#Écrivez une procédure stockée new_intervention qui crée une nouvelle intervention pour un équipement donné, en acceptant comme paramètres le numéro de l'équipement et le numéro du technicien.
#Ajoutez en transaction l'intervention et mettez à jour le stock des pièces concernées.
#La transaction ne doit pas passer si le stock de la pièce nécessaire est zéro. (3 points)



#5.	Curseur
#Créez une procédure qui utilise un curseur pour afficher la liste de tous les équipements de la coopérative, ainsi que leur statut (disponible ou en maintenance). (3 points)


#6.	Gestion des Utilisateurs
#Créez un nouvel utilisateur SQL nommé maintenance_manager avec le mot de passe 123456 et accordez-lui tous les droits sur la table interventions. (2 points)
