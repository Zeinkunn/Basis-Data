----------------------------------------
-- Zainul Mutawakkil_IF3A_(23EO10003) --
----------------------------------------

CREATE TABLE peserta (
    id VARCHAR(36),
    nama VARCHAR(255) NOT NULL,
    email VARCHAR(50) NOT NULL,
    nomor_handphone VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (email)
);

CREATE TABLE pengajar (
    id VARCHAR(36),
    nama VARCHAR(255) NOT NULL,
    email VARCHAR(50) NOT NULL,
    nomor_handphone VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (email)
);

CREATE TABLE kurikulum (
    id VARCHAR(36),
    kode VARCHAR(100),
    nama VARCHAR(200),
    aktif BOOLEAN,
    PRIMARY KEY (id),
    UNIQUE (kode)
);

CREATE TABLE kelas (
    id VARCHAR(36),
    id_pengajar VARCHAR(36) NOT NULL,
    nama VARCHAR(100) NOT NULL,
    hari VARCHAR(10) NOT NULL,
    waktu_mulai TIME NOT NULL,
    waktu_selesai TIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (nama),
    FOREIGN KEY (id_pengajar) REFERENCES pengajar(id)
);

CREATE TABLE peserta_kelas (
    id_peserta VARCHAR(36),
    id_kelas VARCHAR(36),
    PRIMARY KEY (id_peserta, id_kelas),
    FOREIGN KEY (id_peserta) REFERENCES peserta(id),
    FOREIGN KEY (id_kelas) REFERENCES kelas(id)
);

CREATE TABLE sesi_belajar (
    id VARCHAR(36),
    id_kelas VARCHAR(36) NOT NULL,
    waktu_mulai TIMESTAMP NOT NULL,
    waktu_selesai TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (id_kelas) REFERENCES kelas(id)
);

CREATE TABLE presensi_peserta (
    id VARCHAR(36),
    id_sesi_belajar VARCHAR(36) NOT NULL,
    id_peserta VARCHAR(36) NOT NULL,
    waktu_datang TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_sesi_belajar) REFERENCES sesi_belajar(id),
    FOREIGN KEY (id_peserta) REFERENCES peserta(id)
);

CREATE TABLE presensi_pengajar (
    id VARCHAR(36),
    id_sesi_belajar VARCHAR(36) NOT NULL,
    id_pengajar VARCHAR(36) NOT NULL,
    waktu_datang TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_sesi_belajar) REFERENCES sesi_belajar(id),
    FOREIGN KEY (id_pengajar) REFERENCES pengajar(id)
);

CREATE TABLE jurnal_mutaabah (
    id VARCHAR(36),
    id_peserta VARCHAR(36) NOT NULL,
    waktu_kegiatan TIMESTAMP NOT NULL,
    keterangan VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_peserta) REFERENCES peserta(id)
);

CREATE TABLE ujian (
    id VARCHAR(36),
    id_kurikulum VARCHAR(36) NOT NULL,
    nama_ujian VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_kurikulum) REFERENCES kurikulum(id)
);

CREATE TABLE soal_ujian (
    id VARCHAR(36),
    id_ujian VARCHAR(36) NOT NULL,
    urutan INTEGER NOT NULL,
    pertanyaan TEXT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_ujian) REFERENCES ujian(id)
);

CREATE TABLE sesi_ujian (
    id VARCHAR(36),
    id_ujian VARCHAR(36),
    waktu_mulai TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (id_ujian) REFERENCES ujian(id)
);

CREATE TABLE sesi_ujian_peserta (
    id_peserta VARCHAR(36),
    id_sesi_ujian VARCHAR(36),
    waktu_datang TIMESTAMP NOT NULL,
    PRIMARY KEY (id_peserta, id_sesi_ujian),
    FOREIGN KEY (id_peserta) REFERENCES peserta(id),
    FOREIGN KEY (id_sesi_ujian) REFERENCES sesi_ujian(id)
);
create table sesi_ujian_pengajar (
	id_pengajar varchar(36),
	id_sesi_ujian varchar(36),
	waktu_datang timestamp not null,
	primary key (id_pengajar, id_sesi_ujian),
	foreign key (id_pengajar) references pengajar(id),
	foreign key (id_sesi_ujian) references sesi_ujian(id)
);

create table nilai (
	id varchar(36),
	id_sesi_ujian varchar(36),
	id_peserta varchar(36),
	nilai numeric(3,2) not null,
	keterangan varchar(255),
	primary key (id),
	foreign key (id_peserta) references peserta(id),
	foreign key (id_sesi_ujian) references sesi_ujian(id)
);

create table tagihan (
	id varchar(36),
	id_peserta varchar(36),
	tanggal_terbit date not null,
	tanggal_jatuh_tempo date not null,
	nilai numeric(19,2) not null,
	primary key (id),
	foreign key (id_peserta) references peserta(id)
);

create table pembayaran_tagihan (
	id varchar(36),
	id_tagihan varchar(36) not null,
	id_peserta varchar(36) not null,
	waktu_pembayaran timestamp not null,
	nilai_pembayaran numeric(19,2) not null,
	kanal_pembayaran varchar(20) not null,
	referensi varchar(50) not null,
	primary key (id),
	foreign key (id_tagihan) references tagihan(id),
	foreign key (id_peserta) references peserta(id)
);

CREATE TABLE program_sedekah (
    id VARCHAR(36),
    nama VARCHAR(36) NOT NULL,
    tanggal_mulai DATE NOT NULL,
    tanggal_selesai DATE NOT NULL,
    aktif BOOLEAN,
    PRIMARY KEY (id)
);

create table pembayaran_sedekah (
	id varchar(36),
	id_program_sedekah varchar(36) not null,
	id_peserta varchar(36) not null,
	waktu_pembayaran timestamp not null,
	nilai_pembayaran numeric(19,2) not null,
	kanal_pembayaran varchar(20) not null,
	referensi varchar(50) not null,
	primary key (id),
	foreign key (id_program_sedekah) references program_sedekah(id),
	foreign key (id_peserta) references peserta(id)
);