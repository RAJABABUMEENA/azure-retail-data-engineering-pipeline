-- Retail source schema used by the project
CREATE TABLE dbo.customers (
    customer_id INT PRIMARY KEY,
    customer_name NVARCHAR(200) NULL,
    email NVARCHAR(255) NULL,
    city NVARCHAR(100) NULL,
    state NVARCHAR(100) NULL,
    country NVARCHAR(100) NULL,
    registration_date DATE NULL
);

CREATE TABLE dbo.products (
    product_id INT PRIMARY KEY,
    product_name NVARCHAR(200) NULL,
    category NVARCHAR(100) NULL,
    unit_price DECIMAL(18,2) NULL
);

CREATE TABLE dbo.stores (
    store_id INT PRIMARY KEY,
    store_name NVARCHAR(200) NULL,
    city NVARCHAR(100) NULL,
    state NVARCHAR(100) NULL,
    country NVARCHAR(100) NULL
);

CREATE TABLE dbo.transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    store_id INT NOT NULL,
    transaction_date DATETIME2 NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(18,2) NOT NULL,
    discount DECIMAL(18,2) NULL,
    payment_method NVARCHAR(50) NULL,
    last_modified_date DATETIME2 NOT NULL
);
