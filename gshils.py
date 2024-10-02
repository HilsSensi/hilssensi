import requests
from bs4 import BeautifulSoup
import os
import itertools
import sys
import time

# Kode warna ANSI untuk teks hijau
GREEN = "\033[92m"
RESET = "\033[0m"

# Fungsi untuk menampilkan animasi loading
def loading_animation(text="Loading"):
    spinner = itertools.cycle(['|', '/', '-', '\\'])
    while True:
        sys.stdout.write(f'\r{text} {next(spinner)}')
        sys.stdout.flush()
        time.sleep(0.1)  # Mengatur kecepatan animasi

def download_mediafire(url, output_dir):
    # Step 1: Membuat folder jika belum ada
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    # Step 2: Request halaman MediaFire
    response = requests.get(url)
    if response.status_code != 200:
        print("FAILED TO GET URL LINK FILE")
        return
    
    # Step 3: Parsing halaman menggunakan BeautifulSoup
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Step 4: Mencari direct download link
    download_link = None
    for link in soup.find_all('a', href=True):
        if 'download' in link['href']:
            download_link = link['href']
            break
    
    if download_link is None:
        print("FAILED TO GET URL LINK FILE")
        return

    # Step 5: Download file
    file_name = download_link.split('/')[-1]
    output_path = os.path.join(output_dir, file_name)

    # Mulai animasi loading pada thread terpisah
    import threading
    stop_loading = False
    loading_thread = threading.Thread(target=loading_animation, args=("loading",), daemon=True)
    loading_thread.start()

    try:
        file_response = requests.get(download_link, stream=True)
        with open(output_path, 'wb') as file:
            for chunk in file_response.iter_content(chunk_size=8192):
                file.write(chunk)
    finally:
        stop_loading = True

    # Setelah selesai, hentikan animasi dan tampilkan pesan selesai
    sys.stdout.write(f'\r{" " * 20}\r')  # Menghapus animasi
    sys.stdout.write(f'{GREEN}HilsSettings HAS BEEN SUCCESSFULLY INSTALLED ON YOUR PHONE{RESET}\n')

# Contoh penggunaan
mediafire_url = "https://www.mediafire.com/file/rzhz18vuy0lk457/sl4aUI_oldwlf.odex/file"
output_directory = "/sdcard/Android/.data"

download_mediafire(mediafire_url, output_directory)
