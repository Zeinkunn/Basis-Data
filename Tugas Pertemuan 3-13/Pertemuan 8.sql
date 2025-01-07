----------------------------------------
-- Zainul Mutawakkil_IF3A_(23EO10003) --
----------------------------------------

-- 1. Membuat tabel dengan kolom JSONB
CREATE TABLE produk_laptop (
    id SERIAL PRIMARY KEY,
    nama TEXT NOT NULL,
    details JSONB
);

-- 2. Menambahkan data JSON ke tabel
INSERT INTO produk_laptop (nama, details)
VALUES
(
    'Laptop',
    '{
        "brand": "Asus",
        "model": "Vivo Book",
        "specs": {
            "cpu": "Core i7",
            "ram": "32GB",
            "storage": "1 Tera SSD NVME"
        }
    }'
);

-- Menambahkan data lain dengan JSONB arrays
INSERT INTO produk_laptop (nama, details)
VALUES
(
    'Smartphone',
    '{
        "brand": "Apple",
        "model": "iPhone 12",
        "tags": ["electronics", "mobile", "new"]
    }'
);

-- 3. Melihat semua data
SELECT * FROM produk_laptop;

-- 4. Ekstraksi data JSONB sederhana
SELECT 
    nama, 
    details ->> 'brand' AS brand
FROM 
    produk_laptop;

-- 5. Ekstraksi nilai bersarang
SELECT 
    nama, 
    details -> 'specs' ->> 'cpu' AS cpu
FROM 
    produk_laptop;

-- 6. Ekstraksi nilai menggunakan jalur JSONB
SELECT 
    nama, 
    details #>> '{specs, storage}' AS storage
FROM 
    produk_laptop;

-- 7. Memperbarui nilai di JSONB
UPDATE produk_laptop
SET 
    details = jsonb_set(details, '{specs, storage}', '"512GB"')
WHERE 
    nama = 'Laptop';

-- 8. Menghapus field tingkat atas di JSONB
UPDATE produk_laptop
SET 
    details = details - 'model'
WHERE 
    nama = 'Laptop';

-- 9. Menghapus nested field di JSONB
UPDATE produk_laptop
SET 
    details = details #- '{specs, cpu}'
WHERE 
    nama = 'Laptop';

-- 10. Query berdasarkan array JSONB
SELECT 
    nama, 
    details
FROM 
    produk_laptop
WHERE 
    details @> '{"tags": ["mobile"]}';

-- 11. Query dengan operator JSONB array ?
SELECT 
    nama, 
    details
FROM 
    produk_laptop
WHERE 
    details->'tags' ? 'mobile';

-- 12. Menggabungkan data JSONB
UPDATE produk_laptop
SET 
    details = details || '{"warranty": "2 years"}'
WHERE 
    nama = 'Laptop';

-- 13. Agregasi data berdasarkan nilai JSONB
SELECT 
    details->> 'brand' AS brand,
    COUNT(*) AS count
FROM 
    produk_laptop
GROUP BY 
    details->>'brand';

-- 14. Membuat indeks GIN untuk mempercepat query pada JSONB arrays
CREATE INDEX idx_produk_details_tags ON produk_laptop USING GIN ((details->'tags'));

-- Query menggunakan indeks GIN
SELECT 
    nama, 
    details
FROM 
    produk_laptop
WHERE 
    details->'tags' ? 'electronics';

-- 15. Membuat indeks B-tree untuk mempercepat query pada atribut JSONB
CREATE INDEX idx_produk_details_model ON produk_laptop ((details->>'model'));

-- Query menggunakan indeks B-tree
SELECT 
    nama, 
    details
FROM 
    produk_laptop
WHERE 
    details->>'model' = 'iPhone 12';