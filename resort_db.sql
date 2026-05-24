-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 24, 2026 at 04:12 AM
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
-- Database: `resort_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_accommodations`
--

CREATE TABLE `tbl_accommodations` (
  `accommodation_id` int(11) NOT NULL,
  `accommodation_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `capacity` int(11) NOT NULL,
  `price_per_night` decimal(10,2) NOT NULL,
  `availability_status` enum('available','unavailable') NOT NULL DEFAULT 'available',
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_accommodations`
--

INSERT INTO `tbl_accommodations` (`accommodation_id`, `accommodation_name`, `description`, `capacity`, `price_per_night`, `availability_status`, `image_url`) VALUES
(1, 'Deluxe Ocean Suite', 'Spacious suite with panoramic ocean views, king-size bed, and private balcony.', 2, 5500.00, 'available', 'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=800&q=80'),
(2, 'Family Garden Villa', 'Two-bedroom villa surrounded by tropical gardens with a shared pool.', 5, 8200.00, 'available', 'https://images.unsplash.com/photo-1582268611958-ebfd161ef9cf?auto=format&fit=crop&w=800&q=80'),
(3, 'Standard Twin Room', 'Comfortable room with two single beds, ideal for friends or colleagues.', 2, 2800.00, 'available', 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=800&q=80'),
(4, 'Premium Cabana', 'Private beachfront cabana with direct sand access and outdoor shower.', 3, 6500.00, 'available', 'https://images.unsplash.com/photo-1439066615861-d1af74d74000?auto=format&fit=crop&w=800&q=80'),
(5, 'Honeymoon Cottage', 'Intimate cottage with a canopy bed, private jacuzzi, and sunset views.', 2, 7500.00, 'unavailable', 'https://images.unsplash.com/photo-1544644181-1484b3fdfc62?auto=format&fit=crop&w=800&q=80'),
(6, 'Backpacker Bunk', 'Budget-friendly shared room with individual lockers and common area.', 4, 1200.00, 'available', 'images/room_6a1196c917a0a2.39235878.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_amenities`
--

CREATE TABLE `tbl_amenities` (
  `amenity_id` int(11) NOT NULL,
  `amenity_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price_per_use` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_amenities`
--

INSERT INTO `tbl_amenities` (`amenity_id`, `amenity_name`, `description`, `price_per_use`) VALUES
(1, 'Swimming Pool', 'Olympic-size infinity pool overlooking the ocean.', 0.00),
(2, 'Spa & Massage', 'Full-body traditional massage with aromatherapy oils.', 1500.00),
(3, 'Kayak Rental', 'Single or tandem kayak for coastal exploration.', 800.00),
(4, 'Island Hopping Tour', 'Half-day guided tour to three nearby islands.', 2500.00),
(5, 'Bicycle Rental', 'Mountain bike for resort and village trails.', 300.00),
(6, 'Bonfire Setup', 'Private beach bonfire with seating and marshmallows.', 1200.00);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_logs`
--

CREATE TABLE `tbl_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` text NOT NULL,
  `datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_logs`
--

INSERT INTO `tbl_logs` (`log_id`, `user_id`, `action`, `datetime`) VALUES
(6, 1, 'Updated accommodation: Backpacker Bunk (ID: 6)', '2026-05-23 20:00:09');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_packages`
--

CREATE TABLE `tbl_packages` (
  `package_id` int(11) NOT NULL,
  `package_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `inclusion_details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_packages`
--

INSERT INTO `tbl_packages` (`package_id`, `package_name`, `description`, `price`, `inclusion_details`) VALUES
(1, 'Weekend Getaway', 'Perfect for a quick escape from the city.', 12000.00, '2 nights Deluxe Ocean Suite, breakfast buffet, pool access, welcome drinks'),
(2, 'Family Fun Bundle', 'Everything your family needs for a memorable stay.', 25000.00, '3 nights Family Garden Villa, daily breakfast, kids activities, island hopping tour, bicycle rental'),
(3, 'Romantic Retreat', 'An intimate experience for couples.', 20000.00, '2 nights Honeymoon Cottage, couples spa, private dinner on the beach, bonfire setup'),
(4, 'Adventure Package', 'For thrill-seekers and outdoor enthusiasts.', 15000.00, '2 nights Premium Cabana, kayak rental, island hopping, bicycle rental, bonfire');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_reservations`
--

CREATE TABLE `tbl_reservations` (
  `reservation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `accommodation_id` int(11) NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `reservation_status` enum('pending','approved','rejected','cancelled') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `role` enum('admin','employee','customer') NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `full_name`, `role`, `username`, `password`, `email`) VALUES
(1, 'System Administrator', 'admin', 'admin1', 'admin', 'admin@resort.com'),
(2, 'Maria Santos', 'employee', 'employee1', 'employee', 'maria@resort.com'),
(3, 'Juan Dela Cruz', 'customer', 'customer1', 'customer', 'juan@email.com'),
(4, 'Ana Reyes', 'customer', 'customer2', 'customer', 'ana@email.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_accommodations`
--
ALTER TABLE `tbl_accommodations`
  ADD PRIMARY KEY (`accommodation_id`);

--
-- Indexes for table `tbl_amenities`
--
ALTER TABLE `tbl_amenities`
  ADD PRIMARY KEY (`amenity_id`);

--
-- Indexes for table `tbl_logs`
--
ALTER TABLE `tbl_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_packages`
--
ALTER TABLE `tbl_packages`
  ADD PRIMARY KEY (`package_id`);

--
-- Indexes for table `tbl_reservations`
--
ALTER TABLE `tbl_reservations`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `accommodation_id` (`accommodation_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_accommodations`
--
ALTER TABLE `tbl_accommodations`
  MODIFY `accommodation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_amenities`
--
ALTER TABLE `tbl_amenities`
  MODIFY `amenity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_logs`
--
ALTER TABLE `tbl_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_packages`
--
ALTER TABLE `tbl_packages`
  MODIFY `package_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_reservations`
--
ALTER TABLE `tbl_reservations`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_logs`
--
ALTER TABLE `tbl_logs`
  ADD CONSTRAINT `tbl_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_reservations`
--
ALTER TABLE `tbl_reservations`
  ADD CONSTRAINT `tbl_reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tbl_reservations_ibfk_2` FOREIGN KEY (`accommodation_id`) REFERENCES `tbl_accommodations` (`accommodation_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
