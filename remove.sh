$AXFUN
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
  local pathking="/data/local/tmp/king64"
  local pathfozx="/data/local/tmp/fozx64"
  local pathgtrx="/data/local/tmp/gtrx64"
  local sizeath="/data/local/tmp/hxfun"
  ORANGE='\033[38;2;255;85;3m'
  echo ""
  sleep 1
  echo ""
  echo "
█▀ █▀▀ █▄░█ █▀ █ ▀▄▀   █▀█ █▀▄▀█ █░█
▄█ ██▄ █░▀█ ▄█ █ █░█   █▀▄ █░▀░█ ▀▄▀"
  echo ""
  sleep 0.8 && echo
  printer "- Version : v11 Remove ( Uninstaller )"
  sleep 0.5
  printer "- Developer : @Henpeex"
  echo 
  echo 
  sleep 1
  echo "${ORANGE}all scripts stop automatically :${END} successfully "
  echo
  echo
  settings_output() {
    pkill -f king64
    pkill -f gtrx64
    pkill -f fozx64
    wm size reset 
    wm density reset
    settings put secure multi_press_timeout 400
    settings put secure long_press_timeout 400 
    settings delete put global force_gpu_rendering 1
settings delete put system touch_sensitivity 1 enabled_hardware_optimization 1
settings delete put system enabled_ui_optimization 1
settings delete put system status_bar_animations_duration_scale 0.5
settings delete put system navigation_bar_animations_duration_scale 0.5
settings delete put system power_menu_expanded_ 130
settings delete put system touch_deley 0.1
settings delete put system tap_timeout 100 
settings delete put system long_press_timeout 300  
settings delete put system gpu_render_policy 1
settings delete put system bg_apps_limit 4
settings delete put system hardware_rendering_enabled 1
settings delete put system notification_slide_animations_duration 0.30
settings delete put system app_close_animated 0.15
settings delete put global window_animation_scale 0.5
settings delete put global transition_animation_scale 0.5
settings delete put global animator_duration_scale 0.5

settings put system pointer_speed 1
settings delete put system touchpanel_edge_filter 0
    rm $sizeath
    rm $pathking
    rm $pathfozx
    rm $pathgtrx
    cmd notification post -S bigtext -t 'SENSIXPRO+' 'Tag' 'Remove Berhasil ( jika mau main lagi silahkan aktifin sensix terlebih dahulu )'
  }
  settings_output >/dev/null 2>&1
