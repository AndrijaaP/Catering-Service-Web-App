-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 29, 2025 at 12:27 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `keteringbaza`
--

-- --------------------------------------------------------

--
-- Table structure for table `kategorija`
--

CREATE TABLE `kategorija` (
  `kategorija_id` int(11) NOT NULL,
  `ime_kategorije` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategorija`
--

INSERT INTO `kategorija` (`kategorija_id`, `ime_kategorije`) VALUES
(1, 'Slano'),
(2, 'Slatko');

-- --------------------------------------------------------

--
-- Table structure for table `korisnik`
--

CREATE TABLE `korisnik` (
  `korisnik_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `sifra` varchar(50) NOT NULL,
  `ime` varchar(60) DEFAULT NULL,
  `prezime` varchar(60) DEFAULT NULL,
  `email` varchar(120) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `korisnik`
--

INSERT INTO `korisnik` (`korisnik_id`, `username`, `sifra`, `ime`, `prezime`, `email`, `role_id`) VALUES
(1, 'admin', 'admin', 'Admin', 'Admin', 'admin@example.com', 1),
(2, 'manager', 'manager', 'Manager', 'Manager', 'manager@example.com', 2),
(3, 'customer', 'customer', 'Customer', 'Customer', 'customer@example.com', 3),
(4, 'korisnik', 'korisnik', 'Korisnik', 'Korisnik', 'korisnik@example.com', 3);

-- --------------------------------------------------------

--
-- Table structure for table `paket`
--

CREATE TABLE `paket` (
  `paket_id` int(11) NOT NULL,
  `ime_paketa` varchar(100) NOT NULL,
  `kategorija_id` int(11) NOT NULL,
  `opis_paketa` text DEFAULT NULL,
  `iznos` decimal(10,2) NOT NULL,
  `broj_osoba` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `paket`
--

INSERT INTO `paket` (`paket_id`, `ime_paketa`, `kategorija_id`, `opis_paketa`, `iznos`, `broj_osoba`) VALUES
(1, 'Porodični Gozbeni Paket', 1, 'Obilan obrok sa roštiljem i prilozima za porodicu', 4500.00, 5),
(2, 'Posni Ketering', 1, 'Raznovrsna posna jela sa povrćem i krompirom', 2800.00, 3),
(3, 'Gurmanski Roštilj', 2, 'Ćevapi, pljeskavice i kobasice sa domaćim prilozima', 6500.00, 6),
(4, 'Poslovni Ručak', 1, 'Elegantna kombinacija mesa i salata za sastanke', 8000.00, 8),
(5, 'Slatki Užitak', 2, 'Asortiman domaćih kolača i baklava', 3500.00, 4),
(6, 'Voćni Desert', 2, 'Sveže voće i lagani slatkiši za proslave', 2700.00, 3),
(7, 'Slatka Proslava', 2, 'Torte i kolačići za rođendane', 5200.00, 6),
(8, 'Mini Slatki Paket', 2, 'Mali kolači i voćni deserti za manje okupljanja', 2000.00, 2),
(10, 'Test', 2, 'Slatko', 25000.00, 6);

-- --------------------------------------------------------

--
-- Table structure for table `porudzbina`
--

CREATE TABLE `porudzbina` (
  `porudzbina_id` int(11) NOT NULL,
  `korisnik_id` int(11) NOT NULL,
  `datum_vreme` datetime NOT NULL DEFAULT current_timestamp(),
  `adresa_isporuke` varchar(255) NOT NULL,
  `kontakt_telefon` varchar(30) NOT NULL,
  `napomena` text DEFAULT NULL,
  `status` enum('kreirana','u_pripremi','otkazana','isporucena') DEFAULT 'kreirana',
  `menadzer_id` int(11) DEFAULT NULL,
  `ukupni_iznos` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `porudzbina`
--

INSERT INTO `porudzbina` (`porudzbina_id`, `korisnik_id`, `datum_vreme`, `adresa_isporuke`, `kontakt_telefon`, `napomena`, `status`, `menadzer_id`, `ukupni_iznos`) VALUES
(2, 1, '2025-06-28 22:44:00', 'Ulica 1', '061111111', 'hitno', 'kreirana', 1, 48000.00),
(3, 1, '2025-06-28 23:31:25', 'Ulica 2', '0633333333', 'Brzo', 'kreirana', NULL, 26000.00),
(4, 1, '2025-06-28 23:33:28', 'Ulica 2', '0633333333', 'Brzo', 'kreirana', NULL, 26000.00),
(5, 4, '2025-06-29 00:21:36', 'Ulica Gladnih', '0615555555', '', 'kreirana', NULL, 34000.00),
(6, 1, '2025-06-29 00:24:59', 'Ulica', '123', '', 'kreirana', NULL, 2000.00);

-- --------------------------------------------------------

--
-- Table structure for table `porudzbina_stavka`
--

CREATE TABLE `porudzbina_stavka` (
  `stavka_id` int(11) NOT NULL,
  `porudzbina_id` int(11) NOT NULL,
  `paket_id` int(11) NOT NULL,
  `kolicina` int(11) NOT NULL DEFAULT 1,
  `cena_jedinicna` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `porudzbina_stavka`
--

INSERT INTO `porudzbina_stavka` (`stavka_id`, `porudzbina_id`, `paket_id`, `kolicina`, `cena_jedinicna`) VALUES
(3, 2, 1, 2, 9000.00),
(4, 2, 3, 2, 13000.00),
(5, 2, 4, 3, 24000.00),
(6, 2, 8, 1, 2000.00),
(7, 3, 3, 4, 26000.00),
(8, 4, 3, 4, 26000.00),
(9, 5, 3, 4, 26000.00),
(10, 5, 8, 4, 8000.00),
(11, 6, 8, 1, 2000.00);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `naziv_role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `naziv_role`) VALUES
(1, 'ADMINISTRATOR'),
(3, 'KLIJENT'),
(2, 'MENADZER');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kategorija`
--
ALTER TABLE `kategorija`
  ADD PRIMARY KEY (`kategorija_id`),
  ADD UNIQUE KEY `ime_kategorije` (`ime_kategorije`);

--
-- Indexes for table `korisnik`
--
ALTER TABLE `korisnik`
  ADD PRIMARY KEY (`korisnik_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `paket`
--
ALTER TABLE `paket`
  ADD PRIMARY KEY (`paket_id`),
  ADD KEY `kategorija_id` (`kategorija_id`);

--
-- Indexes for table `porudzbina`
--
ALTER TABLE `porudzbina`
  ADD PRIMARY KEY (`porudzbina_id`),
  ADD KEY `korisnik_id` (`korisnik_id`),
  ADD KEY `menadzer_id` (`menadzer_id`);

--
-- Indexes for table `porudzbina_stavka`
--
ALTER TABLE `porudzbina_stavka`
  ADD PRIMARY KEY (`stavka_id`),
  ADD KEY `porudzbina_id` (`porudzbina_id`),
  ADD KEY `paket_id` (`paket_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `naziv_role` (`naziv_role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kategorija`
--
ALTER TABLE `kategorija`
  MODIFY `kategorija_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `korisnik`
--
ALTER TABLE `korisnik`
  MODIFY `korisnik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `paket`
--
ALTER TABLE `paket`
  MODIFY `paket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `porudzbina`
--
ALTER TABLE `porudzbina`
  MODIFY `porudzbina_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `porudzbina_stavka`
--
ALTER TABLE `porudzbina_stavka`
  MODIFY `stavka_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `korisnik`
--
ALTER TABLE `korisnik`
  ADD CONSTRAINT `korisnik_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`);

--
-- Constraints for table `paket`
--
ALTER TABLE `paket`
  ADD CONSTRAINT `paket_ibfk_1` FOREIGN KEY (`kategorija_id`) REFERENCES `kategorija` (`kategorija_id`);

--
-- Constraints for table `porudzbina`
--
ALTER TABLE `porudzbina`
  ADD CONSTRAINT `porudzbina_ibfk_1` FOREIGN KEY (`korisnik_id`) REFERENCES `korisnik` (`korisnik_id`),
  ADD CONSTRAINT `porudzbina_ibfk_2` FOREIGN KEY (`menadzer_id`) REFERENCES `korisnik` (`korisnik_id`);

--
-- Constraints for table `porudzbina_stavka`
--
ALTER TABLE `porudzbina_stavka`
  ADD CONSTRAINT `porudzbina_stavka_ibfk_1` FOREIGN KEY (`porudzbina_id`) REFERENCES `porudzbina` (`porudzbina_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `porudzbina_stavka_ibfk_2` FOREIGN KEY (`paket_id`) REFERENCES `paket` (`paket_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
