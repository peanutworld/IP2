-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.3.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for infproj2
CREATE DATABASE IF NOT EXISTS `infproj2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `infproj2`;

-- Dumping structure for table infproj2.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `orderGuid` varchar(36) NOT NULL DEFAULT '',
  `userGuid` varchar(36) DEFAULT NULL,
  `addressGuid` varchar(36) DEFAULT NULL,
  `dateCreated` datetime DEFAULT NULL,
  `dateDelivered` datetime DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`orderGuid`),
  KEY `FK_orders_users` (`userGuid`),
  KEY `FK_orders_addresses` (`addressGuid`),
  CONSTRAINT `FK_orders_addresses` FOREIGN KEY (`addressGuid`) REFERENCES `addresses` (`addressGuid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_orders_users` FOREIGN KEY (`userGuid`) REFERENCES `users` (`userGuid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table infproj2.orders: ~5 rows (approximately)
INSERT INTO `orders` (`orderGuid`, `userGuid`, `addressGuid`, `dateCreated`, `dateDelivered`, `status`, `note`) VALUES
	('o1a2b3c4-d5e6-7890-abcd-ef1234567890', 'u1a2b3c4-d5e6-7890-abcd-ef1234567890', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', '2024-05-01 12:00:00', '2024-05-01 12:45:00', 1, 'Ostavite na vratima'),
	('o2b3c4d5-e6f7-8901-bcde-f1234567890a', 'u2b3c4d5-e6f7-8901-bcde-f1234567890a', 'a3b4c5d6-g7h8-9012-ijkl-234567890bcd', '2024-05-02 13:00:00', NULL, 0, 'Nazvati po dolasku'),
	('o3c4d5e6-f7g8-9012-cdef-1234567890ab', 'u3c4d5e6-f7g8-9012-cdef-1234567890ab', 'a4b5c6d7-h8i9-0123-jklm-34567890bcde', '2024-05-03 14:00:00', NULL, 0, NULL),
	('o4d5e6f7-g8h9-0123-def1-234567890abc', 'u4d5e6f7-g8h9-0123-def1-234567890abc', 'a5b6c7d8-i9j0-1234-klmn-4567890cdef0', '2024-05-04 15:00:00', '2024-05-04 15:30:00', 1, 'Dostaviti na recepciju'),
	('o5e6f7g8-h9i0-1234-ef12-34567890abcd', 'u1a2b3c4-d5e6-7890-abcd-ef1234567890', 'a2b3c4d5-f6a7-8901-bcde-f1234567890a', '2024-05-05 16:00:00', NULL, 0, 'Dvaput pozvonite na vrata');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
