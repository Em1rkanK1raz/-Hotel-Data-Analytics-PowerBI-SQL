import pandas as pd
import numpy as np

df_rez = pd.read_csv('python/rezervasyonlar.csv', sep=';')
df_mus = pd.read_csv('python/musteriler.csv', sep=';')   
df_oda = pd.read_csv('python/otelodalari.csv', sep=';')

print("--- REZERVASYONLAR TABLOSU İLK 5 SATIR ---")
print(df_rez.head())
print("\n--- TABLONUN RÖNTGENİ (INFO) ---")
print(df_rez.info())

print("--- MÜŞTERİLER TABLOSU İLK 5 SATIR ---")
print(df_mus.head())
print("\n--- TABLONUN RÖNTGENİ (INFO) ---")
print(df_mus.info())

print("--- OTEL ODALARI TABLOSU İLK 5 SATIR ---")
print(df_oda.head())
print("\n--- TABLONUN RÖNTGENİ (INFO) ---")
print(df_oda.info())


print("\n" + "="*40)
print("1. EKSİK VERİ RAPORU (MÜŞTERİLER)")
print("="*40)
print(df_mus.isnull().sum())

print("\n" + "="*40)
print("2. EKSİK VERİ RAPORU (REZERVASYONLAR)")
print("="*40)
print(df_rez.isnull().sum())

print("\n" + "="*40)
print("3. EKSİK VERİ RAPORU (OTEL ODALARI)")
print("="*40)
print(df_oda.isnull().sum())


df_rez['GirisTarihi'] = pd.to_datetime(df_rez['GirisTarihi'])
df_rez['CikisTarihi'] = pd.to_datetime(df_rez["CikisTarihi"])

df_rez['KonaklamaSuresi'] = df_rez["CikisTarihi"] - df_rez['GirisTarihi']

df_rez['GirisAyi'] = df_rez['GirisTarihi'].dt.month

print("\n--- HESAPLANAN YENİ SÜTUNLARLA İLK 5 REZERVASYON ---")
print(df_rez[['GirisTarihi', 'CikisTarihi', 'KonaklamaSuresi', 'GirisAyi', 'ToplamTutar']].head())


df_genel = pd.merge(df_rez ,df_oda, on='OdaID')
df_genel = pd.merge(df_genel, df_mus, on='MusteriID')

df_genel['MusteriTipi'] = np.where(df_genel['Ulke'] == 'Türkiye', 'Yerli', 'Yabancı')

def sezon_aylari(ay):
    if ay in [12, 1, 2]:
        return 'Kış'
    elif ay in [3, 4, 5]:
        return 'İlkbahar'
    elif ay in [6, 7, 8]:
        return 'Yaz'
    else:
        return 'Sonbahar'

df_genel['Sezon'] = df_genel['GirisAyi'].apply(sezon_aylari)

df_tamamlanan = df_genel[df_genel['RezervasyonDurumu'] == 'Tamamlandı']

mevsim_cirolari = df_tamamlanan.groupby('Sezon')['ToplamTutar'].sum().sort_values(ascending=False)

print("\n" + "="*45)
print("MEVSİMLERE GÖRE TOPLAM CİRO DAĞILIMI")
print("="*45)
print(mevsim_cirolari)

df_genel.to_csv('python/otel_analiz_temiz.csv', index=False, encoding='utf-8-sig', sep=';')
print("\n 'otel_analiz_temiz.csv' dosyası başarıyla kaydedildi!")