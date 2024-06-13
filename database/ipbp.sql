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


-- Dumping database structure for infprojektbp
CREATE DATABASE IF NOT EXISTS `infprojektbp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `infprojektbp`;

-- Dumping structure for table infprojektbp.addresses
CREATE TABLE IF NOT EXISTS `addresses` (
  `addressGuid` varchar(36) NOT NULL DEFAULT '',
  `userGuid` varchar(36) DEFAULT NULL,
  `streetName` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `postCode` int(11) DEFAULT NULL,
  PRIMARY KEY (`addressGuid`),
  KEY `FK_addresses_users` (`userGuid`),
  CONSTRAINT `FK_addresses_users` FOREIGN KEY (`userGuid`) REFERENCES `users` (`userGuid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table infprojektbp.addresses: ~8 rows (approximately)
INSERT INTO `addresses` (`addressGuid`, `userGuid`, `streetName`, `city`, `postCode`) VALUES
	('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'u1a2b3c4-d5e6-7890-abcd-ef1234567890', 'Stjepana Radica 13', 'Mostar', 88000),
	('a2b3c4d5-f6a7-8901-bcde-f1234567890a', 'u1a2b3c4-d5e6-7890-abcd-ef1234567890', 'Ometala bb', 'Prozor', 88440),
	('a3b4c5d6-g7h8-9012-ijkl-234567890bcd', 'u2b3c4d5-e6f7-8901-bcde-f1234567890a', 'Zvirici 11', 'Ljubuski', 88320),
	('a4b5c6d7-h8i9-0123-jklm-34567890bcde', 'u3c4d5e6-f7g8-9012-cdef-1234567890ab', 'Kralja Tomislava 21', 'Mostar', 88000),
	('a5b6c7d8-i9j0-1234-klmn-4567890cdef0', 'u4d5e6f7-g8h9-0123-def1-234567890abc', 'Kralja Zvonimira 15', 'Mostar', 88000),
	('a6b7c8d9-j0k1-2345-lmno-567890def012', 'u4d5e6f7-g8h9-0123-def1-234567890abc', 'Kralja Petra Kresimira IV', 'Mostar', 88000),
	('a7b8c9d0-k1l2-3456-mnop-67890ef12345', 'u5e6f7g8-h9i0-1234-ef12-34567890abcd', 'Zrinskog Frankopana', 'Mostar', 88000),
	('a8b9c0d1-l2m3-4567-nopq-7890f1234567', 'u5e6f7g8-h9i0-1234-ef12-34567890abcd', 'Hrvatske mladezi', 'Mostar', 88000);

-- Dumping structure for table infprojektbp.articles
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

-- Dumping data for table infprojektbp.articles: ~22 rows (approximately)
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

-- Dumping structure for table infprojektbp.groups
CREATE TABLE IF NOT EXISTS `groups` (
  `groupGuid` varchar(36) NOT NULL DEFAULT '',
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`groupGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table infprojektbp.groups: ~5 rows (approximately)
INSERT INTO `groups` (`groupGuid`, `name`) VALUES
	('b1c2d3e4-f5a6-7890-abcd-ef1234567890', 'Pice'),
	('b2c3d4e5-f6a7-8901-bcde-f1234567890a', 'Burgeri'),
	('b3c4d5e6-f7a8-9012-cdef-1234567890ab', 'Pizze'),
	('b4c5d6e7-f8a9-0123-def1-234567890abc', 'Sendvici'),
	('b5c6d7e8-f9a0-1234-ef12-34567890abcd', 'Palancinke');

-- Dumping structure for table infprojektbp.items
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

-- Dumping data for table infprojektbp.items: ~8 rows (approximately)
INSERT INTO `items` (`itemGuid`, `orderGuid`, `articleGuid`, `firstSideGuid`, `secondSideGuid`, `note`) VALUES
	('i1a2b3c4-d5e6-7890-abcd-ef1234567890', 'o1a2b3c4-d5e6-7890-abcd-ef1234567890', 'b1c2d3e4-j0k1-2345-lmno-567890def012', 's1a2b3c4-d5e6-7890-abcd-ef1234567890', 's2b3c4d5-e6f7-8901-bcde-f1234567890a', 'Bez luka molim'),
	('i2b3c4d5-e6f7-8901-bcde-f1234567890a', 'o1a2b3c4-d5e6-7890-abcd-ef1234567890', 'c1d2e3f4-n4o5-6789-pqrs-901234567890', 's3c4d5e6-f7g8-9012-cdef-1234567890ab', NULL, 'Ekstra sir'),
	('i3c4d5e6-f7g8-9012-cdef-1234567890ab', 'o2b3c4d5-e6f7-8901-bcde-f1234567890a', 'c2d3e4f5-o5p6-7890-qrst-012345678901', 's4d5e6f7-g8h9-0123-def1-234567890abc', NULL, 'Korice bez glutena'),
	('i4d5e6f7-g8h9-0123-def1-234567890abc', 'o2b3c4d5-e6f7-8901-bcde-f1234567890a', 'b2c3d4e5-k1l2-3456-mnop-67890ef12345', 's1a2b3c4-d5e6-7890-abcd-ef1234567890', 's5e6f7g8-h9i0-1234-ef12-34567890abcd', NULL),
	('i5e6f7g8-h9i0-1234-ef12-34567890abcd', 'o3c4d5e6-f7g8-9012-cdef-1234567890ab', 'c3d4e5f6-p6q7-8901-rstu-123456789012', 's1a2b3c4-d5e6-7890-abcd-ef1234567890', NULL, 'Bez maslina'),
	('i6f7g8h9-i0j1-2345-klmn-567890def123', 'o4d5e6f7-g8h9-0123-def1-234567890abc', 'd1e2f3g4-r8s9-0123-tuvw-345678901234', NULL, NULL, 'Malo majoneze'),
	('i7g8h9i0-j1k2-3456-lmno-67890ef12345', 'o5e6f7g8-h9i0-1234-ef12-34567890abcd', 'e1f2g3h4-v2w3-4567-xyza-789012345678', 's5e6f7g8-h9i0-1234-ef12-34567890abcd', NULL, 'Dodatni sirup'),
	('i8h9i0j1-k2l3-4567-mnop-7890f1234567', 'o5e6f7g8-h9i0-1234-ef12-34567890abcd', 'b2c3d4e5-k1l2-3456-mnop-67890ef12345', 's2b3c4d5-e6f7-8901-bcde-f1234567890a', NULL, 'Bez kiselih krastavaca');

-- Dumping structure for table infprojektbp.orders
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

-- Dumping data for table infprojektbp.orders: ~5 rows (approximately)
INSERT INTO `orders` (`orderGuid`, `userGuid`, `addressGuid`, `dateCreated`, `dateDelivered`, `status`, `note`) VALUES
	('o1a2b3c4-d5e6-7890-abcd-ef1234567890', 'u1a2b3c4-d5e6-7890-abcd-ef1234567890', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', '2024-05-01 12:00:00', '2024-05-01 12:45:00', 1, 'Ostavite na vratima'),
	('o2b3c4d5-e6f7-8901-bcde-f1234567890a', 'u2b3c4d5-e6f7-8901-bcde-f1234567890a', 'a3b4c5d6-g7h8-9012-ijkl-234567890bcd', '2024-05-02 13:00:00', NULL, 0, 'Nazvati po dolasku'),
	('o3c4d5e6-f7g8-9012-cdef-1234567890ab', 'u3c4d5e6-f7g8-9012-cdef-1234567890ab', 'a4b5c6d7-h8i9-0123-jklm-34567890bcde', '2024-05-03 14:00:00', NULL, 0, NULL),
	('o4d5e6f7-g8h9-0123-def1-234567890abc', 'u4d5e6f7-g8h9-0123-def1-234567890abc', 'a5b6c7d8-i9j0-1234-klmn-4567890cdef0', '2024-05-04 15:00:00', '2024-05-04 15:30:00', 1, 'Dostaviti na recepciju'),
	('o5e6f7g8-h9i0-1234-ef12-34567890abcd', 'u1a2b3c4-d5e6-7890-abcd-ef1234567890', 'a2b3c4d5-f6a7-8901-bcde-f1234567890a', '2024-05-05 16:00:00', NULL, 0, 'Dvaput pozvonite na vrata');

-- Dumping structure for table infprojektbp.sides
CREATE TABLE IF NOT EXISTS `sides` (
  `sidesGuid` varchar(36) NOT NULL DEFAULT '',
  `name` varchar(100) DEFAULT NULL,
  `price` decimal(20,2) DEFAULT NULL,
  PRIMARY KEY (`sidesGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table infprojektbp.sides: ~5 rows (approximately)
INSERT INTO `sides` (`sidesGuid`, `name`, `price`) VALUES
	('s1a2b3c4-d5e6-7890-abcd-ef1234567890', 'Pomfrit', 2.99),
	('s2b3c4d5-e6f7-8901-bcde-f1234567890a', 'Kolutići luka', 3.49),
	('s3c4d5e6-f7g8-9012-cdef-1234567890ab', 'Salata', 4.99),
	('s4d5e6f7-g8h9-0123-def1-234567890abc', 'Majoneza', 0.49),
	('s5e6f7g8-h9i0-1234-ef12-34567890abcd', 'Ketchup', 0.59);

-- Dumping structure for table infprojektbp.users
CREATE TABLE IF NOT EXISTS `users` (
  `userGuid` varchar(36) NOT NULL DEFAULT '',
  `username` varchar(100) DEFAULT '',
  `email` varchar(100) DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `phoneNumber` varchar(100) DEFAULT '',
  PRIMARY KEY (`userGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table infprojektbp.users: ~5 rows (approximately)
INSERT INTO `users` (`userGuid`, `username`, `email`, `password`, `phoneNumber`) VALUES
	('u1a2b3c4-d5e6-7890-abcd-ef1234567890', 'mario_jonjic', 'mariojonjic22@gmail.com', 'b2574c33e92dbd4007a086abb3a58fa7c35215765255b630236c9059e9d21761', '+38763588500'),
	('u2b3c4d5-e6f7-8901-bcde-f1234567890a', 'josip_jurkovic', 'josip.jurkovic003@gmail.com', 'ad1e37f8ad947948d7f258281836d8caef04ac449515e34f13bca7c6778b5f43', '+38763488148'),
	('u3c4d5e6-f7g8-9012-cdef-1234567890ab', 'david_grubisic', 'davidgrubisic11@gmail.com', 'a38a027d6265c124c70cafeb058cb4e58ac45935eb904efc3fb0de791c4662d3', '+38763830162'),
	('u4d5e6f7-g8h9-0123-def1-234567890abc', 'daniel_vasic', 'daniel.vasic@fpmoz.sum.ba', '7b716a75c5688600b0107d83107f40f4bd7ad7762ce3bcd1210e27fc71014f58', '+38763123321'),
	('u5e6f7g8-h9i0-1234-ef12-34567890abcd', 'niksa_ramljak', 'niksa.ramljak@gmail.com', 'af67806f84f9d410a744ba323d5d84baaf28dc1969d2fe2b45706f394856b8d6', '+38763456456');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
