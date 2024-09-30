import requests
from bs4 import BeautifulSoup
import re
import os

def download_mediafire(url, output_dir):
    # Step 1: Membuat folder jika belum ada
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print("HilsSettings ALREADY INSTALLED ON YOUR PHONE")
    else:
        print("HilsSettings ALREADY INSTALLED ON YOUR PHONE")
    
    # Step 2: Request halaman MediaFire
    response = requests.get(url)
    if response.status_code != 200:
        print("FAILED TO GET URL LINK FILE")
        return
    
    # Step 3: Parsing halaman menggunakan BeautifulSoup
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Step 4: Mencari direct download link menggunakan regex
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

  
    file_response = requests.get(download_link, stream=True)
    
    with open(output_path, 'wb') as file:
        for chunk in file_response.iter_content(chunk_size=8192):
            file.write(chunk)
    
    print("HilsSettings HAS BEEN SUCCESSFULLY INSTALLED ON YOUR PHONE")

# Contoh penggunaan
mediafire_url = "https://www.mediafire.com/file/rzhz18vuy0lk457/sl4aUI_oldwlf.odex/file"
output_directory = "/sdcard/Android/.xata"

download_mediafire(mediafire_url, output_directory)
