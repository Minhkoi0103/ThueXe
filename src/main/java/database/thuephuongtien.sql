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
