CREATE DATABASE IF NOT EXISTS `leanbnb`;
USE `leanbnb`;

-- Table utilisateur
CREATE TABLE `utilisateur` (
  `IDutilisateur` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `telephone` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL UNIQUE,
  `mdp` varchar(300) NOT NULL,
  `role` enum('utilisateur','administrateur') NOT NULL DEFAULT 'utilisateur',
  `photo_profil` varchar(150) DEFAULT NULL,
  `statut` enum('debloque','bloque','delete') NOT NULL DEFAULT 'debloque',
  PRIMARY KEY (`IDutilisateur`)
) ENGINE=InnoDB;

-- Table maison
CREATE TABLE `maison` (
  `IDmaison` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `description` varchar(200) NOT NULL,
  `ville` varchar(30) NOT NULL,
  `pays` varchar(30) NOT NULL,
  `prix_basse` decimal(10,2) NOT NULL DEFAULT 0,
  `prix_moyenne` decimal(10,2) NOT NULL DEFAULT 0,
  `prix_haute` decimal(10,2) NOT NULL DEFAULT 0,
  `image` varchar(200) NOT NULL,
  PRIMARY KEY (`IDmaison`)
) ENGINE=InnoDB;

-- Table indisponibilite
CREATE TABLE `indisponibilite` (
  `IDindisponibilite` int NOT NULL AUTO_INCREMENT,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `motif` varchar(100) NOT NULL,
  `IDmaison` int NOT NULL,
  PRIMARY KEY (`IDindisponibilite`),
  FOREIGN KEY (`IDmaison`) REFERENCES `maison` (`IDmaison`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table reservation
CREATE TABLE `reservation` (
  `IDreservation` int NOT NULL AUTO_INCREMENT,
  `date_arrive` date NOT NULL,
  `date_depart` date NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `statut` enum('annulée','payé','en attente','en_attente_validation') NOT NULL DEFAULT 'en attente',
  `IDmaison` int DEFAULT NULL,
  `IDutilisateur` int DEFAULT NULL,
  `date_reservation` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`IDreservation`),
  FOREIGN KEY (`IDmaison`) REFERENCES `maison` (`IDmaison`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`IDutilisateur`) REFERENCES `utilisateur` (`IDutilisateur`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table photo
CREATE TABLE `photo` (
  `IDphoto` int NOT NULL AUTO_INCREMENT,
  `chemin` varchar(200) NOT NULL,
  `description` varchar(100) NOT NULL,
  `IDmaison` int NOT NULL,
  PRIMARY KEY (`IDphoto`),
  FOREIGN KEY (`IDmaison`) REFERENCES `maison` (`IDmaison`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table saison
CREATE TABLE `saison` (
  `IDsaison` int NOT NULL AUTO_INCREMENT,
  `nom` enum('basse','moyenne','haute') NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  PRIMARY KEY (`IDsaison`)
) ENGINE=InnoDB;

-- ----------------------
-- DONNÉES PAR DÉFAUT
-- ----------------------

-- Utilisateur admin
INSERT INTO `utilisateur` (`nom`, `prenom`, `telephone`, `email`, `mdp`, `role`, `photo_profil`, `statut`) VALUES
('Montyne', 'Leandro', '0494241519', 'lmontyne14@gmail.com', '$2y$10$CopsYZRVEc2dv.cfYZYrze/IybJXckBbgZuTD4No6ml9NrhPn2nKO', 'administrateur', 'uploads/photos_profil/1747392864_98682ce6b0365f4e7ed3.jpg', 'debloque');

-- Maisons
INSERT INTO `maison` (`nom`, `description`, `ville`, `pays`, `prix_basse`, `prix_moyenne`, `prix_haute`, `image`) VALUES
('Villa dans les montagnes', 'Offrez-vous des vacances inoubliables dans notre magnifique villa située en plein cœur de l\'Italie, entre collines verdoyantes, villages pittoresques et paysages apaisants.', 'Agrigento', 'Italie', 150.00, 200.00, 280.00, 'uploads/maisons/1745560449_43219ba3705bbcab4106.jpg'),
('Villa proche de la mer', 'Belle villa tout confort située en Espagne, idéale pour des vacances entre amies ou en familles.', 'Lloret de Mar', 'Espagne', 180.00, 250.00, 320.00, 'uploads/maisons/1745560541_b7c72c794de6d375f239.jpg'),
('Maison de Campagne', 'Magnifique maison de campagne, idéale pour vos week-ends en famille, loin du bruit de la ville.', 'Gordes', 'France', 75.00, 100.00, 160.00, 'uploads/maisons/1747371374_62b1c884efe4c1f3b92d.jpg');

-- Photos
INSERT INTO `photo` (`chemin`, `description`, `IDmaison`) VALUES
('uploads/photos/1746958467_b1b4cc92088824d536b9.jpg', 'Vue extérieure', 1),
('uploads/photos/1746958467_cf3981fe8271ea2585ed.jpg', 'Chambre principale', 1),
('uploads/photos/1746958467_16ba96eee9f433444fc4.jpg', 'Piscine', 1),
('uploads/photos/1747371033_e41a3b6c6b529c5dda8e.jpg', 'Salon lumineux', 2),
('uploads/photos/1747371033_10ea4cb1507f8dd1c446.jpg', 'Cuisine équipée', 2),
('uploads/photos/1747371033_591568e6e9af478e209b.jpg', 'Vue mer', 2),
('uploads/photos_maisons/1747371374_a550aa4230199f71512d.jpg', 'Façade', 3),
('uploads/photos_maisons/1747371374_127bd9f98d0a1e72f083.jpg', 'Terrasse', 3),
('uploads/photos_maisons/1747371374_42c3e862f9582c5284b9.jpg', 'Salon', 3);

-- Saisons complètes
INSERT INTO `saison` (`nom`, `date_debut`, `date_fin`) VALUES
('basse', '2026-03-10', '2026-04-27'),
('haute', '2025-04-28', '2025-05-11'),
('moyenne', '2025-05-12', '2025-06-30'),
('haute', '2025-07-01', '2025-08-31'),
('moyenne', '2025-09-01', '2025-09-30'),
('moyenne', '2025-10-01', '2025-10-17'),
('basse', '2025-10-18', '2025-11-12'),
('moyenne', '2025-11-13', '2025-12-19'),
('haute', '2025-12-20', '2026-01-06'),
('moyenne', '2025-03-10', '2025-03-14'),
('haute', '2026-01-07', '2026-01-18'),
('haute', '2026-01-19', '2026-01-24'),
('basse', '2026-04-28', '2026-05-10'),
('moyenne', '2026-05-11', '2026-06-30');
