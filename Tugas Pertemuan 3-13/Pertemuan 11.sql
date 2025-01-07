----------------------------------------
-- Zainul Mutawakkil_IF3A_(23EO10003) --
----------------------------------------

-- Transaction
-- Sebelumnya jalankan perintah
START TRANSACTION;

CREATE TABLE bukutamu (
    id SERIAL PRIMARY KEY,  -- Menambahkan kolom id sebagai primary key
    email VARCHAR(255) NOT NULL,  -- Kolom untuk menyimpan email
    title VARCHAR(255) NOT NULL,  -- Kolom untuk menyimpan judul
    content TEXT NOT NULL,  -- Kolom untuk menyimpan konten
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Kolom untuk menyimpan waktu pembuatan
);

--drop buku tamu
DROP TABLE bukutamu;

-- Insert ke dalam table bukutamu
INSERT INTO bukutamu (email, title, content)
VALUES
    ('transaction@gmail.com', 'Transaction', 'Ini Transaksi'),
    ('transaction@gmail.com', 'Transaction', 'Ini Transaksi 2'),
    ('transaction@gmail.com', 'Transaction', 'Ini Transaksi 3'),
    ('transaction@gmail.com', 'Transaction', 'Ini Transaksi 4'),
    ('transaction@gmail.com', 'Transaction', 'Ini Transaksi 5');

-- Gunakan lain client untuk melihatnya
SELECT * FROM bukutamu;

-- Commit untuk melihat hasilnya di beda client
COMMIT;

-- Menggunakan rollback
START TRANSACTION;

-- Insert ke dalam table bukutamu
INSERT INTO bukutamu (email, title, content)
VALUES
    ('transaction@gmail.com', 'Transaction', 'Ini rollback'),
    ('transaction@gmail.com', 'Transaction', 'Ini rollback 2'),
    ('transaction@gmail.com', 'Transaction', 'Ini rollback 3'),
    ('transaction@gmail.com', 'Transaction', 'Ini rollback 4'),
    ('transaction@gmail.com', 'Transaction', 'Ini rollback 5');

SELECT * FROM bukutamu;

-- Cek di lain client
SELECT * FROM bukutamu;

-- Gunakan rollback untuk membatalkan
ROLLBACK;

-- LOCKING
-- Menggunakan di table products
SELECT * FROM products;

-- Sebelumnya start transaction terlebih dahulu
START TRANSACTION;

CREATE TABLE products (
    id SERIAL PRIMARY KEY,               -- Kolom ID sebagai primary key
    name VARCHAR(255) NOT NULL,          -- Kolom untuk menyimpan nama produk
    description TEXT,                     -- Kolom untuk menyimpan deskripsi produk
    price DECIMAL(10, 2) NOT NULL,       -- Kolom untuk menyimpan harga produk
    quantity INT NOT NULL,                -- Kolom untuk menyimpan jumlah stok produk
    category VARCHAR(100),                -- Kolom untuk menyimpan kategori produk
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Kolom untuk menyimpan waktu pembuatan
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Kolom untuk menyimpan waktu update
);

--insert table
INSERT INTO products (name, description, price, quantity, category)
VALUES
    ('Laptop ASUS ROG', 'Laptop gaming dengan performa tinggi', 15000.00, 10, 'Elektronik'),
    ('Smartphone Samsung Galaxy', 'Smartphone dengan kamera terbaik', 8000.00, 25, 'Elektronik'),
    ('Kursi Ergonomis', 'Kursi nyaman untuk bekerja dari rumah', 1200.00, 15, 'Furniture'),
    ('Meja Kayu', 'Meja kayu solid untuk ruang kerja', 2500.00, 5, 'Furniture'),
    ('Headphone Sony', 'Headphone noise-cancelling', 1500.00, 20, 'Aksesoris');

--drop table products
DROP TABLE products;

-- Update di field id
UPDATE products
SET keterangan = 'Ayam geprek original janda kaya'
WHERE id = 'P0001';

-- Cek table products
SELECT * FROM products WHERE id = 'P0001';

-- Cek di lain client untuk update jumlah p001
UPDATE products SET jumlah = 200 WHERE id = 'P0001';

-- Jalankan commit untuk melepas lock
COMMIT;

-- Locking record manual
START TRANSACTION;
SELECT * FROM products WHERE id = 'P0001' FOR UPDATE;

-- Select di beda client
SELECT * FROM products WHERE id = 'P0001' FOR UPDATE;

-- Membatalkan
ROLLBACK;

-- DEADLOCK
START TRANSACTION;
SELECT * FROM products WHERE id = 'P0001' FOR UPDATE;
SELECT * FROM products WHERE id = 'P0002' FOR UPDATE;
ROLLBACK;

-- SCHEMA
-- Melihat schema
SELECT current_schema();

-- Membuat schema
CREATE SCHEMA contoh;

-- Menghapus schema (pastikan tidak ada tabel di dalamnya)
DROP SCHEMA contoh CASCADE;

-- Pindah schema
SET search_path TO contoh;

-- Melihat schema saat ini
SELECT current_schema();
SELECT * FROM public.products;

CREATE TABLE contoh.products (
    id SERIAL NOT NULL,
    nama VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

SELECT * FROM contoh.products;

-- Pindah schema public
SET search_path TO public;

-- Jika insert di schema contoh pada path public
INSERT INTO contoh.products (nama)
VALUES ('Samsung'), ('Lenovo');

SELECT * FROM contoh.products;

-- USER MANAGEMENT
-- Membuat users
CREATE ROLE arief;
CREATE ROLE banyu;

-- Menghapus
DROP ROLE arief;
DROP ROLE banyu;

-- Membuat user role yang sudah dibuat
ALTER ROLE arief LOGIN PASSWORD 'rahasia';
ALTER ROLE banyu LOGIN PASSWORD 'rahasia';

-- Hak akses
GRANT INSERT, UPDATE, SELECT ON ALL TABLES IN SCHEMA public TO arief;
GRANT INSERT, UPDATE, SELECT ON customer TO banyu;

-- Backup database
-- Cek pg_dump apakah sudah terinstall
pg_dump --help;

-- Contoh perintah pg_dump
pg_dump --host=localhost --port=5432 --dbname=belajar --username=arief;