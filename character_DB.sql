-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 31, 2025 at 03:06 PM
-- Server version: 5.7.24
-- PHP Version: 8.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `demon_slayer`
--

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `rank` varchar(50) NOT NULL,
  `type` enum('Demon','Slayer','Other') NOT NULL COMMENT 'Character category:',
  `abilities` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`id`, `name`, `description`, `rank`, `type`, `abilities`) VALUES
(1, 'Tanjiro Kamado', 'The protagonist, a kind-hearted demon slayer seeking a cure for his sister.', 'Demon Slayer', 'Slayer', 'Hinokami Kagura, Water Breathing, Total Concentration Breathing'),
(2, 'Zenitsu Agatsuma', 'A cowardly yet powerful demon slayer with exceptional hearing.', 'Demon Slayer', 'Slayer', 'Thunder Breathing, Godspeed Form'),
(3, 'Nezuko Kamado', 'Tanjiro\'s younger sister turned into a demon but retains her humanity.', 'null', 'Demon', 'Blood Demon Art: Exploding Blood, Regeneration, Size Manipulation'),
(4, 'Muzan Kibutsuji', 'The primary antagonist and progenitor of all demons.', 'Demon King', 'Demon', 'All Blood Demon Arts, Regeneration, Shapeshifting'),
(5, 'Giyu Tomioka', 'The stoic Water Hashira, known for his calm demeanor and exceptional swordsmanship.', 'Hashira', 'Slayer', 'Water Breathing (All Forms), Dead Calm'),
(6, 'Shinobu Kocho', 'The Insect Hashira, a poison expert with a gentle yet deadly fighting style.', 'Hashira', 'Slayer', 'Insect Breathing, Wisteria Poison, Needle Techniques'),
(7, 'Kyojuro Rengoku', 'The passionate Flame Hashira, always smiling and full of unyielding spirit.', 'Hashira', 'Slayer', 'Flame Breathing, Ninth Form: Rengoku'),
(8, 'Tengen Uzui', 'The flamboyant Sound Hashira, former ninja with explosive fighting techniques.', 'Hashira', 'Slayer', 'Sound Breathing, Musical Score, Dual Wielding Cleavers'),
(9, 'Inosuke Hashibira', 'Wild boar-raised demon slayer with brute strength and animalistic instincts.', 'Demon Slayer', 'Slayer', 'Beast Breathing, Self-Taught Swordsmanship, Enhanced Senses'),
(10, 'Kanao Tsuyuri', 'Shinobu\'s adopted sister, a silent fighter who uses coin flips for decisions.', 'Demon Slayer', 'Slayer', 'Flower Breathing, Quick Thinking, Enhanced Reflexes'),
(11, 'Mitsuri Kanroji', 'The cheerful Love Hashira with superhuman flexibility and a kind heart.', 'Hashira', 'Slayer', 'Love Breathing, Flexible Whip Sword, Enhanced Strength'),
(12, 'Muichiro Tokito', 'The young Mist Hashira with a foggy mind but genius-level combat skills.', 'Hashira', 'Slayer', 'Mist Breathing, Seventh Form: Obscuring Clouds'),
(13, 'Akaza', 'Upper Rank Three demon, a martial artist obsessed with worthy opponents.', 'Upper Moon', 'Demon', 'Destructive Death Blood Demon Art, Compass Needle, Air Type'),
(14, 'Doma', 'Upper Rank Two demon, a cult leader with a cheerful yet psychopathic personality.', 'Upper Moon', 'Demon', 'Blood Demon Art: Frozen Cloud, Tessenjutsu, Cryokinesis'),
(15, 'Kokushibo', 'Upper Rank One demon, Michikatsu Tsugikuni, Yoriichi\'s brother and Moon Breathing creator.', 'Upper Moon', 'Demon', 'Moon Breathing, Transparent World, Six Eyes'),
(16, 'Rui', 'Lower Moon Five demon, a spider family \"father\" with thread-based attacks.', 'Lower Moon', 'Demon', 'Blood Demon Art: Sticky Thread, Cocoon, Scissor Attack'),
(17, 'Enmu', 'Lower Rank One demon, a train conductor who manipulates dreams.', 'Lower Moon', 'Demon', 'Blood Demon Art: Sleep Manipulation, Dream World Creation'),
(18, 'Susamaru', 'Temari demon, playful and violent with her ball-based attacks.', 'Demon', 'Demon', 'Blood Demon Art: Temari Balls, Black Blood: Brambles'),
(19, 'Yahaba', 'Arrow demon, a floating head that controls arrows with his eyes.', 'Demon', 'Demon', 'Blood Demon Art: Arrows, Koketsu Arrow'),
(20, 'Yushiro', 'Tamayo\'s loyal demon assistant, skilled in illusion and support.', 'Demon', 'Demon', 'Blood Demon Art: Blindfold, Clones, Invisibility');

-- --------------------------------------------------------

--
-- Table structure for table `character_images`
--

CREATE TABLE `character_images` (
  `character_id` int(11) NOT NULL COMMENT 'Foreign key to characters.id',
  `image_id` int(11) NOT NULL COMMENT 'Foreign key to images.id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `character_images`
--

INSERT INTO `character_images` (`character_id`, `image_id`) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10),
(9, 11),
(10, 12),
(11, 13),
(12, 14),
(13, 15),
(14, 16),
(15, 17),
(16, 18),
(17, 19),
(18, 20),
(19, 21),
(20, 22);

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `url` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `name`, `url`) VALUES
(1, 'tanjiro', 'https://miro.medium.com/v2/1*ikhSU3f8HIp8PMgje2tS1g.jpeg'),
(2, 'tanjiro 2', 'https://i.pinimg.com/736x/f0/c0/13/f0c0136aa256b9ce10d6a6d482f79d2f.jpg'),
(3, 'zenitsu', 'https://wallpapers.com/images/featured/zenitsu-elxcv6kxzxsrpp69.jpg'),
(4, 'nezuko', 'https://m.media-amazon.com/images/I/71s+dCzA55L.jpg'),
(5, 'nezuko2', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShenC3-MbEl3i_lAUpHBtvtBR3KefvbhY8cQ&s'),
(6, 'Muzan', 'https://images6.alphacoders.com/136/thumb-1920-1368082.png'),
(7, 'Giyu Tomioka', 'https://images2.alphacoders.com/139/thumb-1920-1398033.jpg'),
(8, 'Shinobu Kocho', 'https://i.pinimg.com/736x/41/98/9a/41989a6b13eb181b698f38140329a794.jpg'),
(9, 'Kyojuro Rengoku', 'https://images2.alphacoders.com/136/thumbbig-1360775.webp'),
(10, 'Tengen Uzui', 'https://images6.alphacoders.com/128/thumb-440-1288415.webp'),
(11, 'Inosuke Hashibira', 'https://images8.alphacoders.com/136/thumb-440-1368293.webp'),
(12, 'Kanao Tsuyuri', 'https://images.alphacoders.com/114/thumb-440-1143273.webp'),
(13, 'Mitsuri Kanroji', 'https://images5.alphacoders.com/136/thumb-440-1368127.webp'),
(14, 'Muichiro Tokito', 'https://images3.alphacoders.com/131/thumb-440-1316633.webp'),
(15, 'Akaza', 'https://images5.alphacoders.com/132/thumb-440-1321233.webp'),
(16, 'Doma', 'https://mfiles.alphacoders.com/863/thumb-350-863299.jpg'),
(17, 'Kokushibo', 'https://images6.alphacoders.com/132/thumb-440-1323940.webp'),
(18, 'Rui', 'https://artfiles.alphacoders.com/128/thumb-800-128044.webp'),
(19, 'Kokushibo', 'https://images6.alphacoders.com/132/thumb-440-1323940.webp'),
(20, 'Rui', 'https://artfiles.alphacoders.com/128/thumb-800-128044.webp'),
(21, 'Enmu', 'https://images8.alphacoders.com/124/thumb-440-1248223.webp'),
(22, 'Susamaru', 'https://picfiles.alphacoders.com/360/thumb-1920-360980.png'),
(23, 'Yahaba', 'https://artfiles.alphacoders.com/128/thumb-800-128045.webp'),
(24, 'Yushiro', 'https://images2.alphacoders.com/101/thumb-440-1011112.webp');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `character_images`
--
ALTER TABLE `character_images`
  ADD PRIMARY KEY (`character_id`,`image_id`),
  ADD KEY `fk_image_id` (`image_id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `character_images`
--
ALTER TABLE `character_images`
  ADD CONSTRAINT `fk_character_id` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`),
  ADD CONSTRAINT `fk_image_id` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
