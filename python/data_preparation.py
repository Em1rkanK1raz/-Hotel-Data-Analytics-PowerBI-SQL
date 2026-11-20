"""
========================================================
GÜN 2: Veri Zenginleştirme ve Temizleme (Python)
Dosya: data_preparation.py
Açıklama: Pandas ile veri analizi ve CSV export
========================================================
"""

import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random
import warnings
warnings.filterwarnings('ignore')

# ============================================================
# 1. VERİ ÜRETME (SQL'den çekemediğiniz durum için fallback)
# ============================================================

random.seed(42)
np.random.seed(42)

sehirler_tr = ['İstanbul', 'Ankara', 'İzmir', 'Bursa', 'Antalya',
                'Konya', 'Adana', 'Gaziantep', 'Samsun', 'Eskişehir']
ulkeler_yabanci = ['Almanya', 'Fransa', 'İngiltere', 'Rusya', 'Polonya', 'İspanya', 'İtalya']
oda_tipleri = ['Standart', 'Deluxe', 'Suite', 'Villa', 'Penthouse']
odeme_tipleri = ['Kredi Kartı', 'Nakit', 'Online Transfer']
durumlar = ['Tamamlandı', 'Tamamlandı', 'Tamamlandı', 'Tamamlandı', 'İptal']  # %80 tamamlandı

# Fiyat aralıkları
fiyat_map = {
    'Standart': (950, 1400),
    'Deluxe':   (2200, 2800),
    'Suite':    (4500, 5500),
    'Villa':    (12000, 15000),
    'Penthouse':(8000, 9500)
}

# ============================================================
# 2. REZERVASYON VERİSİ ÜRETME
# ============================================================

records = []
baslangic = datetime(2024, 1, 1)
bitis = datetime(2024, 12, 31)

for i in range(100):
    oda_tipi = random.choice(oda_tipleri)
    gunluk_fiyat = random.randint(*fiyat_map[oda_tipi])

    # Sezona göre giriş tarihi ağırlıklandırma
    # Yaz aylarında daha fazla rezervasyon
    ay_agirliklari = [0.03, 0.04, 0.05, 0.08, 0.10, 0.14, 0.18, 0.17, 0.12, 0.05, 0.02, 0.02]
    ay = random.choices(range(1, 13), weights=ay_agirliklari)[0]
    gun = random.randint(1, 28)
    giris = datetime(2024, ay, gun)

    konaklama = random.choices(
        [1, 2, 3, 4, 5, 6, 7, 10, 14],
        weights=[5, 10, 15, 20, 20, 10, 10, 5, 5]
    )[0]
    cikis = giris + timedelta(days=konaklama)

    if cikis.year > 2024:
        cikis = datetime(2024, 12, 31)
        konaklama = (cikis - giris).days

    yerli_mi = random.random() < 0.6  # %60 yerli müşteri
    if yerli_mi:
        sehir = random.choice(sehirler_tr)
        ulke = 'Türkiye'
    else:
        sehir = random.choice(['Berlin', 'Paris', 'Londra', 'Moskova', 'Varşova', 'Madrid', 'Roma'])
        ulke = random.choice(ulkeler_yabanci)

    tutar = gunluk_fiyat * konaklama
    durum = random.choice(durumlar)

    records.append({
        'rezervasyon_id': i + 1,
        'musteri_sehir': sehir,
        'musteri_ulke': ulke,
        'musteri_tipi': 'Yerli' if yerli_mi else 'Yabancı',
        'oda_tipi': oda_tipi,
        'gunluk_fiyat': gunluk_fiyat,
        'giris_tarihi': giris.strftime('%Y-%m-%d'),
        'cikis_tarihi': cikis.strftime('%Y-%m-%d'),
        'konaklama_gun': konaklama,
        'toplam_tutar': tutar,
        'odeme_tipi': random.choice(odeme_tipleri),
        'durum': durum,
        'ay': ay,
        'ay_adi': giris.strftime('%B'),
        'ceyrek': f"Q{(ay-1)//3 + 1}",
        'sezon': ('Yüksek Sezon' if ay in [6,7,8,9]
                  else 'Orta Sezon' if ay in [4,5,10]
                  else 'Düşük Sezon')
    })

df = pd.DataFrame(records)

# ============================================================
# 3. VERİ TEMİZLEME VE DOĞRULAMA
# ============================================================

print("=" * 50)
print("VERİ KALİTE RAPORU")
print("=" * 50)
print(f"Toplam Kayıt: {len(df)}")
print(f"Eksik Değer:\n{df.isnull().sum()}")
print(f"\nTamamlanan Rezervasyonlar: {(df['durum'] == 'Tamamlandı').sum()}")
print(f"İptal Edilen Rezervasyonlar: {(df['durum'] == 'İptal').sum()}")

# Tarih sütunlarını datetime'a çevir
df['giris_tarihi'] = pd.to_datetime(df['giris_tarihi'])
df['cikis_tarihi'] = pd.to_datetime(df['cikis_tarihi'])

# ============================================================
# 4. ANALİTİK ÖZETLER
# ============================================================

print("\n" + "=" * 50)
print("ODA TİPİNE GÖRE GELİR ANALİZİ")
print("=" * 50)
ozet = df[df['durum'] == 'Tamamlandı'].groupby('oda_tipi').agg(
    rezervasyon_sayisi=('rezervasyon_id', 'count'),
    toplam_gelir=('toplam_tutar', 'sum'),
    ortalama_tutar=('toplam_tutar', 'mean')
).sort_values('toplam_gelir', ascending=False)
print(ozet.to_string())

print("\n" + "=" * 50)
print("AYLIK CİRO TRENDİ")
print("=" * 50)
aylik = df[df['durum'] == 'Tamamlandı'].groupby('ay').agg(
    rezervasyon=('rezervasyon_id', 'count'),
    ciro=('toplam_tutar', 'sum')
).sort_index()
print(aylik.to_string())

print("\n" + "=" * 50)
print("YERLİ vs. YABANCI KARŞILAŞTIRMA")
print("=" * 50)
musteri_karsilastirma = df[df['durum'] == 'Tamamlandı'].groupby('musteri_tipi').agg(
    rezervasyon=('rezervasyon_id', 'count'),
    toplam_harcama=('toplam_tutar', 'sum'),
    ortalama_harcama=('toplam_tutar', 'mean'),
    ort_konaklama_gun=('konaklama_gun', 'mean')
)
print(musteri_karsilastirma.to_string())

# ============================================================
# 5. CSV EXPORT (Power BI için hazır)
# ============================================================

df_tamamlandi = df[df['durum'] == 'Tamamlandı'].copy()
df_tamamlandi.to_csv('rezervasyonlar_temiz.csv', index=False, encoding='utf-8-sig')
print("\n✅ 'rezervasyonlar_temiz.csv' dosyası oluşturuldu!")
print("   Power BI 'Veri Al > CSV' ile bu dosyayı da içeri alabilirsin.")

print("\n✅ Veri hazırlama tamamlandı!")
