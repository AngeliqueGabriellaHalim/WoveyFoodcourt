DROP TABLE IF EXISTS Nota;
DROP TABLE IF EXISTS ProdukUMK;
DROP TABLE IF EXISTS Pendaftaran;
DROP TABLE IF EXISTS Transaksi;
DROP TABLE IF EXISTS UMK;
DROP TABLE IF EXISTS Produk;
DROP TABLE IF EXISTS Administrator;
DROP TABLE IF EXISTS JenisTransaksi;

CREATE TABLE JenisTransaksi (
    IdJenis INT PRIMARY KEY,
    Jenis VARCHAR(255)
);

CREATE TABLE Administrator (
    NoHp VARCHAR(255) PRIMARY KEY,
	Pass VARCHAR(255)
);

CREATE TABLE Produk (
    IdProduk INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Nama VARCHAR(255),
    Deskripsi VARCHAR(255),
    Foto VARCHAR(255),
    Satuan VARCHAR(255),
    Harga NUMERIC
);

CREATE TABLE UMK (
    NoHp VARCHAR(255) PRIMARY KEY,
	Pass VARCHAR(255) not NULL,
    NamaUMK VARCHAR(255),
    Deskripsi VARCHAR(255),
    Logo VARCHAR(255),
    Alamat VARCHAR(255),
	IDPendaftaran int GENERATED ALWAYS AS IDENTITY,
	Status VARCHAR(255),
	Tanggal DATE,
	Saldo Numeric,
    NamaPemilik VARCHAR(255),
	Email VARCHAR(255)
);

create table Transaksi(
	IdTransaksi int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Nominal money,
	IdJenis int REFERENCES JenisTransaksi,
	Tanggal date,
	NoHpUMK varchar(255) REFERENCES UMK
);

create table Pendaftaran(
	IdPendaftaran int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Tanggal date,
	Status varchar(255),
	NoHpAdmin varchar(255) REFERENCES Administrator
);

create table ProdukUMK(
	NoHpUMK varchar(255) REFERENCES UMK,
	IdProduk int GENERATED ALWAYS AS IDENTITY REFERENCES Produk
);

create table Nota(
	IdTransaksi int REFERENCES Transaksi,
	IdProduk int REFERENCES Produk,
	Kuantitas int
);

--TABEL JENIS TRANSAKSI
insert into JenisTransaksi
values (1, 'Setor modal');
insert into JenisTransaksi
values (2, 'Penjualan produk');
insert into JenisTransaksi
values (3, 'Pengeluaran operasional');
insert into JenisTransaksi
values (4, 'Penarikan modal');

--TABEL ADMINISTRATOR
insert into Administrator(NoHp, Pass)
values ('081', '081');
insert into Administrator(NoHp, Pass)
values ('082', '082');
insert into Administrator(NoHp, Pass)
values ('083', '083');


--TABEL UMK
insert into UMK (NoHp, Pass, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, Status, Tanggal, Saldo, Email)
values ('081234', '081234', 'Kedai Bermutu', 'Menjual bahan pokok yang berkualitas dan termurah', 'logoKedaiBermutu', 'Jln. Hang Lekir XI No. 10', 'Budi Irwanto', 'Valid', '20240102', 0, 'kedaibermutu@gmail.com');

insert into UMK (NoHp, Pass, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, Status, Tanggal, Saldo, Email)
values ('082222', '082222',  'Roti Yes', 'Menjual berbagai macam roti', 'logoRotiYes', 'Jln. Trunojoyo No. 8', 'Yestianti', 'Valid', '20240110', 0, 'rotiyes@gmail.com');

insert into UMK (NoHp, Pass, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, Status, Tanggal, Saldo, Email)
values ('082121', '082121', 'Badut Gas', 'Menjual gas berkualitas', 'logoGas', 'Jln.Taman Kopo Indah 2 No. 2', 'Asep Suryadi', 'Valid', '20240203', 0, 'badutgas@gmail.com');

insert into UMK (NoHp, Pass, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, Status, Tanggal, Saldo, Email)
values ('083131', '083131', 'Albert Sushi', 'Menjual berbagai makanan jepang', 'logoSushi', 'Jln.GegerKalong Timur No.2', 'Albert Tan', 'Valid', '20240202', 0, 'albertsushi@gmail.com');

insert into UMK (NoHp, Pass, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, Status, Tanggal, Saldo, Email)
values ('089922', '089922', 'Batagor maknyus', 'Menjual batagor kekinian', 'LogoBatagor', 'Jln.Soekarno-Hatta No.77', 'Susilo Adini', 'Valid', '20240203', 0, 'batagormaknyus@gmail.com');

insert into UMK (NoHp, Pass, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, Status, Tanggal, Saldo, Email)
values ('082134', '082134', 'Nasgor Jawir', 'menjual berbagai macam nasi goreng', 'Logo Nasgor', 'Jln. Sagitarius No.90', 'Farel Budianto', 'Valid', '20240306', 0, 'nasgorjawir@gmail.com');

--TABEL PENDAFTARAN
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240102', '081');
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240110', '081');
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240203', '082');
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240202', '082');
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240203', '082');
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240306', '082');

--TABEL PRODUK
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Beras', 'Beras putih pandan wangi', 'foto1', 'kg', 14000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Minyak', 'Minyak goreng', 'foto2', 'liter', 20000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Mie Telur', 'Mie telur ayam', 'foto3', 'bungkus', 15000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Telur', 'Telur ayam negri', 'foto4', 'kg', 29000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Tepung terigu', 'Tepung terigu serbaguna', 'foto5', 'kg', 12000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Gula', 'Gula pasir putih 500 gram', 'foto6', 'bungkus', 10000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Mie instan', 'Mie instan', 'foto7', 'buah', 2000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Roti coklat', 'Roti dengan isi coklat pasta', 'foto8', 'buah', 10000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Roti keju', 'Roti dengan taburan keju diatas', 'foto9', 'buah', 12000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Roti kismis', 'Roti dengan isian kismis', 'foto10', 'buah', 12000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Roti srikaya', 'Roti dengan isian selaian srikaya', 'foto11', 'buah', 14000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Salmon Maki', 'sushi dengan isian salmon mentah', 'foto12', 'plater', 35000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Salmon Sashimi', 'fresh salmon mentah', 'foto13', 'pcs', 10000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Tuna roll', 'gulungan nori dengan isian ikan tuna dan timun', 'foto14', 'plater', 25000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Siomay', 'pangsit yang diisi dengan ikan tenggiri', 'foto15', 'pcs', 2000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Tahu', 'pangsit yang diisi dengan ikan tenggiri dengan ada tambahan tahu', 'foto16', 'pcs', 2000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Nasi goreng ayam', 'nasi yang di goreng dengan telur dan bumbu spesial dan tambahan ayam', 'foto17', 'bungkus', 15000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Nasi goreng spesial', 'nasi yang di goreng dengan telur dan bumbu spesial dan tambahan ayam, seafood, ati ampela', 'foto18', 'bungkus', 30000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Kwetiaw Goreng', 'Kweatiau di goreng dengan telor dan bumbu spesial dengan tambahan ayam', 'foto19', 'bungkus', 15000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Kwetiaw Rebus', 'Kweatiau di rebus dengan telor dan bumbu spesial dengan tambahan ayam', 'foto20', 'bungkus', 15000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Tabung Gas Bright 5,5 kg', 'Tabung gas berwarna pink dengan muatan 5,5 kg', 'foto21', 'tabung', 65000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Tabung Gas 12 kg', 'Tabung gas berwarna biru dengan muatan 12 kg', 'foto22', 'tabung', 170000);
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Tabung Gas 3 kg', 'Tabung gas berwarna hijau dengan muatan 3 kg untuk subsidi', 'foto23', 'tabung', 23000);

--TABEL PRODUK UMK
insert into ProdukUMK (NoHpUMK) values ('081234');
insert into ProdukUMK (NoHpUMK) values ('081234');
insert into ProdukUMK (NoHpUMK) values ('081234');
insert into ProdukUMK (NoHpUMK) values ('081234');
insert into ProdukUMK (NoHpUMK) values ('081234');
insert into ProdukUMK (NoHpUMK) values ('081234');
insert into ProdukUMK (NoHpUMK) values ('081234');
insert into ProdukUMK (NoHpUMK) values ('082222');
insert into ProdukUMK (NoHpUMK) values ('082222');
insert into ProdukUMK (NoHpUMK) values ('082222');
insert into ProdukUMK (NoHpUMK) values ('082222');
insert into ProdukUMK (NoHpUMK) values ('083131');
insert into ProdukUMK (NoHpUMK) values ('083131');
insert into ProdukUMK (NoHpUMK) values ('083131');
insert into ProdukUMK (NoHpUMK) values ('089922');
insert into ProdukUMK (NoHpUMK) values ('089922');
insert into ProdukUMK (NoHpUMK) values ('082134');
insert into ProdukUMK (NoHpUMK) values ('082134');
insert into ProdukUMK (NoHpUMK) values ('082134');
insert into ProdukUMK (NoHpUMK) values ('082134');
insert into ProdukUMK (NoHpUMK) values ('082121');
insert into ProdukUMK (NoHpUMK) values ('082121');
insert into ProdukUMK (NoHpUMK) values ('082121');

--TABEL TRANSAKSI
insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (300000, '20240102', '081234', 1);
UPDATE UMK
SET Saldo = 300000
WHERE NoHp = '081234';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (1000000, '20240110', '082222', 1);
UPDATE UMK
SET Saldo = 1000000
WHERE NoHp = '082222';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (2000000, '20240203', '082121', 1);
UPDATE UMK
SET Saldo = 2000000
WHERE NoHp = '082121';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (3500000, '20240202', '083131', 1);
UPDATE UMK
SET Saldo = 3500000
WHERE NoHp = '083131';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (7000000, '20240203', '089922', 1);
UPDATE UMK
SET Saldo = 7000000
WHERE NoHp = '089922';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (2000000, '20240306', '082134', 1);
UPDATE UMK
SET Saldo = 2000000
WHERE NoHp = '082134';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (110000, '2024-01-03', '081234', 2);
UPDATE UMK
SET Saldo = Saldo + 110000
WHERE NoHp = '081234';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (88000, '2024-01-11', '081234', 2);
UPDATE UMK
SET Saldo = Saldo + 88000
WHERE NoHp = '081234';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (500000, '2024-01-12', '082222', 3);
UPDATE UMK
SET Saldo = Saldo - 500000
WHERE NoHp = '082222';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (100000, '2024-01-13', '081234', 3);
UPDATE UMK
SET Saldo = Saldo - 100000
WHERE NoHp = '081234';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (40000, '2024-02-14', '082222', 2);
UPDATE UMK
SET Saldo = Saldo + 40000
WHERE NoHp = '082222';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (24000, '2024-02-23', '083131', 2);
UPDATE UMK
SET Saldo = Saldo + 24000
WHERE NoHp = '083131';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (365000, '2024-03-10', '082134', 2);
UPDATE UMK
SET Saldo = Saldo + 365000
WHERE NoHp = '082134';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (130000, '2024-03-16', '083131', 2);
UPDATE UMK
SET Saldo = Saldo + 130000
WHERE NoHp = '083131';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (76000, '2024-03-17', '089922', 2);
UPDATE UMK
SET Saldo = Saldo + 76000
WHERE NoHp = '089922';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (94000, '2024-03-18', '082134', 2);
UPDATE UMK
SET Saldo = Saldo + 94000
WHERE NoHp = '082134';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (30000, '2024-03-30', '081234', 2);
UPDATE UMK
SET Saldo = Saldo + 30000
WHERE NoHp = '081234';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (120000, '2024-03-30', '081234', 2);
UPDATE UMK
SET Saldo = Saldo + 120000
WHERE NoHp = '081234';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (500000, '2024-03-26', '083131', 3);
UPDATE UMK
SET Saldo = Saldo - 500000
WHERE NoHp = '083131';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (130000, '2024-02-15', '089922', 3);
UPDATE UMK
SET Saldo = Saldo - 130000
WHERE NoHp = '089922';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (100000, '2024-03-08', '082134', 4);
UPDATE UMK
SET Saldo = Saldo - 100000
WHERE NoHp = '082134';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (65000, '2024-03-09', '082121', 2);
UPDATE UMK
SET Saldo = Saldo + 65000
WHERE NoHp = '082121';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (23000, '2024-02-26', '082121', 2);
UPDATE UMK
SET Saldo = Saldo + 23000
WHERE NoHp = '082121';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (44000, '2024-02-28', '082222', 2);
UPDATE UMK
SET Saldo = Saldo + 44000
WHERE NoHp = '082222';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (49000, '2024-02-21', '081234', 2);
UPDATE UMK
SET Saldo = Saldo + 49000
WHERE NoHp = '081234';

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (170000, '2024-03-16', '082134', 2);
UPDATE UMK
SET Saldo = Saldo + 170000
WHERE NoHp = '082134';

--TABEL NOTA
INSERT INTO Nota (IdTransaksi, IdProduk, Kuantitas) VALUES
(7, 1, 5),
(7, 2, 2),
(7, 4, 2),
(8, 3, 2),
(8, 7, 5),
(11, 8, 3),
(11, 9, 2),
(12, 12, 10),
(13, 19, 1),
(13, 20, 2),
(14, 13, 5),
(14, 14, 2),
(14, 12, 2),
(15, 15, 3),
(15, 16, 2),
(16, 18, 3),
(16, 20, 2),
(17, 6, 2),
(18, 7, 10),
(18, 8, 2),
(22, 21, 1),
(23, 23, 1),
(24, 8, 2),
(24, 9, 2),
(25, 4, 1),
(25, 6, 2),
(26, 22, 1);
