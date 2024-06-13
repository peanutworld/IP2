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

-- Dumping structure for table infproj2.articles
CREATE TABLE IF NOT EXISTS `articles` (
  `articlesGuid` varchar(36) NOT NULL DEFAULT '',
  `name` varchar(100) DEFAULT NULL,
  `price` decimal(20,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `groupGuid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`articlesGuid`) USING BTREE,
  KEY `FK_articles_groups` (`groupGuid`),
  CONSTRAINT `FK_articles_groups` FOREIGN KEY (`groupGuid`) REFERENCES `groups` (`groupGuid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table infproj2.articles: ~22 rows (approximately)
INSERT INTO `articles` (`articlesGuid`, `name`, `price`, `description`, `groupGuid`) VALUES
	('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Coca Cola', 1.99, 'Osvježavajući Coca Cola napitak', 'b1c2d3e4-f5a6-7890-abcd-ef1234567890'),
	('a2b3c4d5-f6a7-8901-bcde-f1234567890a', 'Pepsi', 1.99, 'Osvježavajući Pepsi napitak', 'b1c2d3e4-f5a6-7890-abcd-ef1234567890'),
	('a3b4c5d6-g7h8-9012-ijkl-234567890bcd', 'Cijedena naranca', 2.99, 'Svježe iscijeđeni sok od naranče', 'b1c2d3e4-f5a6-7890-abcd-ef1234567890'),
	('a4b5c6d7-h8i9-0123-jklm-34567890bcde', 'Limunada', 2.49, 'Domaća limunada', 'b1c2d3e4-f5a6-7890-abcd-ef1234567890'),
	('a5b6c7d8-i9j0-1234-klmn-4567890cdef0', 'Ledeni caj', 1.99, 'Ohlađeni čaj', 'b1c2d3e4-f5a6-7890-abcd-ef1234567890'),
	('b1c2d3e4-j0k1-2345-lmno-567890def012', 'Cheeseburger', 5.99, 'Klasični cheeseburger s cheddar sirom', 'b2c3d4e5-f6a7-8901-bcde-f1234567890a'),
	('b2c3d4e5-k1l2-3456-mnop-67890ef12345', 'Bacon Burger', 6.99, 'Burger s hrskavim trakicama slanine', 'b2c3d4e5-f6a7-8901-bcde-f1234567890a'),
	('b3c4d5e6-l2m3-4567-nopq-7890f1234567', 'Veggie Burger', 5.49, 'Vegetarijanski burger sa svježim povrćem', 'b2c3d4e5-f6a7-8901-bcde-f1234567890a'),
	('b4c5d6e7-m3n4-5678-opqr-890123456789', 'Double Burger', 7.99, 'Dupli pljeskavica s dodatnim sirom', 'b2c3d4e5-f6a7-8901-bcde-f1234567890a'),
	('c1d2e3f4-n4o5-6789-pqrs-901234567890', 'Margherita Pizza', 8.99, 'Klasična pizza Margherita sa svježim bosiljkom', 'b3c4d5e6-f7a8-9012-cdef-1234567890ab'),
	('c2d3e4f5-o5p6-7890-qrst-012345678901', 'Pepperoni Pizza', 9.99, 'Pizza feferoni s mozzarellom', 'b3c4d5e6-f7a8-9012-cdef-1234567890ab'),
	('c3d4e5f6-p6q7-8901-rstu-123456789012', 'BBQ Chicken Pizza', 10.99, 'BBQ pileća pizza sa crvenim lukom', 'b3c4d5e6-f7a8-9012-cdef-1234567890ab'),
	('c4d5e6f7-q7r8-9012-stuv-234567890123', 'Hawaiian Pizza', 9.49, 'Pizza sa šunkom i ananasom', 'b3c4d5e6-f7a8-9012-cdef-1234567890ab'),
	('d1e2f3g4-r8s9-0123-tuvw-345678901234', 'Pileci Sendvic', 5.99, 'Klasični sendvič s piletinom', 'b4c5d6e7-f8a9-0123-def1-234567890abc'),
	('d2e3f4g5-s9t0-1234-uvwx-456789012345', 'Sunka Sendvic', 5.49, 'Klasični sendvič sa sunkom', 'b4c5d6e7-f8a9-0123-def1-234567890abc'),
	('d3e4f5g6-t0u1-2345-vwxy-567890123456', 'Sir Sendvic', 6.99, 'Klasični sendvič sa sirom', 'b4c5d6e7-f8a9-0123-def1-234567890abc'),
	('d4e5f6g7-u1v2-3456-wxyz-678901234567', 'Pureci Sendvic', 5.99, 'Klasični sendvič s puretinom', 'b4c5d6e7-f8a9-0123-def1-234567890abc'),
	('e1f2g3h4-v2w3-4567-xyza-789012345678', 'Classic Palacinka', 4.99, 'Hrpa klasičnih palačinki sa sirupom', 'b5c6d7e8-f9a0-1234-ef12-34567890abcd'),
	('e2f3g4h5-w3x4-5678-yzab-890123456789', 'Proteinska Palacinka', 5.99, 'Palacinke bogate proteinima', 'b5c6d7e8-f9a0-1234-ef12-34567890abcd'),
	('e3f4g5h6-x4y5-6789-zabc-901234567890', 'Nutella Palacinka', 5.99, 'Palacinke sa nutellom', 'b5c6d7e8-f9a0-1234-ef12-34567890abcd'),
	('e4f5g6h7-y5z6-7890-abcd-012345678901', 'Banana Palacinka', 5.49, 'Palacinke sa bananom', 'b5c6d7e8-f9a0-1234-ef12-34567890abcd'),
	('e5f6g7h8-z6a7-8901-bcde-123456789012', 'Vocna Palacinka', 6.49, 'Palačinke sa svježim vocem', 'b5c6d7e8-f9a0-1234-ef12-34567890abcd');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
