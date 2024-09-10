$AXFUN
if storm "https://henbz10real.github.io/snx11response/ban_list.txt" | grep -iq "$AXERONID"; then
  echo "Device kamu telah dilarang menggunakan sensix"
  exit 1
fi

packages=$(pm list packages | cut -d':' -f2)
excluded_apps="com.dts.freefireth com.dts.freefiremax glip.gg"
pkg=$(echo "$packages" | grep -v -E "$(echo $excluded_apps | sed 's/ /|/g')")

printer() {
	text="$1"
	color="$2"
	i=0
	while [ $i -lt ${#text} ]; do
		echo -en "\e[${color}m${text:$i:1}\e[0m"
		sleep 0.02
		i=$((i + 1))
	done
	echo
}
END='\033[0m'
ORANGE='\033[38;2;255;85;3m'
versi="v11.6.0-(KINGX)"
v_toast="Version : 11.6.0"
t_toast="KINGX - HEADTRICK"
linktree="https://linktr.ee/henvxofficial"
architecture=$(getprop ro.product.cpu.abi)
android_version=$(getprop ro.build.version.release)
if [[ $android_version == 14* ]]; then
	url="r17rYI0tYD6Cp9pPOtlQ2c0rYMzuOEctdEmseIcseHlP29kC0ygsYEKQN5qrJ9frNoqt2Mlt2bmsNWg
sz9irN5eCeEf"
elif [[ $android_version == 13* ]]; then
	url="r17rYI0tYD6Cp9pPOtlQ2c0rYMzuOEctdEmseIcseHlP29kC0ycsbA6DKSJQNWjC3ElvUVotdMqtX9l
t2LmsNWgsz9zrN4mr2clQp5qrR=="
elif [[ $android_version == 12* ]]; then
	url="r17rYI0tYD6Cp9pPOtlQ2c0rYMzuOEctdEmseIcseHlP29kC0ycsbA6DKSJQNWjC3ElvUVotdMqtX9l
t2LmsNWgsz9zrN4mr2clQp5qrR=="
elif [[ $android_version == 11* ]]; then
	url="r17rYI0tYD6Cp9pPOtlQ2c0rYMzuOEctdEmseIcseHlP29kC0ycsbA6DKSJQNWjC3ElvUVotdMqtX9l
t2LmsNWgsz9zrN4mr2clQp5qrR=="
else
	url="r17rYI0tYD6Cp9pPOtlQ2c0rYMzuOEctdEmseIcseHlP29kC0ycsbA6DKSJQNWjC3ElvUVotdMqtX9l
t2LmsNWgsz9zrN4mr2clQqDpCeEf"
fi
local sizePath="/data/local/tmp/hxfun"
local dpi=0
local density=0
local output=false
local bin="/data/local/tmp/"
local path="/data/local/tmp/axeron_cash/sensihnx/"
local responsebin="/data/local/tmp/king64"
local check_id=$(storm "https://raw.githubusercontent.com/HilsSensi/hilssensi/main/kingxid.txt")
local check_vip=$(echo "$check_id" | grep -q "$AXERONID" && echo true || echo false)
if [ $check_vip = true ]; then

if [ $# -eq 0 ]; then
    echo "Penggunaan: ax sensihnx -d <DPI> [opsi]"
    return 0
fi

if [ "$1" = "--dpi" ] || [ "$1" = "-d" ]; then
    if [ -z "$2" ]; then
        echo "Error: Nilai DPI tidak boleh kosong. Silakan masukkan nilai DPI."
        exit 1
    fi
    dpi="$2"
    shift 2
else
    echo "Error: Argumen tidak valid"
    exit 1
fi

# Validasi nilai DPI
if [ "$dpi" -le 370 ] || [ "$dpi" -ge 2000 ]; then
    echo "Warning: Nilai DPI harus lebih besar dari 380 dan kurang dari 2000."
    exit 1
fi

convert=$(echo "scale=0; 287520 / $dpi" | bc)

# Periksa argumen mode
if [ "$1" = "--mode" ] || [ "$1" = "-m" ]; then
    if [ -z "$2" ]; then
        echo "Error: Pilih mode : -m [ balance|performance|extreme ]."
        exit 1
    fi
    mode="$2"
    shift 2
fi

# Proses mode
if [ -n "$mode" ]; then
    case "$mode" in
        "balance")
            echo "Mode: balance"
            ;;
        "performance")
            echo "Mode: performance"
            ;;
        "extreme")
            echo "Mode: extreme"
            ;;
        *)
            echo "Error: Mode tidak dikenali. Gunakan : -m [ balance|performance|extreme ]."
            exit 1
            ;;
    esac
fi

if [ "$1" = "--output" ] || [ "$1" = "-o" ]; then
    output=true
    shift
fi

# Cek output dan arahkan ke file atau tampilkan
if [ "$output" = true ]; then
    echo "DPI: $dpi -> Density Universal: $convert"
else
    echo "size=$convert" >/data/local/tmp/hxfun
fi

	echo ""
	sleep 1
	echo ""
	echo "
█▀ █▀▀ █▄░█ █▀ █ ▀▄▀   █▄▀ █ █▄░█ █▀▀ ▀▄▀
▄█ ██▄ █░▀█ ▄█ █ █░█   █░█ █ █░▀█ █▄█ █░█
"
	echo ""
	sleep 0.8 && echo
	printer "- Version : $versi"
	sleep 0.5
	printer "- DPIset : $dpi"
	sleep 0.5
	printer "- Developer : @Henpeex"
	sleep 0.1
	echo
	echo

	status=$(pgrep -f king64) >/dev/null 2>&1
	if [ ! "$status" ]; then
		storm -rP "$bin" -s "${url}" -fn "king64" "$@"
		nohup sh /data/local/tmp/king64 >/dev/null 2>&1 &
	fi
	sleep 2
	status=$(pgrep -f king64) >/dev/null 2>&1
	if [ "$status" ]; then
		echo "${ORANGE}Programs berhasil terpasang :${END} $architecture"
		rm $responsebin
		am broadcast -a axeron.show.TOAST --es title "$t_toast" --es msg "Developer : henpeex 
$v_toast " --ei duration "4000" >/dev/null 2>&1
	else
		printer "Program failed : $architecture"
		rm $responsebin
		rm -rf $path
	fi
	echo
	echo
	sleep 1
else
	rm -rf $path
	rm $responsebin
	echo
	echo
	echo "Invalid device, ${RED}file rusak ( buy to original script )"
	sleep 2
	echo
	echo
	am start -a android.intent.action.VIEW -d ${linktree} >/dev/null 2>&1
fi
