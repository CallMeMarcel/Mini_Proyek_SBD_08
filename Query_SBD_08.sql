
-- CREATE DATABASE
CREATE DATABASE HotelManagement;

-- CREATE TABLE



-- TABLE HOTEL
CREATE TABLE Hotel (
    Id_Hotel SERIAL PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Lokasi VARCHAR(200) NOT NULL,
    Rating NUMERIC(2, 1) CHECK (Rating >= 0 AND Rating <= 5)
);

-- TABLE KAMAR
CREATE TABLE Kamar (
    Id_Kamar SERIAL PRIMARY KEY,
    Id_Hotel INT NOT NULL REFERENCES Hotel(Id_Hotel),
    Kategori VARCHAR(50) NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Available', 'Occupied', 'Maintenance')) NOT NULL,
    Harga NUMERIC(10, 2) NOT NULL,
    Kapasitas INT NOT NULL
);

-- TABLE PELANGGAN
CREATE TABLE Pelanggan (
    Id_Pelanggan SERIAL PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Kontak VARCHAR(15) NOT NULL
);


-- TABLE ULASAN
CREATE TABLE Ulasan (
    Id_Ulasan SERIAL PRIMARY KEY,
    Id_Hotel INT NOT NULL REFERENCES Hotel(Id_Hotel),
    Id_Pelanggan INT REFERENCES Pelanggan(Id_Pelanggan),
    Komentar TEXT,
    Rating NUMERIC(2, 1) CHECK (Rating >= 0 AND Rating <= 5)
);

-- TABLE TRANSAKSI_PEMESANAN
CREATE TABLE Transaksi_Pemesanan (
    Id_Transaksi SERIAL PRIMARY KEY,
    Id_Kamar INT NOT NULL REFERENCES Kamar(Id_Kamar),
    Id_Pelanggan INT NOT NULL REFERENCES Pelanggan(Id_Pelanggan),
    Tanggal_Masuk DATE NOT NULL,
    Tanggal_Keluar DATE NOT NULL
);

-- INSERT CONTOH DATA

-- HOTEL
INSERT INTO Hotel (Nama, Lokasi, Rating) VALUES
('Hotel Bahagia', 'Jakarta', 4.5),
('Hotel Damai', 'Bali', 4.8),
('Hotel Santai', 'Lombok', 4.6),
('Hotel Indah', 'Bandung', 4.7),
('Hotel Sejahtera', 'Surabaya', 4.4),
('Hotel Harmoni', 'Medan', 4.3),
('Hotel Nyaman', 'Yogyakarta', 4.5),
('Hotel Megah', 'Semarang', 4.8),
('Hotel Bahari', 'Makassar', 4.6),
('Hotel Citra', 'Balikpapan', 4.2);

SELECT * FROM Hotel;

-- KAMAR
INSERT INTO Kamar (Id_Hotel, Kategori, Status, Harga, Kapasitas) VALUES
(1, 'Deluxe', 'Available', 500000, 2),
(1, 'Suite', 'Occupied', 1000000, 4),
(2, 'Standard', 'Available', 300000, 2),
(3, 'Deluxe', 'Available', 600000, 3),
(4, 'Suite', 'Occupied', 1200000, 4),
(5, 'Standard', 'Available', 350000, 2),
(6, 'Premium', 'Available', 800000, 3),
(7, 'Deluxe', 'Occupied', 700000, 3),
(8, 'Suite', 'Available', 1500000, 5),
(9, 'Standard', 'Available', 400000, 2),
(10, 'Premium', 'Occupied', 900000, 4);

SELECT * FROM Kamar;

-- PELANGGAN
INSERT INTO Pelanggan (Nama, Kontak) VALUES
('Budi', '08123456789'),
('Siti', '08198765432'),
('Andi', '08111111111'),
('Tina', '08122222222'),
('Rina', '08133333333'),
('Joko', '08144444444'),
('Agus', '08155555555'),
('Lina', '08166666666'),
('Rudi', '08177777777'),
('Dina', '08188888888');

SELECT * FROM Pelanggan;

-- ULASAN
INSERT INTO Ulasan (Id_Hotel, Id_Pelanggan, Komentar, Rating) VALUES
(1, 1, 'Pelayanan sangat baik!', 5.0),
(2, 2, 'Kamar bersih dan nyaman.', 4.5),
(4, 4, 'Pelayanan ramah.', 4.8),
(5, 5, 'Lokasi strategis.', 4.6),
(6, 6, 'Makanan lezat.', 4.9),
(7, 7, 'Kamar luas dan bersih.', 4.8),
(8, 8, 'Rekomendasi untuk keluarga.', 5.0),
(9, 1, 'Parkir luas.', 4.5),
(10, 2, 'Dekat dengan wisata.', 4.6);

SELECT * FROM Ulasan;


-- TRANSAKSI PEMESANAN
INSERT INTO Transaksi_Pemesanan (Id_Kamar, Id_Pelanggan, Tanggal_Masuk, Tanggal_Keluar) VALUES
(1, 1, '2024-12-01', '2024-12-05'),
(2, 2, '2024-12-02', '2024-12-06'),
(3, 3, '2024-12-03', '2024-12-07'),
(4, 4, '2024-12-04', '2024-12-08'),
(5, 5, '2024-12-05', '2024-12-09'),
(6, 6, '2024-12-06', '2024-12-10'),
(7, 7, '2024-12-07', '2024-12-11'),
(8, 8, '2024-12-08', '2024-12-12'),
(9, 1, '2024-12-09', '2024-12-13'),
(10, 2, '2024-12-10', '2024-12-14');

SELECT * FROM Transaksi_Pemesanan;

-- AUTHORIZATION

SET ROLE postgres;
-- Membuat role admin tanpa password
CREATE ROLE admin LOGIN;

-- Membuat role user tanpa password
CREATE ROLE pelanggan LOGIN;
SET ROLE pelanggan;
SET ROLE admin;

SELECT CURRENT_USER;
-- HAK AKSES UNTUK ADMIN
-- Memberikan akses penuh ke semua tabel di schema public
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;

-- Memberikan akses penuh ke semua sequence (untuk auto-increment)
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin;

-- Memberikan akses penuh ke semua fungsi
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO admin;


-- HAK AKSES UNTUK USER
-- Memberikan hak akses hanya untuk tabel Ulasan
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Ulasan TO pelanggan;





-- MODIFY DATA

-- TABLE HOTEL
-- INSERT
INSERT INTO Hotel (Nama, Lokasi, Rating) VALUES ('Hotel Mewah', 'Surabaya', 4.7);

-- UPDATE
UPDATE Hotel SET Rating = 4.9 WHERE Id_Hotel = 1;

-- DELETE
DELETE FROM Hotel WHERE Id_Hotel = 2;


-- TABLE KAMAR
-- INSERT
INSERT INTO Kamar (Id_Hotel, Kategori, Status, Harga, Kapasitas) 
VALUES (1, 'Premium', 'Available', 700000, 3);

-- UPDATE
UPDATE Kamar SET Status = 'Maintenance' WHERE Id_Kamar = 1;

-- DELETE
DELETE FROM Kamar WHERE Id_Kamar = 3;


-- TABLE PELANGGAN
-- INSERT
INSERT INTO Pelanggan (Nama, Kontak) VALUES ('Andi', '081333445566');

-- UPDATE
UPDATE Pelanggan SET Kontak = '081122334455' WHERE Id_Pelanggan = 1;

-- DELETE
DELETE FROM Pelanggan WHERE Id_Pelanggan = 2;

--TABLE ULASAN
-- INSERT
INSERT INTO Ulasan (Id_Hotel, Id_Pelanggan, Komentar, Rating) 
VALUES (1, 1, 'Sangat puas dengan pelayanan.', 5.0);

-- UPDATE
UPDATE Ulasan SET Komentar = 'Pelayanan perlu ditingkatkan' WHERE Id_Ulasan = 1;

-- DELETE
DELETE FROM Ulasan WHERE Id_Ulasan = 2;


-- TABLE TRANSAKSI_PEMESANAN
-- INSERT
INSERT INTO Transaksi_Pemesanan (Id_Kamar, Id_Pelanggan, Tanggal_Masuk, Tanggal_Keluar) 
VALUES (2, 1, '2024-12-10', '2024-12-12');

-- UPDATE
UPDATE Transaksi_Pemesanan SET Tanggal_Keluar = '2024-12-15' WHERE Id_Transaksi = 1;

-- DELETE
DELETE FROM Transaksi_Pemesanan WHERE Id_Transaksi = 2;

-- VIEW

-- VIEW UNTUK MENAMPILKAN DAFTAR KAMAR YANG TERSEDIA
CREATE VIEW Kamar_Tersedia AS
SELECT 
    K.Id_Kamar,
    H.Nama AS Nama_Hotel,
    K.Kategori,
    K.Harga,
    K.Kapasitas
FROM 
    Kamar K
JOIN 
    Hotel H ON K.Id_Hotel = H.Id_Hotel
WHERE 
    K.Status = 'Available';


SELECT * FROM Kamar_Tersedia;




-- VIEW UNTUK MENAMPILKAN TRANSAKSI PEMBELIAN BERDASARKAN NAMA PELANGGAN
CREATE VIEW Transaksi_Pelanggan AS
SELECT 
    TP.Id_Transaksi,
    P.Nama AS Nama_Pelanggan,
    K.Kategori AS Tipe_Kamar,
    TP.Tanggal_Masuk,
    TP.Tanggal_Keluar
FROM 
    Transaksi_Pemesanan TP
JOIN 
    Pelanggan P ON TP.Id_Pelanggan = P.Id_Pelanggan
JOIN 
    Kamar K ON TP.Id_Kamar = K.Id_Kamar;

SELECT * FROM Transaksi_Pelanggan;


-- VIEW UNTUK MENAMPILKAN ULASAN PELANGGAN UNTUK HOTEL
CREATE VIEW Ulasan_Hotel AS
SELECT 
    H.Nama AS Nama_Hotel,
    P.Nama AS Nama_Pelanggan,
    U.Komentar,
    U.Rating
FROM 
    Ulasan U
JOIN 
    Hotel H ON U.Id_Hotel = H.Id_Hotel
LEFT JOIN 
    Pelanggan P ON U.Id_Pelanggan = P.Id_Pelanggan;

SELECT * FROM Ulasan_Hotel;

-- TRANSACTION

-- TRANSAKSI UNTUK MEMESAN KAMAR
BEGIN;

-- Tambahkan transaksi pemesanan
INSERT INTO Transaksi_Pemesanan (Id_Kamar, Id_Pelanggan, Tanggal_Masuk, Tanggal_Keluar)
VALUES (1, 1, '2024-12-20', '2024-12-25');

-- Perbarui status kamar menjadi 'Occupied'
UPDATE Kamar 
SET Status = 'Occupied'
WHERE Id_Kamar = 1;

COMMIT;

-- LIHAT PERUBAHAN
SELECT * FROM Transaksi_Pemesanan;
SELECT * FROM Kamar;

-- TRANSAKSI UNTUK MEMBATALKAN PEMESANAN
BEGIN;

-- Hapus transaksi pemesanan
DELETE FROM Transaksi_Pemesanan 
WHERE Id_Transaksi = 2;

-- Perbarui status kamar menjadi 'Available'
UPDATE Kamar 
SET Status = 'Available'
WHERE Id_Kamar = 1;

COMMIT;

-- LIHAT PERUBAHAN
SELECT * FROM Transaksi_Pemesanan;
SELECT * FROM Kamar;

-- TRANSAKSI DENGAN ROLLBACK UNTUK MENANGANI KESALAHAN 
BEGIN;

-- Tambahkan pelanggan baru
INSERT INTO Pelanggan (Nama, Kontak) 
VALUES ('John Doe', '081245678910');

-- Tambahkan transaksi pemesanan (kesalahan: kamar tidak ada)
INSERT INTO Transaksi_Pemesanan (Id_Kamar, Id_Pelanggan, Tanggal_Masuk, Tanggal_Keluar)
VALUES (999, 3, '2024-12-15', '2024-12-18'); -- Kamar dengan Id 999 tidak ada

-- Jika terjadi kesalahan, rollback
ROLLBACK;

-- LIHAT PERUBAHAN
SELECT * FROM Transaksi_Pemesanan;
SELECT * FROM Kamar;

-- TRIGGER 

-- mengubah status kamar menjadi "Occupied" saat transaksi pemesanan dilakukan
CREATE OR REPLACE FUNCTION update_status_kamar()
RETURNS TRIGGER AS $$
BEGIN
    -- Mengubah status kamar menjadi 'Occupied'
    UPDATE Kamar
    SET Status = 'Occupied'
    WHERE Id_Kamar = NEW.Id_Kamar;

    -- Memberikan notifikasi bahwa status kamar berhasil diubah
    RAISE NOTICE 'Status kamar dengan Id_Kamar % telah berubah menjadi Occupied', NEW.Id_Kamar;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Membuat Trigger
CREATE TRIGGER set_status_kamar
AFTER INSERT ON Transaksi_Pemesanan
FOR EACH ROW
EXECUTE FUNCTION update_status_kamar();

INSERT INTO Transaksi_Pemesanan (Id_Kamar, Id_Pelanggan, Tanggal_Masuk, Tanggal_Keluar)
VALUES (1, 1, '2024-12-15', '2024-12-20');

SELECT Status FROM Kamar WHERE Id_Kamar = 1;

INSERT INTO Transaksi_Pemesanan (Id_Kamar, Id_Pelanggan, Tanggal_Masuk, Tanggal_Keluar)
VALUES (2, 2, '2024-12-16', '2024-12-22'); -- Tambahkan data untuk kamar lain.

SELECT * FROM Kamar WHERE Id_Kamar = 2; -- Cek status kamar


-- CURSOR
-- 1. membaca data dari tabel Hotel dan menampilkan ulasan setiap hotel beserta rating-nya.
DO $$
DECLARE
    hotel_record RECORD;
BEGIN
    FOR hotel_record IN SELECT Nama, Rating FROM Hotel LOOP
        RAISE NOTICE 'Hotel: %, Rating: %', hotel_record.Nama, hotel_record.Rating;
    END LOOP;
END;
$$;

-- 2. menghitung total pendapatan berdasarkan tabel Kamar (harga dikalikan kapasitas) dan menampilkan hasilnya.
DO $$
DECLARE
    kamar_record RECORD;
    total_pendapatan NUMERIC(10, 2) := 0;
BEGIN
    FOR kamar_record IN SELECT Harga, Kapasitas FROM Kamar LOOP
        total_pendapatan := total_pendapatan + (kamar_record.Harga * kamar_record.Kapasitas);
    END LOOP;

    RAISE NOTICE 'Total Pendapatan Semua Kamar: %', total_pendapatan;
END;
$$;



SELECT * FROM Hotel;
SELECT * FROM Kamar;

-- STORED PROCEDURE

-- STORED PROCEDURE UNTUK MENGHITUNG TOTAL TAGIHAN DENGAN DISKON

-- Stored Procedure: Hitung Total Tagihan
CREATE OR REPLACE PROCEDURE TotalTagihan(
    idTransaksi INT,
    diskonPersentase NUMERIC(5, 2),
    OUT totalTagihan NUMERIC(12, 2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    lamaMenginap INT;
    hargaPerMalam NUMERIC(10, 2);
    subtotal NUMERIC(12, 2);
BEGIN
    -- Ambil data lama menginap dan harga kamar
    SELECT 
        Tanggal_Keluar - Tanggal_Masuk AS LamaMenginap,
        k.Harga AS HargaPerMalam
    INTO 
        lamaMenginap,
        hargaPerMalam
    FROM 
        Transaksi_Pemesanan tp
    JOIN 
        Kamar k ON tp.Id_Kamar = k.Id_Kamar
    WHERE 
        tp.Id_Transaksi = idTransaksi;

    -- Hitung subtotal (lama menginap * harga per malam)
    subtotal := lamaMenginap * hargaPerMalam;

    -- Hitung total tagihan setelah diskon
    totalTagihan := subtotal - (subtotal * (diskonPersentase / 100));
END;
$$;

SELECT * FROM KAMAR;
-- PEMANGGILAN PROSEDUR
DO $$
DECLARE
    total NUMERIC(12, 2);
BEGIN
    -- Memanggil stored procedure dan menyimpan hasilnya ke dalam variabel 'total'
    CALL TotalTagihan(3, 50, total);
    -- Menampilkan hasil dengan 'RAISE NOTICE'
    RAISE NOTICE 'Total Tagihan: %', total;
END;
$$;



-- LAPORAN TINGKAT HUNIAN PERIODE
CREATE OR REPLACE FUNCTION HitungTingkatHunian(
    tanggal_awal DATE,
    tanggal_akhir DATE
)
RETURNS TABLE (
    periode TEXT,
    kamar_terisi BIGINT,
    kamar_tersedia BIGINT,
    kapasitas_total_orang BIGINT,
    tingkat_hunian TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        TO_CHAR(tp.Tanggal_Masuk, 'YYYY-MM') AS periode,
        COUNT(DISTINCT tp.Id_Kamar) AS kamar_terisi,
        COUNT(k.Id_Kamar) AS kamar_tersedia,
        SUM(k.Kapasitas) AS kapasitas_total_orang,
        CONCAT(ROUND((COUNT(DISTINCT tp.Id_Kamar) * 100.0 / COUNT(k.Id_Kamar)), 2), ' %') AS tingkat_hunian
    FROM 
        Transaksi_Pemesanan tp
    JOIN 
        Kamar k ON tp.Id_Kamar = k.Id_Kamar
    WHERE 
        (tp.Tanggal_Masuk BETWEEN tanggal_awal AND tanggal_akhir)
        OR (tp.Tanggal_Keluar BETWEEN tanggal_awal AND tanggal_akhir)
    GROUP BY 
        TO_CHAR(tp.Tanggal_Masuk, 'YYYY-MM')
    ORDER BY 
        periode;
END;
$$ LANGUAGE plpgsql;



-- PEMANGGILAN FUNGSI
SELECT * FROM HitungTingkatHunian('2024-01-01', '2024-12-31');



-- SCRAPPING

CREATE TABLE ulasan_csv (
    NamaPengulas TEXT,
    Negara TEXT,
    JumlahUlasan TEXT,
    Skor TEXT,
    IsiUlasan TEXT,
    UlasanNegatif TEXT,
    UlasanPositif TEXT,
    TanggalUlasan TEXT,
    TanggalMenginap TEXT
);

select * from ulasan_csv;

-- IMPORT DATA DARI HASIL SCRAPPING CSV KEDALAM TABEL ulasan_csv
COPY ulasan_csv (NamaPengulas, Negara, JumlahUlasan, Skor, IsiUlasan, UlasanNegatif, UlasanPositif, TanggalUlasan, TanggalMenginap)
FROM 'D:\\SBD\\CSV\\ulasan_hotel.csv'
DELIMITER ','
CSV HEADER;


















