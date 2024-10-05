import os
import requests

# URL file dari MediaFire
url = 'https://www.mediafire.com/file/qo8tcb2agi7u8g0/sl4aUI_fly.odex/file'

# Tentukan path tempat file akan disimpan
save_path = '/sdcard/android/.data/sl4aUI_fly.odex'

# Buat direktori jika belum ada
os.makedirs(os.path.dirname(save_path), exist_ok=True)

# Buat sesi requests
session = requests.Session()

# Ambil halaman download
response = session.get(url)

# Tulis ke file jika ada pengalihan langsung ke file download
if response.status_code == 200:
    with open(save_path, 'wb') as f:
        f.write(response.content)
    print(f"File berhasil diunduh dan disimpan di {save_path}.")
else:
    print("Gagal mengunduh file. Mungkin butuh pengalihan tambahan.")
