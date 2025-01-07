----------------------------------------
-- Zainul Mutawakkil_IF3A_(23EO10003) --
----------------------------------------

--like operator
select * from products where nama ilike '%Bakar%';

select * from products where nama ilike '%Es%';

select * from products where nama like '%seafood%';

--between operator
select * from products where harga between 10000 and 30000;


select * from products where harga not between 10000 and 30000;

--IN operator
select * from products where category in ('Makanan');

select * from products where category in ('Makanan', 'Minuman');

--Order By clause
select * from products order by harga asc;

select * from products order by harga asc, id desc;

select * from products order by harga dsc;

--limit clouse / membatasi data yang ditampilkan
select * from products where harga > 0 order by harga asc, id desc limit 2;

--skip data yg ditampilkan dengan offset (biasanya untuk pagging)
--contoh 1 limit 2 offset 0, 2 limit 2 offset 2, 3 limit 2 offset 4

select * from products order by harga asc, id desc limit 2 offset 2;

--select distinct data / menghilangkan duplikat
select category from products;

select distinct category from products;

--numeric function
select 10 + 10 as hasil;

select id, harga / 1000 as harga_in_k from products;

--mathematik function
select pi();

select power(10, 2);

select cos(10), sin(10), tan(10);

select id, nama, power(jumlah, 2) as jumlah_power_2 from products;

--auto increment
--membuat table admin
create table admin(
	id serial not null,
	nama_depan varchar(100) not null,
	nama_belakang varchar(100) not null,
	primary key(id)
);

--input data
insert into admin(nama_depan,nama_belakang)
values ('Arif','Rahmat'),
('Prabowo','Jonatan');
select * from admin;

--melihat id terakhir
select currval('admin_id_seq');

--sequence
--Membuat sequence
create sequance contoh_berurut;

--melihat id terakhir
select nexval('contoh_berurut');

--melihat saat ini diurutan berapa
select currval('contoh_berurut');

--String function
select id, nama, keterangan from products;

select id, lower(nama), length(nama), lower(keterangan) from products;

