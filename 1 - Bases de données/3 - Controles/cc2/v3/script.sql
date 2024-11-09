DROP DATABASE IF EXISTS coop_maintenance;
CREATE DATABASE IF NOT EXISTS coop_maintenance;
USE coop_maintenance;

-- Table des équipements
CREATE TABLE equipements (
    equip_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(100),
    purchase_date DATE,
    last_service_date DATE,
    status ENUM('opérationnel', 'en maintenance', 'hors service') DEFAULT 'opérationnel'
) ENGINE=InnoDB;

-- Table des techniciens
CREATE TABLE techniciens (
    tech_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    expertise VARCHAR(100),
    contact_info VARCHAR(100)
) ENGINE=InnoDB;

-- Table des interventions
CREATE TABLE interventions (
    intervention_id INT AUTO_INCREMENT PRIMARY KEY,
    equip_id INT NOT NULL,
    tech_id INT NOT NULL,
    intervention_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT,
    status ENUM('programmée', 'en cours', 'terminée') DEFAULT 'programmée',
    FOREIGN KEY (equip_id) REFERENCES equipements(equip_id) ON DELETE CASCADE,
    FOREIGN KEY (tech_id) REFERENCES techniciens(tech_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table des pièces détachées
CREATE TABLE pieces (
    piece_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    stock INT DEFAULT 0
) ENGINE=InnoDB;


CREATE TABLE intervention_piece (
    intervention_id INT,
    piece_id INT,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (intervention_id, piece_id),
    FOREIGN KEY (intervention_id) REFERENCES interventions(intervention_id) ON DELETE CASCADE,
    FOREIGN KEY (piece_id) REFERENCES pieces(piece_id) ON DELETE CASCADE
)ENGINE=InnoDB;


USE coop_maintenance;

-- Insertion des techniciens
INSERT INTO techniciens (name, expertise, contact_info) VALUES
    ('Ahmed Zaki', 'Mécanique', 'ahmed.zaki@example.com'),
    ('Leila Hamidi', 'Hydraulique', 'leila.hamidi@example.com'),
    ('Mohamed Fahd', 'Électricité', 'mohamed.fahd@example.com'),
    ('Sara Bennis', 'Agronomie', 'sara.bennis@example.com'),
    ('Rachid Naimi', 'Soudure', 'rachid.naimi@example.com'),
    ('Nadia Khadiri', 'Électronique', 'nadia.khadiri@example.com'),
    ('Omar Touhami', 'Mécanique lourde', 'omar.touhami@example.com'),
    ('Fouad El Asri', 'Maintenance préventive', 'fouad.asri@example.com'),
    ('Khadija El Othmani', 'Électromécanique', 'khadija.othmani@example.com'),
    ('Hassan Majid', 'Contrôle de qualité', 'hassan.majid@example.com');

-- Insertion des équipements
INSERT INTO equipements (name, type, purchase_date, last_service_date, status) VALUES
    ('Tracteur A', 'Agricole', '2020-05-10', '2024-07-15', 'opérationnel'),
    ('Moissonneuse B', 'Récolte', '2019-04-20', '2024-06-10', 'opérationnel'),
    ('Pelle Mécanique C', 'Excavation', '2021-08-01', '2024-05-12', 'opérationnel'),
    ('Semoir D', 'Plantation', '2018-03-15', '2024-07-01', 'en maintenance'),
    ('Pulvérisateur E', 'Protection des cultures', '2022-11-05', '2024-04-20', 'opérationnel'),
    ('Tracteur F', 'Agricole', '2020-10-30', '2024-05-18', 'opérationnel'),
    ('Compresseur G', 'Pompage', '2023-01-25', '2024-08-03', 'opérationnel'),
    ('Charrue H', 'Labourage', '2017-12-18', '2024-06-25', 'opérationnel'),
    ('Moissonneuse I', 'Récolte', '2021-02-17', '2024-07-10', 'hors service'),
    ('Tracteur J', 'Agricole', '2019-06-14', '2024-08-08', 'en maintenance'),
    ('Semoir K', 'Plantation', '2018-04-01', '2024-07-09', 'opérationnel'),
    ('Pulvérisateur L', 'Protection des cultures', '2022-09-11', '2024-06-21', 'en maintenance'),
    ('Tracteur M', 'Agricole', '2023-05-05', '2024-05-19', 'opérationnel'),
    ('Moissonneuse N', 'Récolte', '2021-07-23', '2024-07-25', 'opérationnel'),
    ('Charrue O', 'Labourage', '2022-03-20', '2024-08-02', 'en maintenance'),
    ('Pulvérisateur P', 'Protection des cultures', '2019-12-30', '2024-08-05', 'opérationnel'),
    ('Pelle Mécanique Q', 'Excavation', '2020-06-17', '2024-07-27', 'opérationnel'),
    ('Tracteur R', 'Agricole', '2023-02-14', '2024-06-30', 'opérationnel'),
    ('Moissonneuse S', 'Récolte', '2021-10-11', '2024-07-11', 'hors service'),
    ('Tracteur T', 'Agricole', '2019-03-21', '2024-05-25', 'en maintenance');

-- Insertion des pièces détachées
INSERT INTO pieces (name, stock) VALUES
    ('Filtre à huile', 50),
    ('Courroie', 30),
    ('Bougie d\'allumage', 20),
    ('Batterie', 15),
    ('Roulement', 40),
    ('Pneumatique', 25),
    ('Ampoule', 60),
    ('Plaquette de frein', 35),
    ('Huile moteur', 100),
    ('Vis', 200),
    ('Courroie de distribution', 18),
    ('Pompe à eau', 10),
    ('Clé de filtre', 50),
    ('Filtre à air', 40),
    ('Pompe hydraulique', 12),
    ('Disque de frein', 30),
    ('Alternateur', 8),
    ('Pompe de relevage', 15),
    ('Joint de culasse', 5),
    ('Câble de batterie', 45);

-- Insertion des interventions
INSERT INTO interventions (equip_id, tech_id, intervention_date, description, status) VALUES
    (1, 1, '2024-09-01', 'Révision complète du moteur', 'terminée'),
    (2, 2, '2024-09-05', 'Changement de la courroie', 'terminée'),
    (3, 3, '2024-09-10', 'Remplacement du filtre à huile', 'terminée'),
    (4, 4, '2024-09-15', 'Réglage du semoir', 'en cours'),
    (5, 5, '2024-09-20', 'Vérification de l\'hydraulique', 'programmée'),
    (6, 6, '2024-09-25', 'Révision des freins', 'terminée'),
    (7, 7, '2024-09-30', 'Changement de la batterie', 'terminée'),
    (8, 8, '2024-10-02', 'Réparation du châssis', 'terminée'),
    (9, 9, '2024-10-05', 'Changement des pneus', 'en cours'),
    (10, 10, '2024-10-08', 'Réparation du moteur', 'programmée'),
    (11, 1, '2024-10-12', 'Entretien général', 'terminée'),
    (12, 2, '2024-10-15', 'Révision de la transmission', 'programmée'),
    (13, 3, '2024-10-20', 'Changement du filtre à air', 'en cours'),
    (14, 4, '2024-10-25', 'Vérification du système hydraulique', 'terminée'),
    (15, 5, '2024-10-30', 'Réglage de la pression des pneus', 'en cours'),
    (16, 6, '2024-11-01', 'Changement des plaquettes de frein', 'programmée'),
    (17, 7, '2024-11-04', 'Entretien du moteur', 'en cours'),
    (18, 8, '2024-11-07', 'Réparation des phares', 'terminée'),
    (19, 9, '2024-11-10', 'Vérification du système de refroidissement', 'programmée'),
    (20, 10, '2024-11-12', 'Réparation du système électrique', 'programmée'),
    (1, 1, '2024-11-15', 'Nettoyage du filtre à carburant', 'terminée'),
    (2, 2, '2024-11-18', 'Remplacement de la pompe hydraulique', 'programmée'),
    (3, 3, '2024-11-20', 'Contrôle de la batterie', 'terminée'),
    (4, 4, '2024-11-23', 'Lubrification des roulements', 'en cours'),
    (5, 5, '2024-11-25', 'Réparation du système de direction', 'programmée'),
    (6, 6, '2024-11-27', 'Changement du joint de culasse', 'terminée'),
    (7, 7, '2024-11-30', 'Vérification de la pression des pneus', 'programmée'),
    (8, 8, '2024-12-02', 'Réparation du système de freinage', 'en cours'),
    (9, 9, '2024-12-05', 'Remplacement des ampoules', 'terminée'),
    (10, 10, '2024-12-08', 'Réglage du système de transmission', 'programmée'),
    (11, 1, '2024-12-10', 'Contrôle de la courroie de distribution', 'en cours'),
    (12, 2, '2024-12-13', 'Remplacement du filtre hydraulique', 'programmée'),
    (13, 3, '2024-12-15', 'Révision du moteur', 'terminée'),
    (14, 4, '2024-12-18', 'Entretien du compresseur', 'programmée'),
    (15, 5, '2024-12-20', 'Vérification de la courroie d\'alternateur', 'terminée'),
    (16, 6, '2024-12-23', 'Lubrification du système de transmission', 'programmée');


-- Insertion de pièces utilisées dans l'intervention 1
INSERT INTO intervention_piece (intervention_id, piece_id, quantity) VALUES
    (1, 1, 2),  -- 2 filtres à huile
    (1, 3, 1),  -- 1 bougie d'allumage
    (1, 4, 1),
    (2, 2, 1),  -- 1 courroie
    (2, 5, 4),
    (3, 1, 1),  -- 1 filtre à huile
    (3, 6, 2),  -- 2 pneus
    (3, 7, 5),
    (4, 2, 1),  -- 1 courroie
    (4, 8, 2),  -- 2 plaquettes de frein
    (4, 10, 10),
    (5, 1, 3),  -- 3 filtres à huile
    (5, 9, 2),  -- 2 litres d'huile moteur
    (5, 11, 1),
    (6, 5, 3),  -- 3 roulements
    (6, 4, 1),  -- 1 batterie
    (6, 12, 1),
    (7, 1, 1),  -- 1 filtre à huile
    (7, 13, 2), -- 2 clés de filtre
    (7, 8, 4),
    (8, 2, 1),  -- 1 courroie
    (8, 14, 1), -- 1 filtre à air
    (8, 6, 2),
    (9, 5, 2),  -- 2 roulements
    (9, 7, 3),  -- 3 ampoules
    (9, 15, 1),
    (10, 3, 1),  -- 1 bougie d'allumage
    (10, 16, 2), -- 2 disques de frein
    (10, 17, 1); -- 1 alternateur
