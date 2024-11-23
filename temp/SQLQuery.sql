drop table if exists Nota
drop table if exists ProdukUMK
drop table if exists Pendaftaran
drop table if exists Transaksi
drop table if exists UMK
drop table if exists Produk
drop table if exists Administrator
drop table if exists JenisTransaksi
drop table if exists Kota
drop table if exists Provinsi

create table Provinsi(
	IdProvinsi int PRIMARY KEY,
	NamaProvinsi varchar(255)
)

create table Kota(
	IdKota int PRIMARY KEY,
	IdProvinsi int FOREIGN KEY REFERENCES Provinsi,
	NamaKota varchar(255)
)

create table JenisTransaksi(
	IdJenis int PRIMARY KEY,
	Jenis varchar(255)
)

create table Administrator(
	NoHp varchar(255) PRIMARY KEY
)

create table Produk(
	IdProduk int IDENTITY(1,1) PRIMARY KEY,
	Nama varchar(255),
	Deskripsi varchar(255),
	Foto varchar(255),
	Satuan varchar(255),
	Harga money
)

create table UMK(
	NoHp varchar(255) PRIMARY KEY,
	NamaUMK varchar(255),
	Deskripsi varchar(255),
	Logo varchar(255),
	Alamat varchar(255),
	NamaPemilik varchar(255),
	IdKota int FOREIGN KEY REFERENCES Kota,
	IdPendaftaran int IDENTITY(1,1),
	Status varchar(255),
	Tanggal date,
	Saldo money,
)

create table Transaksi(
	IdTransaksi int IDENTITY(1,1) PRIMARY KEY,
	Nominal money,
	IdJenis int FOREIGN KEY REFERENCES JenisTransaksi,
	Tanggal date,
	NoHpUMK varchar(255) FOREIGN KEY REFERENCES UMK
)

create table Pendaftaran(
	IdPendaftaran int IDENTITY(1,1) PRIMARY KEY,
	Tanggal date,
	Status varchar(255),
	NoHpAdmin varchar(255) FOREIGN KEY REFERENCES Administrator
)


create table ProdukUMK(
	NoHpUMK varchar(255) FOREIGN KEY REFERENCES UMK,
	IdProduk int IDENTITY(1,1) FOREIGN KEY REFERENCES Produk
)

create table Nota(
	IdTransaksi int FOREIGN KEY REFERENCES Transaksi,
	IdProduk int FOREIGN KEY REFERENCES Produk,
	Kuantitas int,
)

--TABEL JENIS TRANSAKSI
insert into JenisTransaksi
values (1, 'Setor modal')
insert into JenisTransaksi
values (2, 'Penjualan produk')
insert into JenisTransaksi
values (3, 'Pengeluaran operasional')
insert into JenisTransaksi
values (4, 'Penarikan modal')

--TABEL ADMINISTRATOR
insert into Administrator
values ('081')
insert into Administrator
values ('082')
insert into Administrator
values ('083')

--TABEL PROVINSI
INSERT INTO Provinsi VALUES 
(1, 'Aceh'),
(2, 'Sumatera Utara'),
(3, 'Sumatera Barat'),
(4, 'Riau'),
(5, 'Jambi'),
(6, 'Sumatera Selatan'),
(7, 'Bengkulu'),
(8, 'Lampung'),
(9, 'Kepulauan Bangka Belitung'),
(10, 'Kepulauan Riau'),
(11, 'DKI Jakarta'),
(12, 'Jawa Barat'),
(13, 'Jawa Tengah'),
(14, 'DI Yogyakarta'),
(15, 'Jawa Timur'),
(16, 'Banten'),
(17, 'Bali'),
(18, 'Nusa Tenggara Barat'),
(19, 'Nusa Tenggara Timur'),
(20, 'Kalimantan Barat'),
(21, 'Kalimantan Tengah'),
(22, 'Kalimantan Selatan'),
(23, 'Kalimantan Timur'),
(24, 'Kalimantan Utara'),
(25, 'Sulawesi Utara'),
(26, 'Sulawesi Tengah'),
(27, 'Sulawesi Selatan'),
(28, 'Sulawesi Tenggara'),
(29, 'Gorontalo'),
(30, 'Sulawesi Barat'),
(31, 'Maluku'),
(32, 'Maluku Utara'),
(33, 'Papua'),
(34, 'Papua Barat'),
(35, 'Papua Tengah'),
(36, 'Papua Pegunungan');

--TABEL KOTA
INSERT INTO Kota VALUES 
-- Provinsi Aceh
(1, 1, 'Banda Aceh'),
(2, 1, 'Langsa'),
(3, 1, 'Lhokseumawe'),
(4, 1, 'Sabang'),
(5, 1, 'Subulussalam'),
-- Provinsi Sumatera Utara
(6, 2, 'Medan'),
(7, 2, 'Binjai'),
(8, 2, 'Tebing Tinggi'),
(9, 2, 'Pematang Siantar'),
(10, 2, 'Tanjungbalai'),
(11, 2, 'Sibolga'),
(12, 2, 'Padang Sidempuan'),
(13, 2, 'Gunungsitoli'),
-- Provinsi Sumatera Barat
(14, 3, 'Padang'),
(15, 3, 'Bukittinggi'),
(16, 3, 'Padang Panjang'),
(17, 3, 'Pariaman'),
(18, 3, 'Payakumbuh'),
(19, 3, 'Sawahlunto'),
(20, 3, 'Solok'),
-- Provinsi Riau
(21, 4, 'Pekanbaru'),
(22, 4, 'Dumai'),
-- Provinsi Jambi
(23, 5, 'Jambi'),
(24, 5, 'Sungai Penuh'),
-- Provinsi Sumatera Selatan
(25, 6, 'Palembang'),
(26, 6, 'Pagar Alam'),
(27, 6, 'Lubuklinggau'),
(28, 6, 'Prabumulih'),
-- Provinsi Bengkulu
(29, 7, 'Bengkulu'),
-- Provinsi Lampung
(30, 8, 'Bandar Lampung'),
(31, 8, 'Metro'),
-- Provinsi Kepulauan Bangka Belitung
(32, 9, 'Pangkal Pinang'),
-- Provinsi Kepulauan Riau
(33, 10, 'Tanjung Pinang'),
(34, 10, 'Batam'),
-- Provinsi DKI Jakarta
(35, 11, 'Jakarta Pusat'),
(36, 11, 'Jakarta Utara'),
(37, 11, 'Jakarta Barat'),
(38, 11, 'Jakarta Selatan'),
(39, 11, 'Jakarta Timur'),
-- Provinsi Jawa Barat
(40, 12, 'Bandung'),
(41, 12, 'Bogor'),
(42, 12, 'Cimahi'),
(43, 12, 'Depok'),
(44, 12, 'Sukabumi'),
(45, 12, 'Tasikmalaya'),
(46, 12, 'Banjar'),
-- Provinsi Jawa Tengah
(47, 13, 'Semarang'),
(48, 13, 'Surakarta (Solo)'),
(49, 13, 'Salatiga'),
(50, 13, 'Pekalongan'),
(51, 13, 'Magelang'),
(52, 13, 'Tegal'),
-- Provinsi DI Yogyakarta
(53, 14, 'Yogyakarta'),
-- Provinsi Jawa Timur
(54, 15, 'Surabaya'),
(55, 15, 'Malang'),
(56, 15, 'Kediri'),
(57, 15, 'Madiun'),
(58, 15, 'Mojokerto'),
(59, 15, 'Blitar'),
(60, 15, 'Pasuruan'),
(61, 15, 'Probolinggo'),
(62, 15, 'Batu'),
-- Provinsi Banten
(63, 16, 'Serang'),
(64, 16, 'Cilegon'),
(65, 16, 'Tangerang Selatan'),
(66, 16, 'Tangerang'),
-- Provinsi Bali
(67, 17, 'Denpasar'),
-- Provinsi Nusa Tenggara Barat
(68, 18, 'Mataram'),
(69, 18, 'Bima'),
-- Provinsi Nusa Tenggara Timur
(70, 19, 'Kupang'),
-- Provinsi Kalimantan Barat
(71, 20, 'Pontianak'),
(72, 20, 'Singkawang'),
-- Provinsi Kalimantan Tengah
(73, 21, 'Palangka Raya'),
-- Provinsi Kalimantan Selatan
(74, 22, 'Banjarmasin'),
(75, 22, 'Banjarbaru'),
-- Provinsi Kalimantan Timur
(76, 23, 'Samarinda'),
(77, 23, 'Balikpapan'),
(78, 23, 'Bontang'),
-- Provinsi Kalimantan Utara
(79, 24, 'Tarakan'),
-- Provinsi Sulawesi Utara
(80, 25, 'Manado'),
(81, 25, 'Bitung'),
(82, 25, 'Tomohon'),
(83, 25, 'Kotamobagu'),
-- Provinsi Sulawesi Tengah
(84, 26, 'Palu'),
-- Provinsi Sulawesi Selatan
(85, 27, 'Makassar'),
(86, 27, 'Parepare'),
(87, 27, 'Palopo'),
-- Provinsi Sulawesi Tenggara
(88, 28, 'Kendari'),
(89, 28, 'Baubau'),
-- Provinsi Gorontalo
(90, 29, 'Gorontalo'),
-- Provinsi Sulawesi Barat
(91, 30, 'Mamuju'),
-- Provinsi Maluku
(92, 31, 'Ambon'),
(93, 31, 'Tual'),
-- Provinsi Maluku Utara
(94, 32, 'Ternate'),
(95, 32, 'Tidore Kepulauan'),
-- Provinsi Papua
(96, 33, 'Jayapura'),
-- Provinsi Papua Barat
(97, 34, 'Manokwari'),
(98, 34, 'Sorong'),
-- Provinsi Papua Tengah
(99, 35, 'Nabire'),
-- Provinsi Papua Pegunungan
(100, 36, 'Wamena');

--TABEL UMK
insert into UMK (NoHp, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, IdKota, Status, Tanggal, Saldo)
values ('081234', 'Kedai Bermutu', 'Menjual bahan pokok yang berkualitas dan termurah', 'logoKedaiBermutu', 'Jln. Hang Lekir XI No. 10', 'Budi Irwanto', 2, 'Valid', '20240102', 0);

insert into UMK (NoHp, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, IdKota, Status, Tanggal, Saldo)
values ('082222', 'Roti Yes', 'Menjual berbagai macam roti', 'logoRotiYes', 'Jln. Trunojoyo No. 8', 'Yestianti', 1, 'Valid', '20240110', 0);

insert into UMK (NoHp, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, IdKota, Status, Tanggal, Saldo)
values ('082121', 'Badut Gas', 'Menjual gas berkualitas', 'logoGas', 'Jln.Taman Kopo Indah 2 No. 2', 'Albert Tan', 2, 'Valid', '20240203', 0);

insert into UMK (NoHp, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, IdKota, Status, Tanggal, Saldo)
values ('083131', 'Albert Sushi', 'Menjual berbagai makanan jepang', 'logoSushi', 'Jln.GegerKalong Timur No.2', 'Asep Suryadi', 1, 'Valid', '20240202', 0);

insert into UMK (NoHp, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, IdKota, Status, Tanggal, Saldo)
values ('089922', 'Batagor maknyus', 'Menjual batagor kekinian', 'LogoBatagor', 'Jln.Soekarno-Hatta No.77', 'Susilo Adini', 3, 'Valid', '20240203', 0);

insert into UMK (NoHp, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, IdKota, Status, Tanggal, Saldo)
values ('082134', 'Nasgor Jawir', 'menjual berbagai macam nasi goreng', 'Logo Nasgor', 'Jln. Sagitarius No.90', 'Farel Budianto', 3, 'Valid', '20240306', 0);

--TABEL PENDAFTARAN
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240102', '081')
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240110', '081')
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240203', '082')
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240202', '082')
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240203', '082')
insert into Pendaftaran (Status, Tanggal, NoHpAdmin)
values ('Valid', '20240306', '082')

--TABEL PRODUK
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Beras', 'Beras putih pandan wangi', 'foto1', 'kg', 14000)
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Minyak', 'Minyak goreng', 'foto2', 'liter', 20000)
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Mie Telur', 'Mie telur ayam', 'foto3', 'bungkus', 15000)
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Telur', 'Telur ayam negri', 'foto4', 'kg', 29000)
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Tepung terigu', 'Tepung terigu serbaguna', 'foto5', 'kg', 12000)
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Gula', 'Gula pasir putih 500 gram', 'foto6', 'bungkus', 10000)
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Mie instan', 'Mie instan', 'foto7', 'buah', 2000)
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Roti coklat', 'Roti dengan isi coklat pasta', 'foto8', 'buah', 10000)
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Roti keju', 'Roti dengan taburan keju diatas', 'foto9', 'buah', 12000)
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Roti kismis', 'Roti dengan isian kismis', 'foto10', 'buah', 12000)
insert into Produk (Nama, Deskripsi, Foto, Satuan, Harga)
values ('Roti srikaya', 'Roti dengan isian selaian srikaya', 'foto11', 'buah', 14000)
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
insert into ProdukUMK (NoHpUMK) values ('081234')
insert into ProdukUMK (NoHpUMK) values ('081234')
insert into ProdukUMK (NoHpUMK) values ('081234')
insert into ProdukUMK (NoHpUMK) values ('081234')
insert into ProdukUMK (NoHpUMK) values ('081234')
insert into ProdukUMK (NoHpUMK) values ('081234')
insert into ProdukUMK (NoHpUMK) values ('081234')
insert into ProdukUMK (NoHpUMK) values ('082222')
insert into ProdukUMK (NoHpUMK) values ('082222')
insert into ProdukUMK (NoHpUMK) values ('082222')
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
WHERE NoHp = '081234'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (1000000, '20240110', '082222', 1);
UPDATE UMK
SET Saldo = 1000000
WHERE NoHp = '082222'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (2000000, '20240203', '082121', 1);
UPDATE UMK
SET Saldo = 2000000
WHERE NoHp = '082121'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (3500000, '20240202', '083131', 1);
UPDATE UMK
SET Saldo = 3500000
WHERE NoHp = '083131'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (7000000, '20240203', '089922', 1);
UPDATE UMK
SET Saldo = 7000000
WHERE NoHp = '089922'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (2000000, '20240306', '082134', 1);
UPDATE UMK
SET Saldo = 2000000
WHERE NoHp = '082134'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (110000, '2024-01-03', '081234', 2);
UPDATE UMK
SET Saldo = Saldo + 110000
WHERE NoHp = '081234'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (88000, '2024-01-11', '081234', 2);
UPDATE UMK
SET Saldo = Saldo + 88000
WHERE NoHp = '081234'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (500000, '2024-01-12', '082222', 3);
UPDATE UMK
SET Saldo = Saldo - 500000
WHERE NoHp = '082222'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (100000, '2024-01-13', '081234', 3);
UPDATE UMK
SET Saldo = Saldo - 100000
WHERE NoHp = '081234'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (40000, '2024-02-14', '082222', 2);
UPDATE UMK
SET Saldo = Saldo + 40000
WHERE NoHp = '082222'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (24000, '2024-02-23', '083131', 2);
UPDATE UMK
SET Saldo = Saldo + 24000
WHERE NoHp = '083131'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (365000, '2024-03-10', '082134', 2);
UPDATE UMK
SET Saldo = Saldo + 365000
WHERE NoHp = '082134'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (130000, '2024-03-16', '083131', 2);
UPDATE UMK
SET Saldo = Saldo + 130000
WHERE NoHp = '083131'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (76000, '2024-03-17', '089922', 2);
UPDATE UMK
SET Saldo = Saldo + 76000
WHERE NoHp = '089922'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (94000, '2024-03-18', '082134', 2);
UPDATE UMK
SET Saldo = Saldo + 94000
WHERE NoHp = '082134'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (30000, '2024-03-30', '081234', 2);
UPDATE UMK
SET Saldo = Saldo + 30000
WHERE NoHp = '081234'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (120000, '2024-03-30', '081234', 2);
UPDATE UMK
SET Saldo = Saldo + 120000
WHERE NoHp = '081234'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (500000, '2024-03-26', '083131', 3);
UPDATE UMK
SET Saldo = Saldo - 500000
WHERE NoHp = '083131'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (130000, '2024-02-15', '089922', 3);
UPDATE UMK
SET Saldo = Saldo - 130000
WHERE NoHp = '089922'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (100000, '2024-03-08', '082134', 4);
UPDATE UMK
SET Saldo = Saldo - 100000
WHERE NoHp = '082134'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (65000, '2024-03-09', '082121', 2);
UPDATE UMK
SET Saldo = Saldo + 65000
WHERE NoHp = '082121'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (23000, '2024-02-26', '082121', 2);
UPDATE UMK
SET Saldo = Saldo + 23000
WHERE NoHp = '082121'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (44000, '2024-02-28', '082222', 2);
UPDATE UMK
SET Saldo = Saldo + 44000
WHERE NoHp = '082222'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (49000, '2024-02-21', '081234', 2);
UPDATE UMK
SET Saldo = Saldo + 49000
WHERE NoHp = '081234'

insert into Transaksi (Nominal, Tanggal, NoHpUMK, IdJenis)
values (170000, '2024-03-16', '082134', 2);
UPDATE UMK
SET Saldo = Saldo + 170000
WHERE NoHp = '082134'

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