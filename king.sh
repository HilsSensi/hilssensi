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
settings delete system peak_refresh_rate
settings delete system user_refresh_rate
settings delete global adaptive_battery_management_enabled
settings delete global force_gpu_rendering
settings delete system pointer_speed
device_config delete battery adaptive_battery_management_enabled
device_config delete performance input_latency_reduction_enabled
settings delete secure location_mode
settings delete global disable_gl_renderer
settings delete global collect_stats
device_config put performance input_latency_reduction_enabled true
cmd thermalservice override-status 1
}
sensivityOne() {
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
settings put system pointer_speed 7
settings put system touchpanel_edge_filter 0
settings put global disable_gl_renderer 1
settings put global collect_stats 0
cmd thermalservice override-status 0
settings put secure location_mode 0
device_config put battery adaptive_battery_management_enabled false
settings put system peak_refresh_rate 120
settings put system user_refresh_rate 120
settings put global force_gpu_rendering 1
settings put global adaptive_battery_management_enabled 0
settings put global disable_hw_overlays 1
settings put global disable_hw_overlays 0
echo 0 > /sys/devices/virtual/input/input1/wake_gesture
echo 1 > /sys/class/kgsl/kgsl-3d0/bus_split
    device_config put game_overlay com.dts.freefireth fps=120
    device_config put game_overlay com.dts.freefiremax fps=120
}

exec 1>/dev/null
exec 2>/dev/null

prev_window_state=""
game_running=""

target_width=1510;cmd window size "$target_width"x"$(printf %.0f "$(echo "$(echo "$(cmd window size|cut -f3 -d ' '|head -n 1)"|cut -d'x' -f2)"*"$(echo "$target_width"/"$(echo "$(cmd window size|cut -f3 -d ' '|head -n 1)"|cut -d'x' -f1)"|bc -l)"|bc)")";cmd window density "$(echo "$(cmd window density|cut -f3 -d ' '|head -n 1)"*"$target_width"/"$(echo "$(cmd window size|cut -f3 -d ' '|head -n 1)"|cut -d'x' -f1)"|bc)"

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
