DROP DATABASE IF EXISTS online_food_ordering;
CREATE DATABASE online_food_ordering;
USE online_food_ordering;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(30),
    address TEXT,
    role ENUM('ADMIN','CUSTOMER') NOT NULL DEFAULT 'CUSTOMER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE menu_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(120) NOT NULL,
    description TEXT,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(255),
    availability BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('Pending','Preparing','Completed','Cancelled') NOT NULL DEFAULT 'Pending',
    delivery_name VARCHAR(100) NOT NULL,
    delivery_phone VARCHAR(30) NOT NULL,
    delivery_address TEXT NOT NULL,
    payment_method VARCHAR(50) NOT NULL DEFAULT 'Cash on Delivery',
    notes TEXT,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT,
    item_name VARCHAR(120) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id) REFERENCES orders(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_order_items_menu
        FOREIGN KEY (item_id) REFERENCES menu_items(id)
        ON DELETE SET NULL
);

INSERT INTO users (name, email, password, phone, address, role) VALUES
('Administrator', 'admin@makanmate.com', 'admin123', '011-0000000', 'MakanMate Admin Office', 'ADMIN'),
('Demo Customer', 'customer@makanmate.com', 'customer123', '012-3456789', 'Kolej Kediaman, UMT', 'CUSTOMER');

INSERT INTO menu_items (item_name, description, category, price, image_url, availability) VALUES
('Nasi Lemak', 'Nasi lemak with sambal, egg and cucumber.', 'Rice', 10.50, '', TRUE),
('Chicken Chop', 'Fried chicken chop served with black pepper sauce.', 'Western', 15.90, '', TRUE),
('Mee Goreng Mamak', 'Spicy fried noodles with egg and vegetables.', 'Noodles', 9.90, '', TRUE),
('Lemon Tea Ais', 'Refreshing iced lemon tea.', 'Drinks', 6.50, '', TRUE),
('Kopi Mamu Ais', 'Iced coffee mamak style.', 'Drinks', 8.00, '', TRUE),
('Nasi Ayam', 'Chicken rice with soup and chilli sauce.', 'Rice', 12.00, '', TRUE);
