Создание базы данных

CREATE DATABASE Shop;
USE Shop;

Создание табличных пространств

CREATE TABLESPACE Products;
CREATE TABLESPACE Categories;
CREATE TABLESPACE Prices;
CREATE TABLESPACE Suppliers;
CREATE TABLESPACE Manufacturers;
CREATE TABLESPACE Customers;
CREATE TABLESPACE Purchases;

Создание ролей

CREATE ROLE Admin;
CREATE ROLE User1;

Создание схемы данных

CREATE SCHEMA Products;
CREATE SCHEMA Categories;
CREATE SCHEMA Prices;
CREATE SCHEMA Suppliers;
CREATE SCHEMA Manufacturers;
CREATE SCHEMA Customers;
CREATE SCHEMA Purchases;

Создание таблиц и распределение их по схемам и табличным пространствам

Таблица Categories

CREATE TABLE Categories.Categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
) TABLESPACE Categories;

Таблица Prices

CREATE TABLE Prices.Prices (
    price_id INT PRIMARY KEY,
    product_id INT,
    price DECIMAL(10, 2) CHECK (price > 0),
    currency VARCHAR(3),
    date DATE,
    FOREIGN KEY (product_id) REFERENCES Products.Products(product_id)
) TABLESPACE Prices;

Таблица Suppliers

CREATE TABLE Suppliers.Suppliers (
    supplier_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info TEXT
) TABLESPACE Suppliers;

Таблица Manufacturers

CREATE TABLE Manufacturers.Manufacturers (
    manufacturer_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info TEXT
) TABLESPACE Manufacturers;

Таблица Customers

CREATE TABLE Customers.Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info TEXT
) TABLESPACE Customers;

Таблица Products
CREATE TABLE Products.Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category_id INT,
    supplier_id INT,
    manufacturer_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories.Categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers.Suppliers(supplier_id),
    FOREIGN KEY (manufacturer_id) REFERENCES Manufacturers.Manufacturers(manufacturer_id)
) TABLESPACE Products;

Таблица Purchases

CREATE TABLE Purchases.Purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT CHECK (quantity > 0),
    purchase_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers.Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products.Products(product_id)
) TABLESPACE Purchases;

Создание индексов

CREATE INDEX idx_products_category_id ON Products.Products(category_id);
CREATE INDEX idx_products_supplier_id ON Products.Products(supplier_id);
CREATE INDEX idx_products_manufacturer_id ON Products.Products(manufacturer_id);
CREATE INDEX idx_purchases_customer_id ON Purchases.Purchases(customer_id);
CREATE INDEX idx_purchases_product_id ON Purchases.Purchases(product_id);
CREATE INDEX idx_purchases_purchase_date ON Purchases.Purchases(purchase_date);
CREATE INDEX idx_prices_product_id ON Prices.Prices(product_id);

Создание ограничений

ALTER TABLE Products.Products ADD CONSTRAINT unique_product_id UNIQUE (product_id);
ALTER TABLE Categories.Categories ADD CONSTRAINT unique_category_id UNIQUE (category_id);
ALTER TABLE Prices.Prices ADD CONSTRAINT unique_price_id UNIQUE (price_id);
ALTER TABLE Suppliers.Suppliers ADD CONSTRAINT unique_supplier_id UNIQUE (supplier_id);
ALTER TABLE Manufacturers.Manufacturers ADD CONSTRAINT unique_manufacturer_id UNIQUE (manufacturer_id);
ALTER TABLE Customers.Customers ADD CONSTRAINT unique_customer_id UNIQUE (customer_id);
ALTER TABLE Purchases.Purchases ADD CONSTRAINT unique_purchase_id UNIQUE (purchase_id);
ALTER TABLE Purchases.Purchases ADD CONSTRAINT chk_quantity CHECK (quantity > 0);
ALTER TABLE Prices.Prices ADD CONSTRAINT chk_price CHECK (price > 0);

Назначение ролей

GRANT ALL PRIVILEGES ON DATABASE Internet TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Products.Products TO User;
GRANT SELECT, INSERT, UPDATE, DELETE ON Categories.Categories TO User;
GRANT SELECT, INSERT, UPDATE, DELETE ON Prices.Prices TO User;
GRANT SELECT, INSERT, UPDATE, DELETE ON Suppliers.Suppliers TO User;
GRANT SELECT, INSERT, UPDATE, DELETE ON Manufacturers.Manufacturers TO User;
GRANT SELECT, INSERT, UPDATE, DELETE ON Customers.Customers TO User;
GRANT SELECT, INSERT, UPDATE, DELETE ON Purchases.Purchases TO User;
