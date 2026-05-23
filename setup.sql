-- Resort Reservation System Database Setup
-- Run this file in phpMyAdmin or MySQL CLI to create the database and tables

CREATE DATABASE IF NOT EXISTS resort_db;
USE resort_db;

-- Users table
CREATE TABLE IF NOT EXISTS tbl_users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('admin','employee','customer') NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Logs table
CREATE TABLE IF NOT EXISTS tbl_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    action TEXT NOT NULL,
    datetime DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES tbl_users(user_id) ON DELETE CASCADE
);

-- Accommodations table
CREATE TABLE IF NOT EXISTS tbl_accommodations (
    accommodation_id INT PRIMARY KEY AUTO_INCREMENT,
    accommodation_name VARCHAR(100) NOT NULL,
    description TEXT,
    capacity INT NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    availability_status ENUM('available','unavailable') NOT NULL DEFAULT 'available',
    image_url VARCHAR(255) DEFAULT NULL
);

-- Amenities table
CREATE TABLE IF NOT EXISTS tbl_amenities (
    amenity_id INT PRIMARY KEY AUTO_INCREMENT,
    amenity_name VARCHAR(100) NOT NULL,
    description TEXT,
    price_per_use DECIMAL(10,2) NOT NULL
);

-- Reservations table
CREATE TABLE IF NOT EXISTS tbl_reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    accommodation_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    reservation_status ENUM('pending','approved','rejected','cancelled') NOT NULL DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES tbl_users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (accommodation_id) REFERENCES tbl_accommodations(accommodation_id) ON DELETE CASCADE
);

-- Packages table
CREATE TABLE IF NOT EXISTS tbl_packages (
    package_id INT PRIMARY KEY AUTO_INCREMENT,
    package_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    inclusion_details TEXT
);

-- =====================
-- SEED DATA
-- =====================

-- Default users (plain text passwords)
INSERT INTO tbl_users (full_name, role, username, password, email) VALUES
('System Administrator', 'admin', 'admin1', 'admin', 'admin@resort.com'),
('Maria Santos', 'employee', 'employee1', 'employee', 'maria@resort.com'),
('Juan Dela Cruz', 'customer', 'customer1', 'customer', 'juan@email.com'),
('Ana Reyes', 'customer', 'customer2', 'customer', 'ana@email.com');

-- Sample accommodations
INSERT INTO tbl_accommodations (accommodation_name, description, capacity, price_per_night, availability_status, image_url) VALUES
('Deluxe Ocean Suite', 'Spacious suite with panoramic ocean views, king-size bed, and private balcony.', 2, 5500.00, 'available', 'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=800&q=80'),
('Family Garden Villa', 'Two-bedroom villa surrounded by tropical gardens with a shared pool.', 5, 8200.00, 'available', 'https://images.unsplash.com/photo-1582268611958-ebfd161ef9cf?auto=format&fit=crop&w=800&q=80'),
('Standard Twin Room', 'Comfortable room with two single beds, ideal for friends or colleagues.', 2, 2800.00, 'available', 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=800&q=80'),
('Premium Cabana', 'Private beachfront cabana with direct sand access and outdoor shower.', 3, 6500.00, 'available', 'https://images.unsplash.com/photo-1439066615861-d1af74d74000?auto=format&fit=crop&w=800&q=80'),
('Honeymoon Cottage', 'Intimate cottage with a canopy bed, private jacuzzi, and sunset views.', 2, 7500.00, 'unavailable', 'https://images.unsplash.com/photo-1544644181-1484b3fdfc62?auto=format&fit=crop&w=800&q=80'),
('Backpacker Bunk', 'Budget-friendly shared room with individual lockers and common area.', 4, 1200.00, 'available', 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80');

-- Sample amenities
INSERT INTO tbl_amenities (amenity_name, description, price_per_use) VALUES
('Swimming Pool', 'Olympic-size infinity pool overlooking the ocean.', 0.00),
('Spa & Massage', 'Full-body traditional massage with aromatherapy oils.', 1500.00),
('Kayak Rental', 'Single or tandem kayak for coastal exploration.', 800.00),
('Island Hopping Tour', 'Half-day guided tour to three nearby islands.', 2500.00),
('Bicycle Rental', 'Mountain bike for resort and village trails.', 300.00),
('Bonfire Setup', 'Private beach bonfire with seating and marshmallows.', 1200.00);

-- Sample packages
INSERT INTO tbl_packages (package_name, description, price, inclusion_details) VALUES
('Weekend Getaway', 'Perfect for a quick escape from the city.', 12000.00, '2 nights Deluxe Ocean Suite, breakfast buffet, pool access, welcome drinks'),
('Family Fun Bundle', 'Everything your family needs for a memorable stay.', 25000.00, '3 nights Family Garden Villa, daily breakfast, kids activities, island hopping tour, bicycle rental'),
('Romantic Retreat', 'An intimate experience for couples.', 20000.00, '2 nights Honeymoon Cottage, couples spa, private dinner on the beach, bonfire setup'),
('Adventure Package', 'For thrill-seekers and outdoor enthusiasts.', 15000.00, '2 nights Premium Cabana, kayak rental, island hopping, bicycle rental, bonfire');

-- Sample reservations
INSERT INTO tbl_reservations (user_id, accommodation_id, check_in_date, check_out_date, total_price, reservation_status) VALUES
(3, 1, '2026-06-01', '2026-06-03', 11000.00, 'approved'),
(3, 3, '2026-07-10', '2026-07-12', 5600.00, 'pending'),
(4, 2, '2026-06-15', '2026-06-18', 24600.00, 'pending'),
(4, 4, '2026-08-01', '2026-08-04', 19500.00, 'rejected');

-- Sample logs
INSERT INTO tbl_logs (user_id, action, datetime) VALUES
(1, 'Added accommodation: Deluxe Ocean Suite', '2026-05-20 09:00:00'),
(1, 'Added accommodation: Family Garden Villa', '2026-05-20 09:05:00'),
(1, 'Added user: Maria Santos (employee)', '2026-05-20 09:15:00'),
(2, 'Approved reservation ID 1', '2026-05-21 10:30:00'),
(2, 'Rejected reservation ID 4', '2026-05-22 14:00:00');
