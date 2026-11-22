-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 22, 2026 at 05:14 AM
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
-- Database: `cybershield_db`
--
CREATE DATABASE IF NOT EXISTS `cybershield_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cybershield_db`;

-- --------------------------------------------------------

--
-- Table structure for table `scan_history`
--

CREATE TABLE `scan_history` (
  `history_id` int(11) NOT NULL,
  `scan_id` int(11) NOT NULL,
  `scan_status` varchar(50) DEFAULT NULL,
  `viewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `security_reports`
--

CREATE TABLE `security_reports` (
  `report_id` int(11) NOT NULL,
  `scan_id` int(11) NOT NULL,
  `report_title` varchar(150) DEFAULT NULL,
  `report_summary` text DEFAULT NULL,
  `generated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `threat_results`
--

CREATE TABLE `threat_results` (
  `threat_id` int(11) NOT NULL,
  `scan_id` int(11) NOT NULL,
  `threat_type` varchar(100) DEFAULT NULL,
  `risk_level` varchar(20) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `url_scans`
--

CREATE TABLE `url_scans` (
  `scan_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `url` varchar(500) NOT NULL,
  `scan_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `scan_history`
--
ALTER TABLE `scan_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `scan_id` (`scan_id`);

--
-- Indexes for table `security_reports`
--
ALTER TABLE `security_reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `scan_id` (`scan_id`);

--
-- Indexes for table `threat_results`
--
ALTER TABLE `threat_results`
  ADD PRIMARY KEY (`threat_id`),
  ADD KEY `scan_id` (`scan_id`);

--
-- Indexes for table `url_scans`
--
ALTER TABLE `url_scans`
  ADD PRIMARY KEY (`scan_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `scan_history`
--
ALTER TABLE `scan_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `security_reports`
--
ALTER TABLE `security_reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `threat_results`
--
ALTER TABLE `threat_results`
  MODIFY `threat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `url_scans`
--
ALTER TABLE `url_scans`
  MODIFY `scan_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `scan_history`
--
ALTER TABLE `scan_history`
  ADD CONSTRAINT `scan_history_ibfk_1` FOREIGN KEY (`scan_id`) REFERENCES `url_scans` (`scan_id`) ON DELETE CASCADE;

--
-- Constraints for table `security_reports`
--
ALTER TABLE `security_reports`
  ADD CONSTRAINT `security_reports_ibfk_1` FOREIGN KEY (`scan_id`) REFERENCES `url_scans` (`scan_id`) ON DELETE CASCADE;

--
-- Constraints for table `threat_results`
--
ALTER TABLE `threat_results`
  ADD CONSTRAINT `threat_results_ibfk_1` FOREIGN KEY (`scan_id`) REFERENCES `url_scans` (`scan_id`) ON DELETE CASCADE;

--
-- Constraints for table `url_scans`
--
ALTER TABLE `url_scans`
  ADD CONSTRAINT `url_scans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
