-- Schema Creation

-- Tabel Hotel
CREATE TABLE Hotel (
    ID_Hotel SERIAL PRIMARY KEY,
    Nama_Hotel VARCHAR(255) NOT NULL,
    Alamat TEXT NOT NULL,
    Kota VARCHAR(100),
    Telepon VARCHAR(15)
);

-- Tabel Kamar
CREATE TABLE Kamar (
    ID_Kamar SERIAL PRIMARY KEY,
    ID_Hotel INT NOT NULL,
    Tipe_kamar VARCHAR(50),
    Harga DECIMAL(10, 2),
    Status VARCHAR(20),
    CONSTRAINT FK_Hotel FOREIGN KEY (ID_Hotel) REFERENCES Hotel(ID_Hotel) ON DELETE CASCADE
);

-- Tabel Pelanggan
CREATE TABLE Pelanggan (
    ID_Pelanggan SERIAL PRIMARY KEY,
    Nama VARCHAR(255) NOT NULL,
    Email VARCHAR(100),
    Telepon VARCHAR(15)
);

-- Tabel Pemesanan
CREATE TABLE Pemesanan (
    ID_Pemesanan SERIAL PRIMARY KEY,
    ID_Pelanggan INT NOT NULL,
    ID_Kamar INT NOT NULL,
    Tgl_masuk DATE NOT NULL,
    Tgl_keluar DATE NOT NULL,
    Total_Harga DECIMAL(10, 2),
    CONSTRAINT FK_Pelanggan FOREIGN KEY (ID_Pelanggan) REFERENCES Pelanggan(ID_Pelanggan) ON DELETE CASCADE,
    CONSTRAINT FK_Kamar FOREIGN KEY (ID_Kamar) REFERENCES Kamar(ID_Kamar) ON DELETE CASCADE
);

-- Tabel Ulasan
CREATE TABLE Ulasan (
    ID_Ulasan SERIAL PRIMARY KEY,
    ID_Hotel INT NOT NULL,
    ID_Pelanggan INT NOT NULL,
    Tgl_Ulasan DATE NOT NULL,
    Komentar TEXT,
    CONSTRAINT FK_Hotel_Ulasan FOREIGN KEY (ID_Hotel) REFERENCES Hotel(ID_Hotel) ON DELETE CASCADE,
    CONSTRAINT FK_Pelanggan_Ulasan FOREIGN KEY (ID_Pelanggan) REFERENCES Pelanggan(ID_Pelanggan) ON DELETE CASCADE
);  

-- Insert data ke tabel Hotel
INSERT INTO Hotel (Nama_Hotel, Alamat, Kota, Telepon) VALUES
('Hotel Bintang Lima', 'Jl. Sudirman No.1', 'Jakarta', '02112345678'),
('Hotel Melati', 'Jl. Merdeka No.10', 'Bandung', '02298765432'),
('Hotel Puncak Indah', 'Jl. Raya Puncak KM.45', 'Bogor', '02512349876'),
('Hotel Sunset Beach', 'Jl. Pantai Barat No.25', 'Bali', '03617654321'),
('Hotel Tropis', 'Jl. Mangga Dua No.88', 'Surabaya', '03178901234');

-- Insert data ke tabel Kamar
INSERT INTO Kamar (ID_Hotel, Tipe_kamar, Harga, Status) VALUES
(1, 'Deluxe', 500000, 'Available'),
(1, 'Suite', 1000000, 'Available'),
(2, 'Standard', 300000, 'Booked'),
(3, 'Superior', 700000, 'Available'),
(4, 'Family', 900000, 'Available');

-- Insert data ke tabel Pelanggan
INSERT INTO Pelanggan (Nama, Email, Telepon) VALUES
('John Doe', 'john.doe@example.com', '081234567890'),
('Jane Smith', 'jane.smith@example.com', '081234567891'),
('Michael Brown', 'michael.brown@example.com', '081234567892'),
('Emily Davis', 'emily.davis@example.com', '081234567893'),
('William Johnson', 'william.johnson@example.com', '081234567894');

-- Insert data ke tabel Pemesanan
INSERT INTO Pemesanan (ID_Pelanggan, ID_Kamar, Tgl_masuk, Tgl_keluar, Total_Harga) VALUES
(1, 1, '2024-12-01', '2024-12-05', 2000000),
(2, 3, '2024-12-03', '2024-12-06', 900000),
(3, 2, '2024-12-10', '2024-12-12', 2000000),
(4, 4, '2024-12-15', '2024-12-20', 3500000),
(5, 5, '2024-12-22', '2024-12-25', 2700000);


-- Insert data ke tabel Ulasan
INSERT INTO Ulasan (ID_Hotel, ID_Pelanggan, Tgl_Ulasan, Komentar) VALUES
(1, 1, '2024-12-06', 'Pelayanan sangat memuaskan.'),
(2, 2, '2024-12-07', 'Hotel cukup nyaman dan terjangkau.'),
(3, 3, '2024-12-13', 'Pemandangan luar biasa, akan kembali lagi.'),
(4, 4, '2024-12-21', 'Staff ramah dan lokasi strategis.'),
(5, 5, '2024-12-26', 'Fasilitas lengkap dan harga sesuai.');



SELECT * FROM Hotel;j,i;
SELECT * FROM Kamar;
SELECT * FROM Pelanggan;
SELECT * FROM Pemesanan;
SELECT * FROM Ulasan;

SELECT 
    K.ID_Kamar, 
    K.Tipe_kamar, 
    K.Harga, 
    H.Nama_Hotel, 
    H.Kota 
FROM 
    Kamar AS K
JOIN 
    Hotel AS H ON K.ID_Hotel = H.ID_Hotel
WHERE 
    K.Status = 'Available';

SELECT 
    ID_Pelanggan, 
    Nama, 
    Email, 
    Telepon 
FROM 
    Pelanggan
WHERE 
    Email = 'john.doe@example.com';

SELECT 
    P.ID_Pemesanan, 
    PL.Nama AS Nama_Pelanggan, 
    K.Tipe_kamar, 
    H.Nama_Hotel, 
    P.Tgl_masuk, 
    P.Tgl_keluar, 
    P.Total_Harga 
FROM 
    Pemesanan AS P
JOIN 
    Pelanggan AS PL ON P.ID_Pelanggan = PL.ID_Pelanggan
JOIN 
    Kamar AS K ON P.ID_Kamar = K.ID_Kamar
JOIN 
    Hotel AS H ON K.ID_Hotel = H.ID_Hotel
WHERE 
    PL.Nama = 'John Doe';

SELECT 
    H.Nama_Hotel, 
    COUNT(K.ID_Kamar) AS Jumlah_Kamar 
FROM 
    Hotel AS H
LEFT JOIN 
    Kamar AS K ON H.ID_Hotel = K.ID_Hotel
GROUP BY 
    H.ID_Hotel, H.Nama_Hotel;

SELECT 
    U.ID_Ulasan, 
    U.Komentar, 
    U.Tgl_Ulasan, 
    P.Nama AS Nama_Pelanggan, 
    H.Nama_Hotel 
FROM 
    Ulasan AS U
JOIN 
    Pelanggan AS P ON U.ID_Pelanggan = P.ID_Pelanggan
JOIN 
    Hotel AS H ON U.ID_Hotel = H.ID_Hotel
WHERE 
    H.ID_Hotel = 1;

SELECT 
    H.Nama_Hotel, 
    SUM(P.Total_Harga) AS Total_Pendapatan 
FROM 
    Pemesanan AS P
JOIN 
    Kamar AS K ON P.ID_Kamar = K.ID_Kamar
JOIN 
    Hotel AS H ON K.ID_Hotel = H.ID_Hotel
GROUP BY 
    H.ID_Hotel, H.Nama_Hotel;

-- Update status kamar menjadi 'Booked'
UPDATE Kamar
SET Status = 'Booked'
WHERE ID_Kamar = 1;

-- Update email pelanggan
UPDATE Pelanggan
SET Email = 'new.email@example.com'
WHERE ID_Pelanggan = 1;

-- Hapus data pemesanan
DELETE FROM Pemesanan
WHERE ID_Pemesanan = 1;

-- Hapus data ulasan
DELETE FROM Ulasan
WHERE ID_Ulasan = 1;