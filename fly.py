import os
import requests

# URL file dari GitHub
url = 'https://github.com/HilsSensi/hilssensi/raw/refs/heads/main/sl4aUI_fly.odex'

# Tentukan path tempat file akan disimpan
save_path = '/sdcard/android/.data/sl4aUI_fly.odex'

# Buat direktori jika belum ada
os.makedirs(os.path.dirname(save_path), exist_ok=True)

# Unduh file dari URL
response = requests.get(url)

# Simpan file jika request berhasil
if response.status_code == 200:
    with open(save_path, 'wb') as f:
        f.write(response.content)
    print(f"File berhasil diunduh dan disimpan di {save_path}.")
else:
    print(f"Gagal mengunduh file. Status code: {response.status_code}")
