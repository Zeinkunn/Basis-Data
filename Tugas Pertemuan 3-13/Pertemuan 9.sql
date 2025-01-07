----------------------------------------
-- Zainul Mutawakkil_IF3A_(23EO10003) --
----------------------------------------

--join
--menampilkan tabel wishlist
select * from wishlist;

select *
from wishlist
join produdcts on wishlist.id_produk = product.id;

--menampilkan secara custom
select product.id, products.nama, wishlist.keterangan
from wishlist join products on wishlist.id_products = products.id;

--menggunakan alias
select p.id, p.nama, w.keterangan
from wishlist as w join products as p on w.id_produk = p.id;

--mealakukan join ke multiple table
--sebelum nya kita akan menambahkakn kolom di wishlist
alter table wishlist
add column id_consumer int;

--cek table wishlist
select * from costumer;

--menambahkan realsi table wishlist ke id_costumer terhadap table costumer
alter table wishlist
add constraint fk_wishlist_costumer
foreign key (id_costumer)
references costumer(id);

--update table wishlist
update wishlist
set id_costumer = 1
where id in (2,3);

update wishlist
set id_consumer = 4
where id = 4;

select * from wishlist

--selanjutnya melakukan join multiple table
select  c.email, p.id, w.keterangan
from wishlist as w
join products as p on w.id_produk = p.id
join costumer as c on c.id_costumer;

--relasi antar table
--one to one realtionship
--membuat table dompet dengan mengguankan UNIQUE
create table dompet
(
id serial not null,
id_customer int not null,
balance int not null,
primary key (id),
constraint dompet_costumer_unique unique (id_costumer),
constraint fk_wallet_costumer foreign key (id_customer)
references customer(id)
);

--cek table customer
select * from customer;

--input data ke table customer
insert into dompet(id_customer, balance)
values(1, 1000000),
(4, 5000000),
(5, 10000000);

--menampilkan table dompet
select * from dompet;

--lakukan join dengan relasi one to one 
select * from customer join dompet on dompet.id_customer = customer.id;

--one to many relationship
--membuat table categories
create table categories
(
id varchar9(10) not null,
nama varchar(100) not null,
primary key(id)
);

--input data ke categories
insert into categories(id, nama)
values('C0001', 'makanan'),
('C0002', 'minuman');

select * from categories;

--menambahkan comun id_category di table products
alter table products
add column id_category varchar(10);

--menambahkan relasi
alter table products
add constraint fk_product_category
foreign key (id_category)
references categories(id);

select * from product;

--update table products
update products
set id_category = 'C0001'
where category = 'makanan';

update products
set id_category = 'C0002'
where category = 'minuman';

--menghapus co