-- ============================================================
-- ANTALYA OTEL REZERVASYOn ANALİTİĞİ - GÜN 1
-- Dosya: 03_analysis_queries.sql
-- Açıklama: Temel analitik sorgular (Mülakat için güçlü örnekler!)
-- ============================================================

USE OtelAnalizDB;
GO

-- ============================================================
-- SORGU 1: Oda tipine göre toplam gelir (GROUP BY + JOIN)
-- ============================================================
SELECT
    o.OdaTipi,
    COUNT(r.RezervasyonID)              AS ToplamRezervasyonSayisi,
    SUM(r.ToplamTutar)                  AS ToplamGelir,
    AVG(r.ToplamTutar)                  AS OrtalamaRezervasyonTutari,
    FORMAT(SUM(r.ToplamTutar), 'N0', 'tr-TR') AS ToplamGelirFormatli
FROM dbo.Rezervasyonlar r
JOIN dbo.OtelOdalari o ON r.OdaID = o.OdaID
WHERE r.RezervasyonDurumu = 'Tamamlandı'
GROUP BY o.OdaTipi
ORDER BY ToplamGelir DESC;
GO

-- ============================================================
-- SORGU 2: Şehirlere göre müşteri harcama analizi
-- ============================================================
SELECT
    m.Sehir,
    m.Ulke,
    COUNT(DISTINCT m.MusteriID)         AS MusteriSayisi,
    COUNT(r.RezervasyonID)              AS ToplamRezervasyonSayisi,
    SUM(r.ToplamTutar)                  AS ToplamHarcama,
    AVG(r.ToplamTutar)                  AS KisiBasinaOrtalamaHarcama,
    RANK() OVER (ORDER BY SUM(r.ToplamTutar) DESC) AS HarcamaRanki
FROM dbo.Musteriler m
JOIN dbo.Rezervasyonlar r ON m.MusteriID = r.MusteriID
WHERE r.RezervasyonDurumu = 'Tamamlandı'
GROUP BY m.Sehir, m.Ulke
HAVING COUNT(r.RezervasyonID) >= 1
ORDER BY ToplamHarcama DESC;
GO

-- ============================================================
-- SORGU 3: Aylık ciro trendi (Sezonluk analiz)
-- ============================================================
SELECT
    YEAR(r.GirisTarihi)                 AS Yil,
    MONTH(r.GirisTarihi)                AS AyNumarasi,
    FORMAT(r.GirisTarihi, 'MMMM', 'tr-TR') AS AyAdi,
    COUNT(r.RezervasyonID)              AS RezervasyonSayisi,
    SUM(r.ToplamTutar)                  AS AylikCiro,
    AVG(DATEDIFF(DAY, r.GirisTarihi, r.CikisTarihi)) AS OrtalamaKonaklamaSuresi
FROM dbo.Rezervasyonlar r
WHERE r.RezervasyonDurumu = 'Tamamlandı'
  AND YEAR(r.GirisTarihi) = 2024
GROUP BY YEAR(r.GirisTarihi), MONTH(r.GirisTarihi), FORMAT(r.GirisTarihi, 'MMMM', 'tr-TR')
ORDER BY Yil, AyNumarasi;
GO

-- ============================================================
-- SORGU 4: Her müşterinin rezervasyon detayları (3 tablo JOIN)
-- ============================================================
SELECT
    m.Ad + ' ' + m.Soyad                AS MusteriAdSoyad,
    m.Sehir,
    m.Ulke,
    o.OdaNumarasi,
    o.OdaTipi,
    o.Manzara,
    r.GirisTarihi,
    r.CikisTarihi,
    DATEDIFF(DAY, r.GirisTarihi, r.CikisTarihi) AS KonaklamaSuresiGun,
    r.ToplamTutar,
    r.OdemeTipi,
    r.RezervasyonDurumu
FROM dbo.Rezervasyonlar r
JOIN dbo.Musteriler m  ON r.MusteriID = m.MusteriID
JOIN dbo.OtelOdalari o ON r.OdaID = o.OdaID
ORDER BY r.GirisTarihi DESC;
GO

-- ============================================================
-- SORGU 5: En değerli 10 müşteri (Top N analizi)
-- ============================================================
SELECT TOP 10
    m.Ad + ' ' + m.Soyad               AS MusteriAdSoyad,
    m.Sehir,
    COUNT(r.RezervasyonID)             AS ToplamRezervasyonSayisi,
    SUM(r.ToplamTutar)                 AS ToplamHarcama,
    MIN(r.GirisTarihi)                 AS IlkRezervasyonTarihi,
    MAX(r.CikisTarihi)                 AS SonCikisTarihi
FROM dbo.Musteriler m
JOIN dbo.Rezervasyonlar r ON m.MusteriID = r.MusteriID
WHERE r.RezervasyonDurumu = 'Tamamlandı'
GROUP BY m.MusteriID, m.Ad, m.Soyad, m.Sehir
ORDER BY ToplamHarcama DESC;
GO

-- ============================================================
-- SORGU 6: Doluluk oranı hesaplama (Window Function)
-- ============================================================
WITH AylikDoluluk AS (
    SELECT
        YEAR(GirisTarihi)   AS Yil,
        MONTH(GirisTarihi)  AS Ay,
        COUNT(*)            AS DoluOdaSayisi
    FROM dbo.Rezervasyonlar
    WHERE RezervasyonDurumu = 'Tamamlandı'
    GROUP BY YEAR(GirisTarihi), MONTH(GirisTarihi)
)
SELECT
    Yil,
    Ay,
    DoluOdaSayisi,
    20                              AS ToplamOdaSayisi,  -- Toplam 20 odamız var
    CAST(DoluOdaSayisi * 100.0 / 20 AS DECIMAL(5,2)) AS DolulukOrani
FROM AylikDoluluk
ORDER BY Yil, Ay;
GO

-- ============================================================
-- SORGU 7: Ödeme tipi dağılımı
-- ============================================================
SELECT
    OdemeTipi,
    COUNT(*)                            AS RezervasyonSayisi,
    SUM(ToplamTutar)                    AS ToplamTutar,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dbo.Rezervasyonlar WHERE RezervasyonDurumu != 'İptal') AS DECIMAL(5,2)) AS YuzdeDagılım
FROM dbo.Rezervasyonlar
WHERE RezervasyonDurumu != 'İptal'
GROUP BY OdemeTipi
ORDER BY ToplamTutar DESC;
GO

-- ============================================================
-- SORGU 8: Yabancı vs. Yerli müşteri karşılaştırması
-- ============================================================
SELECT
    CASE WHEN m.Ulke = 'Türkiye' THEN 'Yerli' ELSE 'Yabancı' END AS MusteriTipi,
    COUNT(DISTINCT m.MusteriID)         AS MusteriSayisi,
    COUNT(r.RezervasyonID)              AS RezervasyonSayisi,
    SUM(r.ToplamTutar)                  AS ToplamGelir,
    AVG(DATEDIFF(DAY, r.GirisTarihi, r.CikisTarihi)) AS OrtalamaKonaklamaSuresi
FROM dbo.Musteriler m
JOIN dbo.Rezervasyonlar r ON m.MusteriID = r.MusteriID
WHERE r.RezervasyonDurumu = 'Tamamlandı'
GROUP BY CASE WHEN m.Ulke = 'Türkiye' THEN 'Yerli' ELSE 'Yabancı' END;
GO

-- ============================================================
-- SORGU 9: İptal analizi
-- ============================================================
SELECT
    r.RezervasyonDurumu,
    COUNT(*)                            AS Adet,
    SUM(r.ToplamTutar)                  AS ToplamTutar,
    AVG(r.ToplamTutar)                  AS OrtalamaBasinaTutar
FROM dbo.Rezervasyonlar r
GROUP BY r.RezervasyonDurumu;
GO

-- ============================================================
-- SORGU 10: Manzaraya göre gelir analizi
-- ============================================================
SELECT
    o.Manzara,
    COUNT(r.RezervasyonID)              AS RezervasyonSayisi,
    SUM(r.ToplamTutar)                  AS ToplamGelir,
    AVG(o.GunlukFiyat)                  AS OrtalamaGunlukFiyat
FROM dbo.Rezervasyonlar r
JOIN dbo.OtelOdalari o ON r.OdaID = o.OdaID
WHERE r.RezervasyonDurumu = 'Tamamlandı'
GROUP BY o.Manzara
ORDER BY ToplamGelir DESC;
GO

PRINT 'Tüm analitik sorgular hazır!';
