CREATE TABLE Users (
                       user_id INT PRIMARY KEY AUTO_INCREMENT,
                       user_name VARCHAR(100),
                       user_email VARCHAR(100) UNIQUE,
                       phone_number VARCHAR(20),
                       identity_number VARCHAR(20) UNIQUE,
                       address TEXT,
                       user_password VARCHAR(255),
                       user_role ENUM('admin', 'customer') DEFAULT 'customer',
                       status ENUM('active', 'blocked') DEFAULT 'active'
);

CREATE TABLE Vehicles (
                          vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
                          vehicle_name VARCHAR(100),
                          vehicle_type VARCHAR(50),
                          license_plate VARCHAR(20) UNIQUE,
                          image_url TEXT,
                          rental_price DECIMAL(10, 2),
                          availability_status ENUM('available', 'rented', 'maintenance') DEFAULT 'available'
);

CREATE TABLE RentalOrders (
                              order_id INT PRIMARY KEY AUTO_INCREMENT,
                              user_id INT,
                              vehicle_id INT,
                              start_time DATETIME,
                              end_time DATETIME,
                              status ENUM('pending', 'approved', 'canceled', 'completed') DEFAULT 'pending',
                              approved_by_id INT,
                              FOREIGN KEY (user_id) REFERENCES Users(user_id),
                              FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
                              FOREIGN KEY (approved_by_id) REFERENCES Users(user_id)
);

CREATE TABLE Payments (
                          payment_id INT PRIMARY KEY AUTO_INCREMENT,
                          order_id INT,
                          payment_method ENUM('momo', 'zalopay', 'atm', 'visa'),
                          amount DECIMAL(10, 2),
                          payment_date DATETIME,
                          status ENUM('success', 'failed') DEFAULT 'success',
                          FOREIGN KEY (order_id) REFERENCES RentalOrders(order_id)
);

CREATE TABLE Reviews (
                         review_id INT PRIMARY KEY AUTO_INCREMENT,
                         user_id INT,
                         vehicle_id INT,
                         content TEXT,
                         rating INT CHECK (rating BETWEEN 1 AND 5),
                         review_time DATETIME,
                         FOREIGN KEY (user_id) REFERENCES Users(user_id),
                         FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

-- Insert sample data
INSERT INTO Users (user_name, user_email, phone_number, identity_number, address, user_password, user_role) VALUES
('Nguyễn Văn An', 'an.nguyen@email.com', '0123456789', '123456789012', '123 Đường ABC, Quận 1, TP.HCM', 'hashed_password_1', 'customer'),
('Trần Thị Bình', 'binh.tran@email.com', '0987654321', '987654321098', '456 Đường XYZ, Quận 2, TP.HCM', 'hashed_password_2', 'customer'),
('Lê Văn Cường', 'cuong.le@email.com', '0369852147', '147258369147', '789 Đường DEF, Quận 3, TP.HCM', 'hashed_password_3', 'admin'),
('Phạm Thị Dung', 'dung.pham@email.com', '0521478963', '963852741963', '321 Đường GHI, Quận 4, TP.HCM', 'hashed_password_4', 'customer'),
('Hoàng Văn Em', 'em.hoang@email.com', '0741852963', '741852963741', '654 Đường JKL, Quận 5, TP.HCM', 'hashed_password_5', 'customer');

INSERT INTO Vehicles (vehicle_name, vehicle_type, license_plate, image_url, rental_price, availability_status) VALUES
('Toyota Vios', 'sedan', '51A-12345', '/images/vios.jpg', 500000, 'available'),
('Honda Lead', 'scooter', '51B-67890', '/images/lead.jpg', 200000, 'available'),
('Yamaha Exciter', 'motorcycle', '51C-11111', '/images/exciter.jpg', 300000, 'available'),
('Ford Ranger', 'pickup', '51D-22222', '/images/ranger.jpg', 800000, 'available'),
('Honda Wave', 'motorcycle', '51E-33333', '/images/wave.jpg', 150000, 'available'),
('Toyota Innova', 'suv', '51F-44444', '/images/innova.jpg', 600000, 'available'),
('Suzuki Swift', 'hatchback', '51G-55555', '/images/swift.jpg', 400000, 'available'),
('Honda City', 'sedan', '51H-66666', '/images/city.jpg', 450000, 'available');

INSERT INTO RentalOrders (user_id, vehicle_id, start_time, end_time, status, approved_by_id) VALUES
(1, 1, '2024-01-15 08:00:00', '2024-01-15 18:00:00', 'completed', 3),
(1, 2, '2024-01-20 09:00:00', '2024-01-20 17:00:00', 'completed', 3),
(1, 3, '2024-01-25 10:00:00', '2024-01-25 16:00:00', 'completed', 3),
(1, 4, '2024-02-01 07:00:00', '2024-02-01 19:00:00', 'completed', 3),
(1, 5, '2024-02-05 08:30:00', '2024-02-05 15:30:00', 'completed', 3),
(2, 1, '2024-01-18 09:00:00', '2024-01-18 17:00:00', 'completed', 3),
(2, 6, '2024-01-22 10:00:00', '2024-01-22 18:00:00', 'completed', 3),
(4, 2, '2024-01-28 08:00:00', '2024-01-28 16:00:00', 'completed', 3),
(5, 3, '2024-02-02 09:30:00', '2024-02-02 17:30:00', 'completed', 3);

INSERT INTO Payments (order_id, payment_method, amount, payment_date, status) VALUES
(1, 'momo', 500000, '2024-01-15 07:55:00', 'success'),
(2, 'zalopay', 200000, '2024-01-20 08:55:00', 'success'),
(3, 'atm', 300000, '2024-01-25 09:55:00', 'success'),
(4, 'visa', 800000, '2024-02-01 06:55:00', 'success'),
(5, 'momo', 150000, '2024-02-05 08:25:00', 'success'),
(6, 'zalopay', 500000, '2024-01-18 08:55:00', 'success'),
(7, 'atm', 600000, '2024-01-22 09:55:00', 'success'),
(8, 'momo', 200000, '2024-01-28 07:55:00', 'success'),
(9, 'visa', 300000, '2024-02-02 09:25:00', 'success');

INSERT INTO Reviews (user_id, vehicle_id, content, rating, review_time) VALUES
(1, 1, 'Xe rất tốt, chạy êm và tiết kiệm nhiên liệu', 5, '2024-01-15 19:00:00'),
(1, 2, 'Xe gọn gàng, phù hợp cho việc di chuyển trong thành phố', 4, '2024-01-20 18:00:00'),
(1, 3, 'Xe mạnh mẽ, phù hợp cho những chuyến đi xa', 5, '2024-01-25 17:00:00'),
(1, 4, 'Xe rộng rãi, thoải mái cho gia đình', 4, '2024-02-01 20:00:00'),
(1, 5, 'Xe tiết kiệm nhiên liệu, giá cả hợp lý', 4, '2024-02-05 16:00:00'),
(2, 1, 'Dịch vụ thuê xe rất chuyên nghiệp', 5, '2024-01-18 18:00:00'),
(2, 6, 'Xe sạch sẽ, được bảo dưỡng tốt', 4, '2024-01-22 19:00:00'),
(4, 2, 'Nhân viên phục vụ rất nhiệt tình', 5, '2024-01-28 17:00:00'),
(5, 3, 'Xe đẹp và chất lượng tốt', 4, '2024-02-02 18:00:00');
