-------------------------------------
--+ Pembuatan Tabel & Relationsip +--
--+ Zainul M. (23EO10003)         +--
-------------------------------------

-- Tabel Barang
CREATE TABLE Barang (
    id_brng VARCHAR(10) PRIMARY KEY,
    nama_brng VARCHAR(255) NOT NULL,
    harga_satuan_brng VARCHAR(20) NOT NULL
);

-- Tabel Transaksi Barang
CREATE TABLE Transaksi_Barang (
    id_transaksi VARCHAR(10),
    id_brng VARCHAR(10),
    qty_brng INT,
    PRIMARY KEY (id_transaksi, id_brng),  -- Corrected the reference to kode_brng
    FOREIGN KEY (id_brng) REFERENCES Barang(id_brng)  -- Corrected the foreign key reference
);

-- Insert Data ke Tabel Barang
INSERT INTO Barang (id_brng, nama_brng, harga_satuan_brng) VALUES
    ('BRNG_01', 'Magii Magic Lezat Bumbu Penyedap Serbaguna 6 x 7 g', 'Rp2.500,00'),
    ('BRNG_02', 'MILO Choco Bar 15 g', 'Rp4.500,00'),
    ('BRNG_03', 'Magii Saus Tiram Pet 150 g', 'Rp9.200,00'),
    ('BRNG_04', 'Nestle Dancow UHT FortiGro Cokelat 4 x 110 ml', 'Rp10.500,00'),
    ('BRNG_05', 'Nestle Honey Stars Pouch 70 g', 'Rp12.600,00'),
    ('BRNG_06', 'MILO Nugget Chocolate 25 g', 'Rp13.900,00'),
    ('BRNG_07', 'Nestle Dancow UHT FortiGro Susu Bubuk Instan Cokelat 400 g', 'Rp39.500,00'),
    ('BRNG_08', 'KOKO KRUNCH Sereal 330 g', 'Rp42.800,00'),
    ('BRNG_09', 'Nestle Dancow 3+ Nutriods Susu Pertumbuhan 3-5 tahun Madu 400 g', 'Rp48.200,00');

-- Insert Data ke Tabel Transaksi Barang
INSERT INTO Transaksi_Barang (id_transaksi, id_brng, qty_brng) VALUES
    ('TRX_001', 'BRNG_01', 1),
    ('TRX_002', 'BRNG_02', 1),
    ('TRX_003', 'BRNG_03', 2),
    ('TRX_004', 'BRNG_04', 2),
    ('TRX_005', 'BRNG_05', 1),
    ('TRX_006', 'BRNG_06', 1),
    ('TRX_007', 'BRNG_07', 1),
    ('TRX_008', 'BRNG_08', 1),
    ('TRX_009', 'BRNG_09', 3);

-- View Tabel
SELECT * FROM Barang;
SELECT * FROM Transaksi_Barang;

------------------------------------------------------------------------------------
--+ Query dimana tabel yang menggunakan ACID Compliance / database transactional +--
------------------------------------------------------------------------------------

-- Memulai transaksi
BEGIN;

-- Mengecek apakah barang tersedia
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM Barang 
        WHERE id_brng = 'BRNG_10'
    ) THEN
        RAISE EXCEPTION 'Barang tidak ditemukan!';
    END IF;
END $$;

-- Menambah Barang
DO $$ 
BEGIN
    INSERT INTO Barang (id_brng, nama_brng, harga_satuan_brng)
    VALUES ('BRNG_10', 'New Product', 'Rp5.000,00');
END $$;

-- Cek Barang Baru
SELECT * FROM Barang WHERE id_brng = 'BRNG_10';

-- Menambahkan data transaksi
INSERT INTO Transaksi_Barang (id_transaksi, kode_brng, qty_brng)
VALUES ('TRX_010', 'BRNG_01', 2);

-- Cek Transaksi yang baru diinput
SELECT * FROM Transaksi_Barang WHERE id_transaksi = 'TRX_010';

-- Jika semua berjalan lancar, lakukan commit
COMMIT;

-- Jika ada kesalahan, rollback
ROLLBACK;

-- Menampilkan Semua Data
SELECT 
    tb.id_transaksi,
    tb.id_brng,
    b.nama_brng,
    tb.qty_brng,
    b.harga_satuan_brng,
    (tb.qty_brng * CAST(REPLACE(REPLACE(b.harga_satuan_brng, 'Rp', ''), ',', '') AS NUMERIC)) AS total_harga
FROM 
    Transaksi_Barang tb
JOIN 
    Barang b
ON 
    tb.id_brng = b.id_brng;

--------------------------------------------------------------------------------------
--+Menambahkan user management untuk super user, admin dan user biasa, dimana super+--
--+user dapat melakukan perintah DML di semua tabel, admin hanya dapat insert dan  +--
--+update di table tertentu, sedangkan user hanya bisa dibatasi hanya bisa melihat +--
--+di semua table.                                                                 +--
--------------------------------------------------------------------------------------

-- Membuat role untuk super user
CREATE ROLE super_user WITH LOGIN PASSWORD 'super_password';
GRANT ALL PRIVILEGES ON DATABASE nama_database TO super_user;


-- Membuat role untuk admin
CREATE ROLE admin WITH LOGIN PASSWORD 'admin_password';

-- Memberikan hak INSERT dan UPDATE hanya pada tabel tertentu
GRANT INSERT, UPDATE ON TABLE Barang TO admin;
GRANT INSERT, UPDATE ON TABLE Transaksi_Barang TO admin;

-- Mencegah hak DROP atau perubahan skema
REVOKE ALL ON DATABASE nama_database FROM admin;


-- Membuat role untuk user biasa
CREATE ROLE regular_user WITH LOGIN PASSWORD 'user_password';

-- Memberikan akses READ-ONLY (SELECT) di semua tabel
GRANT SELECT ON ALL TABLES IN SCHEMA public TO regular_user;

-- Pastikan user tidak dapat melakukan operasi DML atau DDL
REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public FROM regular_user;


-- Membatasi Hak Akses ke Future Tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO super_user; --Super User (Semua Akses)

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT, UPDATE ON TABLES TO admin; --Admin (Hanya INSERT dan UPDATE)

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO regular_user; --User Biasa (Hanya SELECT)

-- Penerapan Hak Akses pada Level DDL dan DML

--Contoh Hak Super User
    --Menambahkan tabel baru
CREATE TABLE contoh_tabel (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100)
);

-- Memasukkan data
INSERT INTO contoh_tabel (nama) VALUES ('Test Data');

--Contoh Hak Admin
    --Insert data (diperbolehkan)
INSERT INTO Barang (kode_brng, nama_brng, harga_satuan_brng) VALUES ('BRNG_10', 'Barang Baru', 5000);

    -- Update data (diperbolehkan)
UPDATE Barang SET nama_brng = 'Barang Diupdate' WHERE kode_brng = 'BRNG_10';

    -- Delete data (tidak diperbolehkan)
DELETE FROM Barang WHERE kode_brng = 'BRNG_10'; -- Error!
--Contoh Hak User Biasa
    -- Select data (diperbolehkan)
SELECT * FROM Barang;

    -- Insert data (tidak diperbolehkan)
INSERT INTO Barang (kode_brng, nama_brng, harga_satuan_brng) VALUES ('BRNG_10', 'Barang Baru', 5000); -- Error!

    -- Update data (tidak diperbolehkan)
UPDATE Barang SET nama_brng = 'Barang Diupdate' WHERE kode_brng = 'BRNG_01'; -- Error!


--Pengelolaan Role untuk Pengguna Baru
    --Menambahkan pengguna baru sebagai super user
CREATE USER new_super_user WITH PASSWORD 'new_super_password';
GRANT super_user TO new_super_user;

    -- Menambahkan pengguna baru sebagai admin
CREATE USER new_admin WITH PASSWORD 'new_admin_password';
GRANT admin TO new_admin;

    -- Menambahkan pengguna baru sebagai user biasa
CREATE USER new_regular_user WITH PASSWORD 'new_user_password';
GRANT regular_user TO new_regular_user;