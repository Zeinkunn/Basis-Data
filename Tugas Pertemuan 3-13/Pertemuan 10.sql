----------------------------------------
-- Zainul Mutawakkil_IF3A_(23EO10003) --
----------------------------------------

-- 1. Membuat tabel categories jika belum ada
CREATE TABLE IF NOT EXISTS categories (
    id VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100)
);

-- 2. Membuat tabel products jika belum ada
CREATE TABLE IF NOT EXISTS products (
    id VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100),
    harga INT,
    jumlah INT,
    id_category VARCHAR(10),
    FOREIGN KEY (id_category) REFERENCES categories(id)
);

-- 3. Membuat tabel customer jika belum ada
CREATE TABLE IF NOT EXISTS customer (
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) NOT NULL
);

-- 4. Input ke tabel categories
INSERT INTO categories (id, nama)
VALUES 
    ('C0003', 'Snack Basah'),
    ('C0004', 'Snack Kering');

-- 5. Melihat tabel categories
SELECT * FROM categories;

-- 6. Input ke tabel products
INSERT INTO products (id, nama, harga, jumlah, id_category)
VALUES 
    ('X001', 'Coba 1', 1000, 100, 'C0003'),
    ('X002', 'Test 2', 2000, 100, 'C0004');

-- 7. Melihat tabel products
SELECT * FROM products;

-- 8. INNER JOIN
SELECT 
    c.id AS category_id, c.nama AS category_name,
    p.id AS product_id, p.nama AS product_name, p.harga, p.jumlah
FROM categories c
INNER JOIN products p ON p.id_category = c.id;

-- 9. LEFT JOIN
SELECT 
    c.id AS category_id, c.nama AS category_name,
    p.id AS product_id, p.nama AS product_name, p.harga, p.jumlah
FROM categories c
LEFT JOIN products p ON p.id_category = c.id;

-- 10. RIGHT JOIN
SELECT 
    c.id AS category_id, c.nama AS category_name,
    p.id AS product_id, p.nama AS product_name, p.harga, p.jumlah
FROM categories c
RIGHT JOIN products p ON p.id_category = c.id;

-- 11. FULL JOIN
SELECT 
    c.id AS category_id, c.nama AS category_name,
    p.id AS product_id, p.nama AS product_name, p.harga, p.jumlah
FROM categories c
FULL JOIN products p ON p.id_category = c.id;

-- 12. Subquery di WHERE
SELECT AVG(harga) AS average_price FROM products;

-- 13. Subquery di WHERE
SELECT * 
FROM products
WHERE harga > (SELECT AVG(harga) FROM products);

-- 14. Subquery di FROM
SELECT 
    p.harga AS harga
FROM categories c
JOIN products p ON p.id_category = c.id;

-- 15. Subquery MAX
SELECT MAX(harga) AS max_price 
FROM (
    SELECT p.harga AS harga
    FROM categories c
    JOIN products p ON p.id_category = c.id
) AS contoh;

-- 16. Membuat tabel buku_tamu
CREATE TABLE IF NOT EXISTS bukutamu (
    id SERIAL NOT NULL,
    email VARCHAR(100) NOT NULL,
    title VARCHAR(100) NOT NULL,
    content TEXT,
    PRIMARY KEY (id)
);

-- 17. Input data ke tabel buku_tamu
INSERT INTO bukutamu (email, title, content)
VALUES 
    ('banyu.q@gmail.com', 'Banyu biru', 'Ini adalah banyu'),
    ('rab.q@gmail.com', 'rabs biru', 'Ini adalah rab'),
    ('rabs.q@gmail.com', 'rab saja', 'Ini saingan saya'),
    ('arief@gmail.com', 'rabu', 'Ini adalah rabu'),
    ('prabowo@gmail.com', 'kamis biru', 'Ini adalah kamis');

-- 18. Melihat tabel bukutamu
SELECT * FROM bukutamu;

-- 19. SET UNION