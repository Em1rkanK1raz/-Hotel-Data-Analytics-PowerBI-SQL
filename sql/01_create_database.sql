-- ============================================================
-- ANTALYA OTEL REZERVASYOn ANALİTİĞİ - GÜN 1
-- Dosya: 01_create_database.sql
-- Açıklama: Veritabanı ve tablo yapısının oluşturulması
-- ============================================================

-- Veritabanını oluştur
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'OtelAnalizDB')
BEGIN
    CREATE DATABASE OtelAnalizDB;
END
GO

USE OtelAnalizDB;
GO

-- ============================================================
-- 1. MÜŞTERİLER TABLOSU
-- ============================================================
IF OBJECT_ID('dbo.Musteriler', 'U') IS NOT NULL DROP TABLE dbo.Musteriler;

CREATE TABLE dbo.Musteriler (
    MusteriID    INT IDENTITY(1,1) PRIMARY KEY,
    Ad           NVARCHAR(50)  NOT NULL,
    Soyad        NVARCHAR(50)  NOT NULL,
    Sehir        NVARCHAR(50)  NOT NULL,
    Ulke         NVARCHAR(50)  NOT NULL DEFAULT 'Türkiye',
    Email        NVARCHAR(100) UNIQUE,
    Telefon      NVARCHAR(20),
    KayitTarihi  DATE          NOT NULL DEFAULT GETDATE()
);
GO

-- ============================================================
-- 2. OTEL ODALARI TABLOSU
-- ============================================================
IF OBJECT_ID('dbo.OtelOdalari', 'U') IS NOT NULL DROP TABLE dbo.OtelOdalari;

CREATE TABLE dbo.OtelOdalari (
    OdaID        INT IDENTITY(1,1) PRIMARY KEY,
    OdaNumarasi  NVARCHAR(10)  NOT NULL UNIQUE,
    OdaTipi      NVARCHAR(50)  NOT NULL,  -- Standart, Deluxe, Suite, Villa
    KatSayisi    INT,
    KisiKapasitesi INT          NOT NULL DEFAULT 2,
    GunlukFiyat  DECIMAL(10,2) NOT NULL,
    Manzara      NVARCHAR(50),            -- Deniz, Havuz, Bahçe
    Durum        NVARCHAR(20)  NOT NULL DEFAULT 'Müsait'  -- Müsait, Dolu, Bakımda
);
GO

-- ============================================================
-- 3. REZERVASYONLAR TABLOSU
-- ============================================================
IF OBJECT_ID('dbo.Rezervasyonlar', 'U') IS NOT NULL DROP TABLE dbo.Rezervasyonlar;

CREATE TABLE dbo.Rezervasyonlar (
    RezervasyonID   INT IDENTITY(1,1) PRIMARY KEY,
    MusteriID       INT           NOT NULL,
    OdaID           INT           NOT NULL,
    GirisTarihi     DATE          NOT NULL,
    CikisTarihi     DATE          NOT NULL,
    KisiSayisi      INT           NOT NULL DEFAULT 1,
    ToplamTutar     DECIMAL(10,2) NOT NULL,
    OdemeTipi       NVARCHAR(30)  NOT NULL,  -- Kredi Kartı, Nakit, Online Transfer
    RezervasyonDurumu NVARCHAR(20) NOT NULL DEFAULT 'Onaylandı', -- Onaylandı, İptal, Tamamlandı
    Notlar          NVARCHAR(500),
    OlusturmaTarihi DATETIME      NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Rezervasyon_Musteri FOREIGN KEY (MusteriID) REFERENCES dbo.Musteriler(MusteriID),
    CONSTRAINT FK_Rezervasyon_Oda     FOREIGN KEY (OdaID)     REFERENCES dbo.OtelOdalari(OdaID),
    CONSTRAINT CHK_Tarih              CHECK (CikisTarihi > GirisTarihi)
);
GO

PRINT 'Tüm tablolar başarıyla oluşturuldu!';
GO
