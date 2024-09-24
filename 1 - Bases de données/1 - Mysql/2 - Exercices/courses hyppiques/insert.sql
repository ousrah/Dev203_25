use courses203;

/* Insertion de données dans la table CATEGORIE */
INSERT INTO CATEGORIE (NOM_CATEGORIE) VALUES 
('trot attelé'),
('trot monté'),
('obstacle'),
('galop');

/* Insertion de données dans la table CHAMP */
INSERT INTO CHAMP (NOM_CHAMP, NB_PLACES) VALUES 
('Hippodrome de Paris', 15000),
('Hippodrome de Marseille', 10000),
('Hippodrome de Lyon', 12000),
('Hippodrome de Bordeaux', 8000),
('Hippodrome de Deauville', 11000);

/* Insertion de données dans la table PROPRIETAIRE */
INSERT INTO PROPRIETAIRE (NOM_PROPRIETAIRE, PRENOM_PROPRIETAIRE) VALUES 
('Dupont', 'Michel'),
('Martin', 'Sophie'),
('Durand', 'Louis'),
('Lemoine', 'Julie'),
('Girard', 'François');


/* Insertion de données dans la table CHEVAL */
INSERT INTO CHEVAL (ID_PROPRIETAIRE, NOM_CHEVAL, DATE_NAISSACE, SEXE_CHEVAL) VALUES 
(1, 'Black', '2018-05-12', 'M'),
(2, 'Thunder', '2017-03-25', 'M'),
(3, 'Lightning', '2016-06-10', 'F'),
(1, 'Storm', '2019-09-21', 'F'),
(2, 'Flash', '2015-11-01', 'M'),
(3, 'Blaze', '2020-02-14', 'F'),
(4, 'Shadow', '2018-08-19', 'M'),
(5, 'Spirit', '2017-07-30', 'F'),
(1, 'Fire', '2019-12-01', 'M'),
(2, 'Wind', '2016-04-15', 'M');

/* Insertion de données dans la table COURSE */
INSERT INTO COURSE (ID_CATEGORIE, ID_CHAMP, NOM_COURSE) VALUES 
(1, 1, 'Prix d\'Amérique'),
(2, 2, 'Prix du Président'),
(3, 3, 'Prix de l\'Arc de Triomphe'),
(4, 4, 'Prix des Nations'),
(1, 5, 'Prix de France');

/* Insertion de données dans la table JOCKEY */
INSERT INTO JOCKEY (NOM_JOCKEY, PRENOM_JOCKEY) VALUES 
('Dupont', 'Jean'),
('Martin', 'Paul'),
('Durand', 'Pierre'),
('Lemoine', 'Jacques'),
('Girard', 'Luc'),
('Roux', 'Marc'),
('Blanc', 'Alain'),
('Legrand', 'Etienne'),
('Petit', 'Vincent'),
('Renaud', 'Thomas');

/* Insertion de données dans la table PARENT */
INSERT INTO PARENT (ID_CHEVAL, ID_parent) VALUES 
(1, 2),  -- Black est l'enfant de Thunder
(1, 3),  -- Black est l'enfant de Lightning
(4, 2),  -- Storm est l'enfant de Thunder
(4, 3),  -- Storm est l'enfant de Lightning
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 8),
(10, 9);


/* Insertion de données dans la table ORGANISE */
INSERT INTO ORGANISE (ID_CHAMP, ID_CATEGORIE) VALUES 
(1, 1), -- Hippodrome de Paris peut accueillir trot attelé
(1, 2), -- Hippodrome de Paris peut accueillir trot monté
(2, 3),
(3, 4),
(5, 1),
(5, 3);

/* Insertion de données dans la table SESSION */
INSERT INTO SESSION (ID_COURSE, NOM_SESSION, DATE_SESSION, DOTATION_SESSION) VALUES 
(1, 'Mars 2024', '2024-03-15 14:00:00', 50000),  -- Prix d'Amérique session Mars 2024
(2, 'Avril 2024', '2024-04-12 15:00:00', 60000),
(3, 'Mai 2024', '2024-05-22 16:00:00', 45000),
(4, 'Juin 2024', '2024-06-18 14:30:00', 70000),
(5, 'Juillet 2024', '2024-07-20 13:00:00', 55000);

/* Insertion de données dans la table PARTICIPE */
INSERT INTO PARTICIPE (ID_JOCKEY, ID_CHEVAL, ID_SESSION, CLASSEMENT) VALUES 
(1, 1, 1, 2),  -- Black
(2, 2, 1, 1),  -- Thunder
(3, 3, 1, 3),
(4, 4, 2, 1),
(5, 5, 2, 2),
(6, 6, 2, 1),
(7, 7, 2, 3),
(8, 8, 3, 1),
(9, 9, 3, 2),
(10, 10, 3, 1); 



