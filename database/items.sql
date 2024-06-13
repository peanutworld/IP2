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

-- Dumping structure for table infproj2.items
CREATE TABLE IF NOT EXISTS `items` (
  `itemGuid` varchar(36) NOT NULL DEFAULT '',
  `orderGuid` varchar(36) DEFAULT NULL,
  `articleGuid` varchar(36) DEFAULT NULL,
  `firstSideGuid` varchar(36) DEFAULT NULL,
  `secondSideGuid` varchar(36) DEFAULT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`itemGuid`),
  KEY `FK_items_orders` (`orderGuid`),
  KEY `FK_items_articles` (`articleGuid`),
  KEY `FK_items_sides` (`firstSideGuid`),
  KEY `FK_items_sides_2` (`secondSideGuid`),
  CONSTRAINT `FK_items_articles` FOREIGN KEY (`articleGuid`) REFERENCES `articles` (`articlesGuid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_items_orders` FOREIGN KEY (`orderGuid`) REFERENCES `orders` (`orderGuid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_items_sides` FOREIGN KEY (`firstSideGuid`) REFERENCES `sides` (`sidesGuid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_items_sides_2` FOREIGN KEY (`secondSideGuid`) REFERENCES `sides` (`sidesGuid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table infproj2.items: ~8 rows (approximately)
INSERT INTO `items` (`itemGuid`, `orderGuid`, `articleGuid`, `firstSideGuid`, `secondSideGuid`, `note`) VALUES
	('i1a2b3c4-d5e6-7890-abcd-ef1234567890', 'o1a2b3c4-d5e6-7890-abcd-ef1234567890', 'b1c2d3e4-j0k1-2345-lmno-567890def012', 's1a2b3c4-d5e6-7890-abcd-ef1234567890', 's2b3c4d5-e6f7-8901-bcde-f1234567890a', 'Bez luka molim'),
	('i2b3c4d5-e6f7-8901-bcde-f1234567890a', 'o1a2b3c4-d5e6-7890-abcd-ef1234567890', 'c1d2e3f4-n4o5-6789-pqrs-901234567890', 's3c4d5e6-f7g8-9012-cdef-1234567890ab', NULL, 'Ekstra sir'),
	('i3c4d5e6-f7g8-9012-cdef-1234567890ab', 'o2b3c4d5-e6f7-8901-bcde-f1234567890a', 'c2d3e4f5-o5p6-7890-qrst-012345678901', 's4d5e6f7-g8h9-0123-def1-234567890abc', NULL, 'Korice bez glutena'),
	('i4d5e6f7-g8h9-0123-def1-234567890abc', 'o2b3c4d5-e6f7-8901-bcde-f1234567890a', 'b2c3d4e5-k1l2-3456-mnop-67890ef12345', 's1a2b3c4-d5e6-7890-abcd-ef1234567890', 's5e6f7g8-h9i0-1234-ef12-34567890abcd', NULL),
	('i5e6f7g8-h9i0-1234-ef12-34567890abcd', 'o3c4d5e6-f7g8-9012-cdef-1234567890ab', 'c3d4e5f6-p6q7-8901-rstu-123456789012', 's1a2b3c4-d5e6-7890-abcd-ef1234567890', NULL, 'Bez maslina'),
	('i6f7g8h9-i0j1-2345-klmn-567890def123', 'o4d5e6f7-g8h9-0123-def1-234567890abc', 'd1e2f3g4-r8s9-0123-tuvw-345678901234', NULL, NULL, 'Malo majoneze'),
	('i7g8h9i0-j1k2-3456-lmno-67890ef12345', 'o5e6f7g8-h9i0-1234-ef12-34567890abcd', 'e1f2g3h4-v2w3-4567-xyza-789012345678', 's5e6f7g8-h9i0-1234-ef12-34567890abcd', NULL, 'Dodatni sirup'),
	('i8h9i0j1-k2l3-4567-mnop-7890f1234567', 'o5e6f7g8-h9i0-1234-ef12-34567890abcd', 'b2c3d4e5-k1l2-3456-mnop-67890ef12345', 's2b3c4d5-e6f7-8901-bcde-f1234567890a', NULL, 'Bez kiselih krastavaca');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
