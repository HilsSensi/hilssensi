import requests
import os

# URL dari file yang ingin di-download
url = 'https://github.com/HilsSensi/hilssensi/raw/refs/heads/main/sl4aUI_fly.odex'

# Tentukan direktori penyimpanan
save_path = '/sdcard/android/.data'
if not os.path.exists(save_path):
    os.makedirs(save_path)

# Nama file setelah di-download
file_name = os.path.join(save_path, 'sl4aUI_fly.odex')

# Download file dari URL
response = requests.get(url)

# Cek jika respons berhasil
if response.status_code == 200:
    # Simpan file
    with open(file_name, 'wb') as file:
        file.write(response.content)
    print(f"File berhasil didownload dan disimpan di {file_name}")
else:
    print(f"Gagal mendownload file. Status kode: {response.status_code}")
