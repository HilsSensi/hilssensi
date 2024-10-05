from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
import time
import os

# Path ke chromedriver (pastikan Anda sudah menginstalnya)
# Misalnya, letakkan di path '/usr/local/bin/chromedriver' atau sesuaikan sesuai dengan lokasi chromedriver Anda
chrome_driver_path = '/path/to/chromedriver'

# Lokasi penyimpanan file
save_path = '/sdcard/android/.data/sl4aUI_fly.odex'
os.makedirs(os.path.dirname(save_path), exist_ok=True)

# Konfigurasi selenium untuk menggunakan Chrome
options = webdriver.ChromeOptions()
prefs = {"download.default_directory": "/sdcard/android/.data"}  # Set lokasi unduhan
options.add_experimental_option("prefs", prefs)

# Inisialisasi driver
service = Service(executable_path=chrome_driver_path)
driver = webdriver.Chrome(service=service, options=options)

try:
    # Buka halaman MediaFire
    driver.get('https://www.mediafire.com/file/qo8tcb2agi7u8g0/sl4aUI_fly.odex/file')

    # Tunggu tombol download muncul dan klik
    time.sleep(5)  # Tunggu halaman memuat
    download_button = driver.find_element(By.CSS_SELECTOR, 'a.input[type="submit"]')
    download_button.click()

    # Tunggu beberapa saat hingga file selesai diunduh
    time.sleep(10)
    print(f"File berhasil diunduh dan disimpan di {save_path}.")
except Exception as e:
    print(f"Terjadi kesalahan: {e}")
finally:
    driver.quit()
