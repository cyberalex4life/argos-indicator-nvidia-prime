#!/usr/bin/env bash
run_as_root="pkroot -d" # gksu; pkroot; gnomesu -c;
notify_switch="notify-send -h int:transient:2 \\\"dialog-information-symbolic\\\" \\\"NVidia Prime Indicator\\\" \\\"Switching graphics. Please reboot to finalize process! \\\" ; "
notify_switch_and_reboot="notify-send -h int:transient:2 -i \\\"dialog-information-symbolic\\\" \\\"NVidia Prime Indicator\\\" \\\"Switching graphics. System will reboot soon... \\\" ; "
notify_reboot="notify-send -h int:transient:2 -i \\\"dialog-information-symbolic\\\"  \\\"NVidia Prime Indicator\\\" \\\"System will reboot! \\\" ; "

activate_intel="\"\
	$notify_switch \
	$run_as_root \\\"prime-select intel\\\" \
	\""

activate_nvidia="\"\
	$notify_switch \
	$run_as_root \\\"prime-select nvidia\\\" \
	\""

activate_intel_and_reboot="\"\
	$notify_switch_and_reboot \
	$run_as_root \\\"prime-select intel\\\"; \
	$notify_reboot \
	sleep 1; \
	systemctl --no-wall reboot \
	\""

activate_nvidia_and_reboot="\"\
	$notify_switch_and_reboot \
	$run_as_root \\\"prime-select nvidia\\\"; \
	$notify_reboot \
	sleep 1; \
	systemctl --no-wall reboot \
	\""

reboot_cmd="\"\
	$notify_reboot \
	sleep 1; \
	systemctl --no-wall reboot \
	\""

nvidia_settings="\"nvidia-settings -p 'PRIME Profiles'\""
nvidia_active_icon="nvidia-active-symbolic"
nvidia_inactive_icon="nvidia-inactive-symbolic"
reboot_icon="system-restart"


QUERY=$(prime-select query)
if [ "$QUERY" == 'nvidia' ]; then
    nvidia_state_icon=$nvidia_active_icon
    TEMP=$(nvidia-smi -q -d TEMPERATURE | grep 'GPU Current Temp' | awk '{print $5}')
    panel_string="$TEMP\xe2\x84\x83 | "
else
    nvidia_state_icon=$nvidia_inactive_icon
    panel_string=" | "
fi

echo -e "$panel_string""iconName=$nvidia_state_icon"
echo "---"
echo "NVIDIA PRIME Profiles| iconName=$nvidia_state_icon bash=$nvidia_settings terminal=false"
echo "---"
echo "Switch to INTEL | iconName='prime-indicator-intel' bash=$activate_intel terminal=false"
echo "Switch to NVIDIA  | iconName='prime-indicator-nvidia' bash=$activate_nvidia  terminal=false"
echo "---"
echo "Switch to INTEL :: REBOOT | iconName='prime-indicator-intel' bash=$activate_intel_and_reboot terminal=false"
echo "Switch to NVIDIA :: REBOOT | iconName='prime-indicator-nvidia' bash=$activate_nvidia_and_reboot  terminal=false"
echo "---"
echo "System Reboot | iconName=$reboot_icon bash=$reboot_cmd terminal=false"
