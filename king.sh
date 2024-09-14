#!/system/bin/sh
if [ "$(basename "$0")" != "king64" ]; then
	exit 1
fi

source /data/local/tmp/hxfun

t_priorities() {
 pid="$1"
	cmd="pgrep -f '$pid'"
	pids=$(eval "$cmd")

    for p in $pids; do
    cmd="/proc/$p/task/"
    if [ -d "$cmd" ]; then
        for task_id in "$cmd"*/; do
            task_id=$(basename "$task_id")
            if [ "$task_id" != "." ] && [ "$task_id" != ".." ]; then
                renice -n -20 -p "$task_id"
                ionice -c 1 -n 0 -p "$task_id"
                chrt -f -p 99 "$task_id"
            fi
        done
    fi
done
}
RemoveListerOne() {
    device_config delete game_overlay
    wm size reset
    wm density reset
}
sensivityOne() {
    wm density reset
    sleep 0.1
settings put global force_gpu_rendering 1
settings put system touch_sensitivity 1 enabled_hardware_optimization 1
settings put system enabled_ui_optimization 1
settings put system status_bar_animations_duration_scale 0.5
settings put system navigation_bar_animations_duration_scale 0.5
settings put system power_menu_expanded_ 130
settings put system touch_deley 0.1
settings put system tap_timeout 100 
settings put system long_press_timeout 300  
settings put system gpu_render_policy 1
settings put system bg_apps_limit 4
settings put system hardware_rendering_enabled 1
settings put system notification_slide_animations_duration 0.30
settings put system app_close_animated 0.15
settings put global window_animation_scale 0.5
settings put global transition_animation_scale 0.5
settings put global animator_duration_scale 0.5

settings put system pointer_speed 10
settings put system touchpanel_edge_filter 0
echo 0 > /sys/devices/virtual/input/input1/wake_gesture
echo 1 > /sys/class/kgsl/kgsl-3d0/bus_split
    device_config put game_overlay com.dts.freefireth fps=120
    device_config put game_overlay com.dts.freefiremax fps=120
}

exec 1>/dev/null
exec 2>/dev/null

prev_window_state=""
game_running=""

cmd="cmd notification post -S bigtext -t \"FreeFireScript\" \"Tag\" \"Version: HighY | Author: Xhils\""
eval "$cmd"

while true; do
	window_buffer=$(dumpsys window | grep -E 'mCurrentFocus|mFocusedApp' | grep -Eo 'com.dts.freefireth|com.dts.freefiremax')

	if [ -n "$window_buffer" ]; then
		if [ "$prev_window_state" != "active" ]; then
			game_running="open"
			sensivityOne
			wm density "$size"

			cmd="cmd notification post -S bigtext -t \"FreeFireScript\" \"Tag\" \"Process injecting something\""
			eval "$cmd"
			sleep 2

			cmd="pgrep -f 'com.dts.freefireth|com.dts.freefiremax'"
			pids=$(eval "$cmd")

			for pid in $pids; do
				t_priorities "$pid"
				sleep 0.7
			done

			cmd="cmd notification post -S bigtext -t \"FreeFireScript\" \"Tag\" \"Successfully Inject mode\""
			eval "$cmd"

		fi
		prev_window_state="active"
	else
		if [ "$game_running" = "open" ]; then
		
			proc_buffer=$(pgrep -f 'com.dts.freefireth|com.dts.freefiremax')

			if [ -z "$proc_buffer" ]; then
				game_running=""
				cmd="cmd notification post -S bigtext -t \"FreeFireScript\" \"Tag\" \"Game Closed\""
				eval "$cmd"
                                sleep 1 
				RemoveListerOne
			fi
		fi
		prev_window_state=""
	fi
	sleep 5
done
