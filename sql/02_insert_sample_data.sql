-- ============================================================
-- ANTALYA OTEL REZERVASYOn ANALİTİĞİ - GÜN 1
-- Dosya: 02_insert_sample_data.sql
-- Açıklama: Örnek verilerin tablolara yüklenmesi
-- ============================================================

USE OtelAnalizDB;
GO

-- ============================================================
-- MÜŞTERİLER - 30 kayıt
-- ============================================================
INSERT INTO dbo.Musteriler (Ad, Soyad, Sehir, Ulke, Email, Telefon, KayitTarihi)
VALUES
  ('Ahmet',     'Yılmaz',     'İstanbul',  'Türkiye',  'ahmet.yilmaz@email.com',    '0532-111-0001', '2024-01-15'),
  ('Fatma',     'Demir',      'Ankara',    'Türkiye',  'fatma.demir@email.com',     '0533-111-0002', '2024-01-20'),
  ('Mehmet',    'Kaya',       'İzmir',     'Türkiye',  'mehmet.kaya@email.com',     '0534-111-0003', '2024-02-05'),
  ('Ayşe',      'Çelik',      'Bursa',     'Türkiye',  'ayse.celik@email.com',      '0535-111-0004', '2024-02-10'),
  ('Mustafa',   'Şahin',      'Antalya',   'Türkiye',  'mustafa.sahin@email.com',   '0536-111-0005', '2024-02-18'),
  ('Zeynep',    'Arslan',     'Konya',     'Türkiye',  'zeynep.arslan@email.com',   '0537-111-0006', '2024-03-01'),
  ('Ali',       'Doğan',      'Adana',     'Türkiye',  'ali.dogan@email.com',       '0538-111-0007', '2024-03-10'),
  ('Hülya',     'Kılıç',      'Gaziantep', 'Türkiye',  'hulya.kilic@email.com',     '0539-111-0008', '2024-03-22'),
  ('İbrahim',   'Özdemir',    'İstanbul',  'Türkiye',  'ibrahim.ozdemir@email.com', '0530-111-0009', '2024-04-05'),
  ('Elif',      'Yıldırım',   'Ankara',    'Türkiye',  'elif.yildirim@email.com',   '0532-222-0010', '2024-04-12'),
  ('Thomas',    'Müller',     'Berlin',    'Almanya',  'thomas.mueller@gmail.com',  NULL,            '2024-04-20'),
  ('Sophie',    'Leclerc',    'Paris',     'Fransa',   'sophie.leclerc@gmail.com',  NULL,            '2024-05-01'),
  ('John',      'Smith',      'Londra',    'İngiltere','john.smith@email.co.uk',    NULL,            '2024-05-08'),
  ('Anna',      'Nowak',      'Varşova',   'Polonya',  'anna.nowak@email.pl',       NULL,            '2024-05-15'),
  ('Carlos',    'García',     'Madrid',    'İspanya',  'carlos.garcia@email.es',    NULL,            '2024-05-20'),
  ('Olga',      'Petrova',    'Moskova',   'Rusya',    'olga.petrova@mail.ru',      NULL,            '2024-06-01'),
  ('Hans',      'Weber',      'Münih',     'Almanya',  'hans.weber@gmail.com',      NULL,            '2024-06-05'),
  ('Maria',     'Rossi',      'Roma',      'İtalya',   'maria.rossi@email.it',      NULL,            '2024-06-10'),
  ('Hasan',     'Koç',        'Samsun',    'Türkiye',  'hasan.koc@email.com',       '0533-333-0019', '2024-06-15'),
  ('Selin',     'Aktaş',      'Eskişehir', 'Türkiye',  'selin.aktas@email.com',     '0534-333-0020', '2024-06-20'),
  ('Burak',     'Güneş',      'İstanbul',  'Türkiye',  'burak.gunes@email.com',     '0535-333-0021', '2024-07-01'),
  ('Nilüfer',   'Erdoğan',    'İzmir',     'Türkiye',  'nilufer.erdogan@email.com', '0536-333-0022', '2024-07-05'),
  ('Pierre',    'Dupont',     'Lyon',      'Fransa',   'pierre.dupont@gmail.com',   NULL,            '2024-07-10'),
  ('Emma',      'Wilson',     'Manchester','İngiltere', 'emma.wilson@email.co.uk',  NULL,            '2024-07-15'),
  ('Klaus',     'Bauer',      'Frankfurt', 'Almanya',  'klaus.bauer@gmail.com',     NULL,            '2024-07-20'),
  ('Yusuf',     'Polat',      'Ankara',    'Türkiye',  'yusuf.polat@email.com',     '0537-444-0026', '2024-08-01'),
  ('Ceren',     'Aydın',      'İstanbul',  'Türkiye',  'ceren.aydin@email.com',     '0538-444-0027', '2024-08-05'),
  ('Murat',     'Bozkurt',    'Trabzon',   'Türkiye',  'murat.bozkurt@email.com',   '0539-444-0028', '2024-08-10'),
  ('Lena',      'Hoffmann',   'Hamburg',   'Almanya',  'lena.hoffmann@gmail.com',   NULL,            '2024-08-15'),
  ('Laura',     'Martínez',   'Barselona', 'İspanya',  'laura.martinez@email.es',   NULL,            '2024-08-20');
GO

-- ============================================================
-- OTEL ODALARI - 20 oda
-- ============================================================
INSERT INTO dbo.OtelOdalari (OdaNumarasi, OdaTipi, KatSayisi, KisiKapasitesi, GunlukFiyat, Manzara, Durum)
VALUES
  ('101', 'Standart',  1, 2, 1200.00, 'Bahçe',  'Müsait'),
  ('102', 'Standart',  1, 2, 1200.00, 'Bahçe',  'Müsait'),
  ('103', 'Standart',  1, 3, 1400.00, 'Havuz',  'Müsait'),
  ('201', 'Deluxe',    2, 2, 2200.00, 'Deniz',  'Müsait'),
  ('202', 'Deluxe',    2, 2, 2200.00, 'Deniz',  'Müsait'),
  ('203', 'Deluxe',    2, 3, 2500.00, 'Havuz',  'Müsait'),
  ('204', 'Deluxe',    2, 4, 2800.00, 'Deniz',  'Müsait'),
  ('301', 'Suite',     3, 2, 4500.00, 'Deniz',  'Müsait'),
  ('302', 'Suite',     3, 3, 5000.00, 'Deniz',  'Müsait'),
  ('303', 'Suite',     3, 4, 5500.00, 'Panoramik', 'Müsait'),
  ('401', 'Penthouse', 4, 4, 8000.00, 'Panoramik', 'Müsait'),
  ('V01', 'Villa',     1, 6, 12000.00,'Deniz',  'Müsait'),
  ('V02', 'Villa',     1, 8, 15000.00,'Özel Havuz','Müsait'),
  ('104', 'Standart',  1, 2, 1100.00, 'Bahçe',  'Müsait'),
  ('205', 'Deluxe',    2, 2, 2300.00, 'Havuz',  'Müsait'),
  ('304', 'Suite',     3, 2, 4800.00, 'Deniz',  'Müsait'),
  ('105', 'Standart',  1, 1, 950.00,  'Bahçe',  'Müsait'),
  ('206', 'Deluxe',    2, 3, 2600.00, 'Deniz',  'Müsait'),
  ('305', 'Suite',     3, 4, 5200.00, 'Panoramik', 'Müsait'),
  ('402', 'Penthouse', 4, 6, 9500.00, 'Panoramik', 'Müsait');
GO

-- ============================================================
-- REZERVASYONLAR - 80 rezervasyon (2024 yılı - tam sezon)
-- ============================================================
INSERT INTO dbo.Rezervasyonlar (MusteriID, OdaID, GirisTarihi, CikisTarihi, KisiSayisi, ToplamTutar, OdemeTipi, RezervasyonDurumu)
VALUES
-- OCAK (Düşük Sezon)
  (1,  1, '2024-01-05', '2024-01-08', 2, 3600.00,  'Kredi Kartı',      'Tamamlandı'),
  (2,  4, '2024-01-10', '2024-01-15', 2, 11000.00, 'Online Transfer',  'Tamamlandı'),
  (3,  8, '2024-01-20', '2024-01-25', 2, 22500.00, 'Kredi Kartı',      'Tamamlandı'),
  (19, 2, '2024-01-28', '2024-01-31', 2, 3600.00,  'Nakit',            'Tamamlandı'),

-- ŞUBAT
  (4,  5, '2024-02-02', '2024-02-07', 2, 11000.00, 'Kredi Kartı',      'Tamamlandı'),
  (5,  3, '2024-02-14', '2024-02-18', 2, 5600.00,  'Kredi Kartı',      'Tamamlandı'),
  (20, 9, '2024-02-20', '2024-02-25', 3, 25000.00, 'Online Transfer',  'Tamamlandı'),
  (6,  1, '2024-02-26', '2024-02-29', 2, 3600.00,  'Nakit',            'Tamamlandı'),

-- MART
  (7,  6, '2024-03-05', '2024-03-10', 3, 12500.00, 'Kredi Kartı',      'Tamamlandı'),
  (8,  4, '2024-03-15', '2024-03-20', 2, 11000.00, 'Online Transfer',  'Tamamlandı'),
  (11, 10, '2024-03-22', '2024-03-28', 4, 33000.00,'Kredi Kartı',      'Tamamlandı'),
  (9,  2, '2024-03-28', '2024-03-31', 2, 3600.00,  'Nakit',            'Tamamlandı'),

-- NİSAN (Erken Sezon)
  (12, 8, '2024-04-01', '2024-04-07', 2, 27000.00, 'Kredi Kartı',      'Tamamlandı'),
  (10, 5, '2024-04-08', '2024-04-14', 2, 15400.00, 'Online Transfer',  'Tamamlandı'),
  (13, 11,'2024-04-15', '2024-04-21', 4, 48000.00, 'Kredi Kartı',      'Tamamlandı'),
  (21, 3, '2024-04-22', '2024-04-28', 3, 8400.00,  'Kredi Kartı',      'Tamamlandı'),
  (14, 7, '2024-04-29', '2024-04-30', 2, 2200.00,  'Nakit',            'Tamamlandı'),

-- MAYIS
  (15, 12,'2024-05-01', '2024-05-07', 5, 84000.00, 'Online Transfer',  'Tamamlandı'),
  (16, 9, '2024-05-05', '2024-05-12', 3, 35000.00, 'Kredi Kartı',      'Tamamlandı'),
  (22, 6, '2024-05-10', '2024-05-17', 3, 17500.00, 'Kredi Kartı',      'Tamamlandı'),
  (17, 4, '2024-05-15', '2024-05-22', 2, 15400.00, 'Online Transfer',  'Tamamlandı'),
  (23, 10,'2024-05-20', '2024-05-27', 4, 38500.00, 'Kredi Kartı',      'Tamamlandı'),
  (1,  8, '2024-05-28', '2024-05-31', 2, 13500.00, 'Nakit',            'Tamamlandı'),

-- HAZİRAN (Yüksek Sezon)
  (18, 13,'2024-06-01', '2024-06-08', 7, 105000.00,'Online Transfer',  'Tamamlandı'),
  (2,  11,'2024-06-05', '2024-06-12', 3, 56000.00, 'Kredi Kartı',      'Tamamlandı'),
  (25, 9, '2024-06-10', '2024-06-17', 3, 35000.00, 'Kredi Kartı',      'Tamamlandı'),
  (3,  5, '2024-06-15', '2024-06-22', 2, 16100.00, 'Online Transfer',  'Tamamlandı'),
  (12, 12,'2024-06-20', '2024-06-27', 6, 84000.00, 'Kredi Kartı',      'Tamamlandı'),
  (26, 7, '2024-06-25', '2024-06-30', 2, 11000.00, 'Nakit',            'Tamamlandı'),

-- TEMMUZ (Zirve Sezon)
  (11, 13,'2024-07-01', '2024-07-10', 8, 135000.00,'Online Transfer',  'Tamamlandı'),
  (13, 11,'2024-07-05', '2024-07-15', 4, 80000.00, 'Kredi Kartı',      'Tamamlandı'),
  (4,  10,'2024-07-10', '2024-07-17', 4, 38500.00, 'Kredi Kartı',      'Tamamlandı'),
  (17, 8, '2024-07-12', '2024-07-22', 2, 45000.00, 'Online Transfer',  'Tamamlandı'),
  (24, 12,'2024-07-15', '2024-07-25', 6, 120000.00,'Kredi Kartı',      'Tamamlandı'),
  (5,  9, '2024-07-20', '2024-07-28', 3, 40000.00, 'Nakit',            'Tamamlandı'),
  (27, 6, '2024-07-25', '2024-07-31', 3, 15600.00, 'Kredi Kartı',      'Tamamlandı'),
  (15, 4, '2024-07-28', '2024-07-31', 2, 6600.00,  'Online Transfer',  'Tamamlandı'),

-- AĞUSTOS (Zirve Sezon)
  (16, 13,'2024-08-01', '2024-08-10', 7, 135000.00,'Online Transfer',  'Tamamlandı'),
  (18, 11,'2024-08-05', '2024-08-15', 4, 80000.00, 'Kredi Kartı',      'Tamamlandı'),
  (6,  10,'2024-08-10', '2024-08-17', 4, 38500.00, 'Kredi Kartı',      'Tamamlandı'),
  (25, 8, '2024-08-12', '2024-08-22', 2, 45000.00, 'Online Transfer',  'Tamamlandı'),
  (29, 12,'2024-08-15', '2024-08-25', 6, 120000.00,'Kredi Kartı',      'Tamamlandı'),
  (7,  9, '2024-08-20', '2024-08-28', 3, 40000.00, 'Nakit',            'Tamamlandı'),
  (30, 7, '2024-08-25', '2024-08-31', 2, 13200.00, 'Kredi Kartı',      'Tamamlandı'),
  (8,  6, '2024-08-28', '2024-08-31', 3, 7800.00,  'Online Transfer',  'Tamamlandı'),

-- EYLÜL (Yüksek Sezon - Uzun Konaklamalar)
  (14, 12,'2024-09-01', '2024-09-10', 5, 108000.00,'Online Transfer',  'Tamamlandı'),
  (23, 11,'2024-09-05', '2024-09-14', 3, 72000.00, 'Kredi Kartı',      'Tamamlandı'),
  (9,  8, '2024-09-10', '2024-09-18', 2, 36000.00, 'Kredi Kartı',      'Tamamlandı'),
  (28, 9, '2024-09-15', '2024-09-22', 3, 35000.00, 'Online Transfer',  'Tamamlandı'),
  (10, 5, '2024-09-20', '2024-09-27', 2, 16100.00, 'Nakit',            'Tamamlandı'),
  (22, 4, '2024-09-25', '2024-09-30', 2, 11000.00, 'Kredi Kartı',      'Tamamlandı'),

-- EKİM (Erken Kapanış)
  (19, 10,'2024-10-01', '2024-10-07', 3, 33000.00, 'Kredi Kartı',      'Tamamlandı'),
  (20, 7, '2024-10-08', '2024-10-14', 2, 15400.00, 'Online Transfer',  'Tamamlandı'),
  (1,  5, '2024-10-15', '2024-10-20', 2, 11000.00, 'Kredi Kartı',      'Tamamlandı'),
  (26, 3, '2024-10-22', '2024-10-28', 2, 8400.00,  'Nakit',            'Tamamlandı'),
  (21, 1, '2024-10-29', '2024-10-31', 2, 2400.00,  'Kredi Kartı',      'Tamamlandı'),

-- KASIM (Düşük Sezon)
  (27, 2, '2024-11-05', '2024-11-09', 2, 4800.00,  'Kredi Kartı',      'Tamamlandı'),
  (2,  4, '2024-11-12', '2024-11-17', 2, 11000.00, 'Online Transfer',  'Tamamlandı'),
  (28, 1, '2024-11-20', '2024-11-25', 2, 6000.00,  'Nakit',            'Tamamlandı'),

-- ARALIK
  (3,  8, '2024-12-20', '2024-12-27', 2, 31500.00, 'Kredi Kartı',      'Tamamlandı'),
  (29, 10,'2024-12-23', '2024-12-29', 4, 33000.00, 'Online Transfer',  'Tamamlandı'),
  (30, 11,'2024-12-28', '2024-12-31', 3, 24000.00, 'Kredi Kartı',      'Tamamlandı'),

-- İPTAL EDİLEN REZERVASYONLAR
  (5,  12,'2024-07-01', '2024-07-05', 5, 48000.00, 'Online Transfer',  'İptal'),
  (13, 11,'2024-08-20', '2024-08-25', 3, 40000.00, 'Kredi Kartı',      'İptal'),
  (8,  13,'2024-06-15', '2024-06-20', 6, 75000.00, 'Online Transfer',  'İptal'),

-- 2025 GELECEK REZERVASYONLAR (Onaylandı durumu)
  (1,  12,'2025-07-10', '2025-07-20', 6, 150000.00,'Online Transfer',  'Onaylandı'),
  (11, 11,'2025-08-01', '2025-08-10', 4, 90000.00, 'Kredi Kartı',      'Onaylandı'),
  (15, 13,'2025-06-15', '2025-06-22', 7, 115500.00,'Kredi Kartı',      'Onaylandı'),
  (22, 10,'2025-05-20', '2025-05-27', 3, 42000.00, 'Online Transfer',  'Onaylandı'),
  (7,  9, '2025-09-05', '2025-09-12', 3, 38500.00, 'Kredi Kartı',      'Onaylandı'),
  (25, 8, '2025-04-10', '2025-04-18', 2, 40500.00, 'Online Transfer',  'Onaylandı');
GO

PRINT 'Tüm örnek veriler başarıyla yüklendi!';
GO
