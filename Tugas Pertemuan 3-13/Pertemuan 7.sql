----------------------------------------
-- Zainul Mutawakkil_IF3A_(23EO10003) --
----------------------------------------

-- Cek constraint
-- Menambah/menghapus constraint
ALTER TABLE products
ADD CONSTRAINT price_check CHECK (harga > 1000);

SELECT * FROM products;

ALTER TABLE products
ADD CONSTRAINT jumlah_check CHECK (jumlah >= 0);

--membuat table product
-- Membuat tabel products
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100),
    harga NUMERIC,
    jumlah INT,
    category VARCHAR(50),
    CONSTRAINT price_check CHECK (harga > 1000)  -- Constraint untuk harga
);

-- Memasukkan data ke dalam tabel products dengan harga yang valid
INSERT INTO products (nama, harga, jumlah, category)
VALUES ('Gagal bro', 1500, 0, 'Minuman');  -- Harga lebih dari 1000

SELECT * FROM products;

--Untuk menghapus constraint
ALTER TABLE products
DROP CONSTRAINT price_check;

-- Membuat table penjual
CREATE TABLE penjual (
    id SERIAL NOT NULL,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT email_unique UNIQUE (email)
);

-- Insert data ke table penjual
INSERT INTO penjual (nama, email)
VALUES 
    ('Megawati', 'megawati@yahoo.com'),
    ('Jokowi', 'jokowi@google.com'),
    ('Prabowo', 'prabowo@gmail.com'),
    ('Banyubiru', 'banyu@gmail.com');

SELECT * FROM penjual;

-- Menampilkan data dengan index
SELECT * FROM penjual WHERE id = 1;
SELECT * FROM penjual WHERE email = 'banyu@gmail.com';

-- Menampilkan tanpa index
SELECT * FROM penjual WHERE id = 1 OR nama = 'Banyubiru';
SELECT * FROM penjual WHERE email = 'banyu@gmail.com' OR nama = 'Megawati';

-- Membuat index
CREATE INDEX penjual_id_dan_nama_index ON penjual (id, nama);
CREATE INDEX penjual_email_dan_nama_index ON penjual (email, nama);

-- Full text search menggantikan like
-- Mencari tanpa index
SELECT * FROM products
WHERE to_tsvector(nama) @@ to_tsquery('es');

-- Mencari dengan index
-- Cek bahasa yang digunakan yang didukung
SELECT cfgname FROM pg_ts_config;

CREATE INDEX products_nama_search ON products USING gin (to_tsvector('indonesian', nama));

-- Menampilkan dengan
SELECT * FROM products WHERE to_tsvector(nama) @@ to_tsquery('ayam');

-- Dengan operator
SELECT * FROM products WHERE to_tsvector(nama) @@ to_tsquery('les');

-- Membuat table wishlist
CREATE TABLE wishlist (
    id SERIAL NOT NULL,
    id_produk VARCHAR(10) NOT NULL,
    keterangan TEXT,
    PRIMARY KEY (id),
    CONSTRAINT fk_wishlist_produk FOREIGN KEY (id_produk) REFERENCES products(id)
);

-- Jika insert salah
INSERT INTO wishlist (id_produk, keterangan)
VALUES ('coba', 'Ayam bakar-bakarang');

-- Insert benar
INSERT INTO wishlist (id_produk, keterangan)
VALUES
    ('P0001', 'Ayam Bakar Kalasan'),
    ('P0002', 'Ayam Bakar Banyumas'),
    ('P0003', 'Ayam Bakar Pesawat Terbang');

SELECT * FROM wishlist;

-- Tidak bisa di delete karena digunakan di tabel products/tabel lain
DELETE FROM products WHERE id = 'P0003';

-- Tidak bisa di delete karena digunakan di tabel products/tabel lain
UPDATE wishlist
SET id_produk = 'coba'
WHERE id = 2;

-- Merubah behavior foreign key
-- Hapus dulu constraint di wishlist
ALTER TABLE wishlist
DROP CONSTRAINT fk_wishlist_produk;

-- Buat lagi constraint dengan behaviornya
ALTER TABLE wishlist
ADD CONSTRAINT fk_wishlist_produk FOREIGN KEY (id_produk) REFERENCES products(id)
ON DELETE CASCADE ON UPDATE CASCADE;

-- Sekarang bisa dihapus tabel yang berelasi
INSERT INTO products (id, nama, harga, jumlah, category)
VALUES ('abab', 'xXx', 10000, 100, 'Minuman');

SELECT * FROM wishlist;

INSERT INTO wishlist (id_produk, keterangan)