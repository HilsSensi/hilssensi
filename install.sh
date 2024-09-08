$AXFUN
printf() {
  echo "$1"
}
animate_typing() {
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
echo ""
sleep 1
echo ""
sleep 0.5 && echo
animate_typing "- Developer : @hils" 31
animate_typing "- Version : v1.0 HighSensi " 31
sleep 0.3 
echo "
┏┓╋╋╋╋╋┏┓
┃┃╋╋╋╋╋┃┃
┃┗━┳┳━━┫┗━┓╋╋┏━━┳━━┳━┓┏━━┳┓
┃┏┓┣┫┏┓┃┏┓┣━━┫━━┫┃━┫┏┓┫━━╋┫
┃┃┃┃┃┗┛┃┃┃┣━━╋━━┃┃━┫┃┃┣━━┃┃
┗┛┗┻┻━┓┣┛┗┛╋╋┗━━┻━━┻┛┗┻━━┻┛
╋╋╋╋┏━┛┃
╋╋╋╋┗━━┛"
sleep 1
animate_typing "proses install" 31
sleep 1.5

set_priorities() {
    pid="$1"
    nice -n -5 -p "$pid" > /dev/null 2>&1
    ionice -c 1 -n 0 -p "$pid" > /dev/null 2>&1
    renice -n -1 -p "$pid" > /dev/null 2>&1
    iorenice "$pid" 1 0 > /dev/null 2>&1
}

path_remove() {
    dir_path="$1"
    if [ ! -d "$dir_path" ]; then
        return
    fi

    for entry in "$dir_path"/*; do
        [ -e "$entry" ] || continue
        if [ "$entry" = "$dir_path/." ] || [ "$entry" = "$dir_path/.." ]; then
            continue
        fi
        rm -f "$entry"
    done
}

change_resolution_and_density() {
    wm size 1296x2796 # Change to desired resolution
    wm density 528   # Change to desired density (e.g., 320)
}

restore_resolution_and_density() {
    wm size reset    # Restore original resolution
    wm density reset # Restore original density
}

main() {
    prev_window_state=""
    game_running=""
    original_resolution=$(wm size | grep -oP '\d+x\d+') # Save original resolution
    original_density=$(wm density | grep -oP '\d+')     # Save original density

    cmd notification post -S bigtext -t "HS - VIP" "Tag" "By:Hilss Version:1.0"

    while :; do
        clear
        
        exec > /dev/null 2>&1

        buffer=$(dumpsys window | grep -E 'mCurrentFocus|mFocusedApp' | grep -Eo "com.dts.freefireth|com.dts.freefiremax")

        if [ -n "$buffer" ]; then
            if [ "$prev_window_state" != "active" ]; then
                game_running="open"
                am broadcast -a axeron.show.TOAST --es title "HS-VIP" --es msg "HIGHSETTINGS ACTIVED" --ei duration "4000"
                sleep 6

                cmd power set-fixed-performance-mode-enabled true
                appops set com.lemon.lvoverseas POST_NOTIFICATION deny

                pgrep -f "com.dts.freefireth|com.dts.freefiremax" | while read -r pid; do
                    set_priorities "$pid"
                    sleep 1
                done

                change_resolution_and_density # Change screen resolution and density

                am broadcast -a axeron.show.TOAST --es title "HS-VIP" --es msg "SUCCESSFULLY HIGHSETTINGS"
            fi
            prev_window_state="active"
        else
            if [ "$game_running" = "open" ]; then
                game_running=""
                am broadcast -a axeron.show.TOAST --es title "HS-VIP" --es msg "HIGHSETTINGS CLOSED" --ei duration "2000"
                cmd power set-fixed-performance-mode-enabled false
                appops set com.lemon.lvoverseas POST_NOTIFICATION allow deny

                restore_resolution_and_density # Restore original resolution and density
            fi
            prev_window_state=""
        fi

        sleep 5
    done
}
animate_typing "install succes" 31
main

