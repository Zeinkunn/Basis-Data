----------------------------------------
-- Zainul Mutawakkil_IF3A_(23EO10003) --
----------------------------------------

-- Menambah kolom timestamp
SELECT * FROM products;

SELECT id, EXTRACT(YEAR FROM created_at), EXTRACT(MONTH FROM created_at) FROM products;

-- Flow control function
SELECT id, category FROM products;

-- Flow control case
SELECT id,
CASE category
WHEN 'Makanan' THEN 'enak'
WHEN 'Minuman' THEN 'Sueger'
ELSE 'Apa an tuh!!!'
END AS category
FROM products;

SELECT id, category,
CASE category
WHEN 'Makanan' THEN 'enak'
WHEN 'Minuman' THEN 'Sueger'
ELSE 'Apa an tuh!!!'
END AS category_case
FROM products;

-- Flow control dengan operator
SELECT id,
harga,
CASE
WHEN harga <= 15000 THEN 'Murah'
WHEN harga <= 20000 THEN 'Mahal'
ELSE 'Mahal cuy..'
END AS "Apakah murah?"
FROM products;

-- Flow control chek null
SELECT id,
nama,
CASE
WHEN keterangan IS NULL THEN 'Kosong'
ELSE keterangan
END AS keterangan
FROM products;

-- Agragate function
-- Menghitung kolom id
SELECT COUNT(id) FROM products;

-- Menghitung rata-rata
SELECT AVG(harga) FROM products;

-- Mencari yang paling mahal
SELECT MAX(harga) FROM products;

-- Mencari yang paling murah
SELECT MIN(harga) FROM products;

-- Group by dengan aggregate fungsi
SELECT category, COUNT(id) FROM products GROUP BY category;

SELECT category, COUNT(id) AS "Total Product" FROM products GROUP BY category;

SELECT category,
AVG(harga) AS "Rata-rata harga",
MIN(harga) AS "Harga termurah",
MAX(harga) AS "Harga termahal"
FROM products
GROUP BY category;

-- Having clause
SELECT category,
COUNT(id) AS "Total Product" FROM products
GROUP BY category;

SELECT category,
COUNT(id) AS "Total Product"
FROM products
GROUP BY category
HAVING COUNT(id) > 1;

-- Constraint
-- Unique constrant
-- Membuat tabel customer
CREATE TABLE customer(
id SERIAL NOT NULL,
email VARCHAR(100) NOT NULL,
nama_depan VARCHAR(100) NOT NULL,
nama_akhir VARCHAR(100) NOT NULL,
PRIMARY KEY (id),
CONSTRAINT unique_email UNIQUE (email)
);

INSERT INTO customer (email, nama_depan, nama_akhir)
VALUES('banyu.q@gmail.com', 'Arief', 'Budiarto');

SELECT * FROM customer;

INSERT INTO customer (email, nama_depan, nama_akhir)
VALUES('banyu.q2@gmail.com', 'Banyu', 'Budiarto');

-- Manambah/menghapus unique contraint
ALTER TABLE customer
DROP CONSTRAINT unique_email;

-- Menambah contraint
ALTER TABLE customer
ADD CONSTRAINT unique_email UNIQUE (email);