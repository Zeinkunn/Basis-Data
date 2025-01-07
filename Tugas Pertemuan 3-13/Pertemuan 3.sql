----------------------------------------
-- Zainul Mutawakkil_IF3A_(23EO10003) --
----------------------------------------

-- Membuat tabel products
CREATE TABLE products (
    id VARCHAR(10) NOT NULL,
    nama VARCHAR(100) NOT NULL,
    keterangan TEXT,
    harga INT NOT NULL,
    jumlah INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    category VARCHAR(50)  -- Menambahkan kolom category
);

--menghspus table products
DROP TABLE products

-- Menampilkan semua data dari tabel products
SELECT * FROM products;

-- Menambahkan data ke tabel products
INSERT INTO products (id, nama, keterangan, harga, jumlah)
VALUES ('P0001', 'Ayam Geprek original', 'Ayam Geprek + sambal ijo', 25000, 100);

INSERT INTO products (id, nama, harga, jumlah)
VALUES 
    ('P0002', 'Ayam Bakar Bumbu seafood', 35000, 100),
    ('P0003', 'Ayam Goreng Upin-Ipin', 30000, 100),
    ('P0004', 'Ayam Bakar Bumbu seadanya', 35000, 100);

-- Mengupdate nama produk dengan id P0001
UPDATE products
SET nama = 'Ayam pop'
WHERE id = 'P0001';

-- Mengupdate kategori untuk produk yang ada
UPDATE products
SET category = 'Makanan'
WHERE id IN ('P0001', 'P0002', 'P0003', 'P0004');

-- Mengubah harga produk dengan id P0004
UPDATE products
SET harga = harga + 10000
WHERE id = 'P0004';

-- Menampilkan semua data dari tabel products
SELECT * FROM products;

-- Menambahkan data untuk contoh dihapus
INSERT INTO products (id, nama, harga, jumlah, category)
VALUES ('P0010', 'Produk Gagal', 50000, 100, 'Minuman');

-- Menampilkan semua data dari tabel products
SELECT * FROM products;

-- Menghapus produk dengan id P0010
DELETE FROM products
WHERE id = 'P0010';

-- Menampilkan semua data dari tabel products setelah penghapusan
SELECT * FROM products;