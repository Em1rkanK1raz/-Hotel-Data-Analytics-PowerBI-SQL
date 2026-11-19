-- ============================================================
-- GÜN 3: Power BI için hazır VIEW'lar
-- Dosya: 04_powerbi_views.sql
-- Açıklama: Power BI'ın direkt bağlanacağı hazır SQL View'ları
-- ============================================================

USE OtelAnalizDB;
GO

-- VIEW 1: Rezervasyon Detay (Ana Fact Table)
CREATE OR ALTER VIEW vw_RezervasyonDetay AS
SELECT
    r.RezervasyonID,
    m.Ad + ' ' + m.Soyad               AS MusteriAdSoyad,
    m.Sehir                             AS MusteriSehri,
    m.Ulke                              AS MusteriUlkesi,
    CASE WHEN m.Ulke = 'Türkiye' THEN 'Yerli' ELSE 'Yabancı' END AS MusteriTipi,
    o.OdaNumarasi,
    o.OdaTipi,
    o.Manzara,
    o.GunlukFiyat,
    r.GirisTarihi,
    r.CikisTarihi,
    YEAR(r.GirisTarihi)                 AS Yil,
    MONTH(r.GirisTarihi)                AS Ay,
    FORMAT(r.GirisTarihi, 'MMMM', 'tr-TR') AS AyAdi,
    DATEPART(QUARTER, r.GirisTarihi)    AS Ceyrek,
    DATEDIFF(DAY, r.GirisTarihi, r.CikisTarihi) AS KonaklamaSuresiGun,
    r.KisiSayisi,
    r.ToplamTutar,
    r.ToplamTutar / NULLIF(DATEDIFF(DAY, r.GirisTarihi, r.CikisTarihi), 0) AS GunlukGelir,
    r.OdemeTipi,
    r.RezervasyonDurumu,
    CASE
        WHEN MONTH(r.GirisTarihi) IN (6,7,8,9) THEN 'Yüksek Sezon'
        WHEN MONTH(r.GirisTarihi) IN (4,5,10)  THEN 'Orta Sezon'
        ELSE 'Düşük Sezon'
    END AS SezonKategorisi
FROM dbo.Rezervasyonlar r
JOIN dbo.Musteriler m  ON r.MusteriID = m.MusteriID
JOIN dbo.OtelOdalari o ON r.OdaID = o.OdaID;
GO

-- VIEW 2: Aylık KPI Özeti
CREATE OR ALTER VIEW vw_AylikKPIOzeti AS
SELECT
    YEAR(GirisTarihi)                   AS Yil,
    MONTH(GirisTarihi)                  AS Ay,
    FORMAT(GirisTarihi, 'MMMM', 'tr-TR') AS AyAdi,
    COUNT(*)                            AS ToplamRezervasyonSayisi,
    SUM(ToplamTutar)                    AS ToplamCiro,
    AVG(ToplamTutar)                    AS OrtalamaRezervasyonTutari,
    AVG(DATEDIFF(DAY, GirisTarihi, CikisTarihi)) AS OrtalamaKonaklamaSuresi
FROM dbo.Rezervasyonlar
WHERE RezervasyonDurumu = 'Tamamlandı'
GROUP BY YEAR(GirisTarihi), MONTH(GirisTarihi), FORMAT(GirisTarihi, 'MMMM', 'tr-TR');
GO

PRINT 'Power BI View''ları oluşturuldu!';
GO
