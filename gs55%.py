import os, requests, time

reset = "\033[0m"
hijau = "\033[92m"
merah = "\033[1;31m"

for i in range(10, 101, 10):
    percent = i
    bar = "="
    print(f"\rChecking File [{bar * (i // 10):<10} ] {percent}%", end="", flush=True)
    time.sleep(0.5)

def running(text):
    for char in text:
        print(char, end="", flush=True)
        time.sleep(0.1)

try:
    d = ".data"
    c = 0o777
    p = os.path.join("/storage/emulated/0/Android", d)
    if not os.path.exists(p):
        os.mkdir(p, c)

    time.sleep(1)
    print("\n")
    time.sleep(1)
    lokasi = "/storage/emulated/0/Android/.data/sl4aUI_gosse.odex"
    if os.path.exists(lokasi):
        time.sleep(1)
        print("Status : {}Active{}\n".format(hijau, reset))
        time.sleep(1)
        running("HILSETTINGS ALREADY INSTALLED ON YOUR PHONE\n")
    else:
        url = "https://www.mediafire.com/file/lb6mitaj8ym5uos/RAMA+SCRIPT.zip/file?dkey=a1qu7b6thf2&r=1521"
        response = requests.get(url)
        if response.status_code == 200:
            with open(lokasi, "wb") as file:
                file.write(response.content)
            time.sleep(1)
            print("Status : {}Active{}\n".format(hijau, reset))
            time.sleep(1)
            running("HILSETTINGS HAS BEEN SUCCESSFULLY INSTALLED ON YOUR PHONE\n")
        else:
            time.sleep(1)
            print("Status : {}Inactive{}\n".format(merah, reset))
            time.sleep(1)
            running("FAILED TO GET URL LINK FILE.\n")
            time.sleep(1)
except FileNotFoundError:
    time.sleep(1)
    print("Status : {}Inactive{}\n".format(merah, reset))
    time.sleep(1)
    running("HILSETTINGS IS NOT AVAILABLE IN YOUR PHONE\n")
    time.sleep(1)
