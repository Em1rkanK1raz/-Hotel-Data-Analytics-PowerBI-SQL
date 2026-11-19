# 🏨 Antalya Otel Rezervasyon ve Sezonluk Ciro Analitiği

> **SQL Server · Power BI · Python · DAX · Data Modeling**

[![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)](https://www.microsoft.com/sql-server)
[![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=Power%20BI&logoColor=black)](https://powerbi.microsoft.com)
[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)

---

## 📌 Proje Özeti

Bu proje, Antalya'da faaliyet gösteren bir otel için **rezervasyon ve ciro verilerini** uçtan uca analiz eden tam kapsamlı bir **Business Intelligence (BI)** çalışmasıdır.

Proje; **SQL Server** üzerinde veritabanı tasarımından **Power BI** yönetici panosuna, **Python** ile veri temizlemeden **DAX** ölçülerine kadar bir Veri Analistinin tüm iş akışını kapsamaktadır.

---

## 🎯 İş Problemleri & Yanıtlanan Sorular

| # | Soru | Teknoloji |
|---|------|-----------|
| 1 | Hangi oda tipinden en fazla gelir elde ediliyor? | SQL · Power BI |
| 2 | Hangi şehirlerden gelen müşteriler daha fazla harcıyor? | SQL · Power BI |
| 3 | Yaz-kış sezonu arasındaki ciro farkı ne kadar? | SQL · DAX |
| 4 | Yabancı müşteri oranı ve harcama alışkanlıkları nedir? | SQL · Python |
| 5 | İptal oranları hangi aylarda daha yüksek? | SQL · Power BI |
| 6 | En değerli 10 müşteri kimler? | SQL (TOP N) |

---

## 🛠️ Kullanılan Teknolojiler

- **SQL Server (SSMS):** Veritabanı tasarımı, DDL/DML, JOIN, GROUP BY, Window Functions, CTE, View
- **Power BI Desktop:** Veri modelleme, ilişki yönetimi, DAX ölçüleri, interaktif dashboard
- **Python (Pandas, NumPy):** Veri üretme, temizleme ve CSV export
- **DAX:** KPI hesaplama, YoY karşılaştırma, koşullu biçimlendirme

---

## 🗂️ Proje Yapısı

```
Hotel-Data-Analytics-PowerBI-SQL/
│
├── sql/
│   ├── 01_create_database.sql     # Tablo şemaları ve kısıtlamalar
│   ├── 02_insert_sample_data.sql  # 30 müşteri, 20 oda, 80+ rezervasyon
│   ├── 03_analysis_queries.sql    # 10 analitik sorgu
│   ├── 04_powerbi_views.sql       # Power BI için hazır SQL View'ları
│   └── 05_dax_measures.txt        # Power BI DAX ölçüleri
│
├── python/
│   └── data_preparation.py        # Pandas ile veri analizi & CSV export
│
├── screenshots/
│   ├── dashboard_overview.png     # Ana dashboard görünümü
│   ├── monthly_trend.png          # Aylık ciro trendi
│   └── schema_diagram.png         # Veritabanı şeması
│
└── README.md
```

---

## 🗄️ Veritabanı Şeması

```
┌─────────────────┐       ┌─────────────────────┐       ┌────────────────────┐
│   Musteriler    │       │    Rezervasyonlar    │       │   OtelOdalari      │
├─────────────────┤       ├─────────────────────┤       ├────────────────────┤
│ MusteriID (PK)  │──┐    │ RezervasyonID (PK)  │  ┌───│ OdaID (PK)         │
│ Ad              │  └───►│ MusteriID (FK)      │  │   │ OdaNumarasi        │
│ Soyad           │       │ OdaID (FK)          │◄─┘   │ OdaTipi            │
│ Sehir           │       │ GirisTarihi         │       │ KisiKapasitesi     │
│ Ulke            │       │ CikisTarihi         │       │ GunlukFiyat        │
│ Email           │       │ ToplamTutar         │       │ Manzara            │
│ Telefon         │       │ OdemeTipi           │       │ Durum              │
│ KayitTarihi     │       │ RezervasyonDurumu   │       └────────────────────┘
└─────────────────┘       └─────────────────────┘
```

---

## 📊 Power BI Dashboard KPI'ları

| Kart | Değer (Örnek) | DAX Ölçüsü |
|------|---------------|------------|
| 💰 Toplam Ciro | 1.847.300 ₺ | `Toplam Ciro` |
| 📋 Toplam Rezervasyon | 72 | `Toplam Rezervasyon` |
| 🏨 Ortalama Konaklama | 6.3 Gün | `Ortalama Konaklama Suresi` |
| ❌ İptal Oranı | %4.7 | `Iptal Orani` |
| 🌍 Yabancı Oran | %40 | `Yabanci Musteri Orani` |

---

## 🚀 Kurulum & Çalıştırma

### 1. SQL Server Kurulumu
```sql
-- SSMS'te sırayla çalıştır:
-- 1) sql/01_create_database.sql
-- 2) sql/02_insert_sample_data.sql
-- 3) sql/03_analysis_queries.sql
-- 4) sql/04_powerbi_views.sql
```

### 2. Python (Opsiyonel)
```bash
pip install pandas numpy
python python/data_preparation.py
```

### 3. Power BI Bağlantısı
1. Power BI Desktop aç → **Veri Al → SQL Server**
2. Sunucu: `localhost` | Veritabanı: `OtelAnalizDB`
3. `vw_RezervasyonDetay` ve `vw_AylikKPIOzeti` view'larını seç
4. `sql/05_dax_measures.txt` içindeki DAX ölçülerini ekle

---

## 👤 Hakkımda

**Em1rkanK1raz** — Teknik Veri Analisti adayı  
SQL · Power BI · Python · Veri Modelleme

> 📫 GitHub: [github.com/Em1rkanK1raz](https://github.com/Em1rkanK1raz)
