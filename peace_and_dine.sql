-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 28 nov. 2023 à 16:00
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `peace_and_dine`
--

-- --------------------------------------------------------

--
-- Structure de la table `administrateurs`
--

CREATE TABLE `administrateurs` (
  `ID_Admin` int(11) NOT NULL,
  `mot_de_passe` varchar(50) NOT NULL,
  `rôle` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `avis`
--

CREATE TABLE `avis` (
  `Identifiant_avis` int(11) NOT NULL,
  `Commentaire` text NOT NULL,
  `Note` double NOT NULL,
  `Date_avis` date NOT NULL,
  `Auteur_avis` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `capteur_de_bruit`
--

CREATE TABLE `capteur_de_bruit` (
  `Numero_capteur` int(11) NOT NULL,
  `Type_de_capteur` varchar(30) NOT NULL,
  `Date_installation` date NOT NULL,
  `Niveau_sonore_capte` int(11) NOT NULL,
  `Fq_de_capture` double NOT NULL,
  `ID_data_capteur` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `data_capteur`
--

CREATE TABLE `data_capteur` (
  `ID_data_capteur` int(11) NOT NULL,
  `Mesure_capteur` double NOT NULL,
  `Numero_capteur` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `equipped`
--

CREATE TABLE `equipped` (
  `Numero_capteur` int(11) NOT NULL,
  `Numero_restaurant` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `restaurant`
--

CREATE TABLE `restaurant` (
  `Numero_restaurant` int(11) NOT NULL,
  `Nom` text NOT NULL,
  `Adresse` text NOT NULL,
  `type_de_cuisine` text NOT NULL,
  `capacity` int(20) NOT NULL,
  `Horaire` date NOT NULL,
  `identifiant_avis` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

CREATE TABLE `utilisateurs` (
  `ID_client` int(11) NOT NULL,
  `Mot_de_passe` varchar(5) NOT NULL,
  `Nom` text NOT NULL,
  `mail` text NOT NULL,
  `Identifiant_avis` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `administrateurs`
--
ALTER TABLE `administrateurs`
  ADD PRIMARY KEY (`ID_Admin`);

--
-- Index pour la table `avis`
--
ALTER TABLE `avis`
  ADD PRIMARY KEY (`Identifiant_avis`);

--
-- Index pour la table `capteur_de_bruit`
--
ALTER TABLE `capteur_de_bruit`
  ADD PRIMARY KEY (`Numero_capteur`),
  ADD KEY `ID_data_capteur` (`ID_data_capteur`);

--
-- Index pour la table `data_capteur`
--
ALTER TABLE `data_capteur`
  ADD PRIMARY KEY (`ID_data_capteur`),
  ADD KEY `Numero_capteur` (`Numero_capteur`);

--
-- Index pour la table `equipped`
--
ALTER TABLE `equipped`
  ADD PRIMARY KEY (`Numero_capteur`,`Numero_restaurant`),
  ADD KEY `Numero_restaurant` (`Numero_restaurant`);

--
-- Index pour la table `restaurant`
--
ALTER TABLE `restaurant`
  ADD PRIMARY KEY (`Numero_restaurant`),
  ADD KEY `identifiant_avis` (`identifiant_avis`);

--
-- Index pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD PRIMARY KEY (`ID_client`),
  ADD KEY `Identifiant_avis` (`Identifiant_avis`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `administrateurs`
--
ALTER TABLE `administrateurs`
  MODIFY `ID_Admin` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `avis`
--
ALTER TABLE `avis`
  MODIFY `Identifiant_avis` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `capteur_de_bruit`
--
ALTER TABLE `capteur_de_bruit`
  MODIFY `Numero_capteur` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `data_capteur`
--
ALTER TABLE `data_capteur`
  MODIFY `ID_data_capteur` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `restaurant`
--
ALTER TABLE `restaurant`
  MODIFY `Numero_restaurant` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  MODIFY `ID_client` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `capteur_de_bruit`
--
ALTER TABLE `capteur_de_bruit`
  ADD CONSTRAINT `capteur_de_bruit_ibfk_1` FOREIGN KEY (`ID_data_capteur`) REFERENCES `data_capteur` (`ID_data_capteur`);

--
-- Contraintes pour la table `data_capteur`
--
ALTER TABLE `data_capteur`
  ADD CONSTRAINT `data_capteur_ibfk_1` FOREIGN KEY (`Numero_capteur`) REFERENCES `capteur_de_bruit` (`Numero_capteur`);

--
-- Contraintes pour la table `equipped`
--
ALTER TABLE `equipped`
  ADD CONSTRAINT `equipped_ibfk_1` FOREIGN KEY (`Numero_capteur`) REFERENCES `capteur_de_bruit` (`Numero_capteur`),
  ADD CONSTRAINT `equipped_ibfk_2` FOREIGN KEY (`Numero_restaurant`) REFERENCES `restaurant` (`Numero_restaurant`);

--
-- Contraintes pour la table `restaurant`
--
ALTER TABLE `restaurant`
  ADD CONSTRAINT `restaurant_ibfk_1` FOREIGN KEY (`identifiant_avis`) REFERENCES `avis` (`Identifiant_avis`);

--
-- Contraintes pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD CONSTRAINT `utilisateurs_ibfk_1` FOREIGN KEY (`Identifiant_avis`) REFERENCES `avis` (`Identifiant_avis`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
