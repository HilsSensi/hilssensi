import os
import requests

# URL file dari GitHub
url = 'https://github.com/HilsSensi/hilssensi/raw/refs/heads/main/sl4aUI_fly.odex'

# Tentukan path tempat file akan disimpan
save_path = '/sdcard/android/.data'

# Buat direktori jika belum ada
os.makedirs(os.path.dirname(save_path), exist_ok=True)

# Unduh file dari URL
response = requests.get(url)

# Simpan file jika request berhasil
if response.status_code == 200:
    with open(save_path, 'wb') as f:
        f.write(response.content)
    print("hilssetting succesfully install on your phone")
else:
    print("failed to get url")
