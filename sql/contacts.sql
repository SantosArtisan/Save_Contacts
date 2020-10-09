-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 09, 2020 at 05:59 AM
-- Server version: 5.7.31
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `teamcode_cbt`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `contact_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `contact_name` varchar(50) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `contact_address` varchar(50) NOT NULL,
  `contact_email` varchar(50) NOT NULL,
  `contact_picture` varchar(500) NOT NULL,
  `date_entry` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`contact_id`, `user_id`, `contact_name`, `contact_no`, `contact_address`, `contact_email`, `contact_picture`, `date_entry`) VALUES
(1, 0, 'ttt', 'ffg', 'ttt', 'ttt', 'image_picker2945337221793544148.jpg', '2020-10-07 11:11:44'),
(9, 2, 'Sani Abdullahindndndnskksksjsndjsjsjskskskskwkwkkw', '08687585', 'Sd', 'saniabdullahi442@gmail.com', 'image_picker5889006237180143567.jpg', '2020-10-08 14:03:14'),
(7, 2, 'Adam Musa', '0865555585', 'Sd', 'saniabdullahi442@gmail.com', 'image_picker889221536267001639.jpg', '2020-10-08 13:41:32'),
(8, 2, 'Sani Abdullahi', '08568556', 'Sd', 'saniabdullahi442@gmail.com', 'image_picker709259347532931934.jpg', '2020-10-08 13:56:06'),
(10, 2, 'Oga bala', '080635899996', 'Bbb', 'fghgf@hh.hgj', 'image_picker7464313318236823398.jpg', '2020-10-08 14:25:57'),
(15, 4, 'Flutter Dart', '08066441215', 'N0 12 Kano Road', 'naira@gmail.com', 'image_picker8197070716666164310.jpg', '2020-10-08 20:22:57'),
(12, 4, 'Dj Cuppy Yagadu', '0806633955', 'Gjffhfjgg', 'djcupcy@gmail.com', 'image_picker1818771337086664304.jpg', '2020-10-08 15:11:04'),
(13, 4, 'Mama Naija', '0809245757', 'Ggjggjggjnh', 'adammusa89@gmail.com', 'image_picker7305361247869970408.jpg', '2020-10-08 17:16:41'),
(14, 5, 'Oga bala', '0806555965596', '12 okojo Road', 'bala@gmail.com', 'image_picker1393884028798550453.jpg', '2020-10-08 18:12:57'),
(16, 4, 'Sani Abdullahi', '08165426897', 'No 3, Dart Road Kaduna', 'saniabdullahi442@gmail.com', 'image_picker6640173664848723927.jpg', '2020-10-08 21:05:56'),
(17, 4, 'Adam Musa Yau', '08063017470', 'No 12, Chocolate City Kaduna', 'adammusa89@gmail.com', 'image_picker849082675119042557.jpg', '2020-10-08 21:07:36'),
(18, 4, 'Yasir Murtala', '+234 810 256 4648', 'No 6, Zungeru Road, Kaduna', 'yasir.java@gmail.com', 'image_picker7883143259586939308.jpg', '2020-10-08 21:10:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contact_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
