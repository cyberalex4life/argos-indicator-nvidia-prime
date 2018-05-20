#!/usr/bin/env bash
run_as_root="pkroot -d" # gksu; pkroot; gnomesu -c;

activate_intel="\"$run_as_root \\\"prime-select intel\\\"\""
activate_nvidia="\"$run_as_root \\\"prime-select nvidia\\\"\""

activate_intel_and_logout="\"$run_as_root \\\"prime-select intel\\\" && sleep 1 && gnome-session-quit --logout --no-prompt\""
activate_nvidia_and_logout="\"$run_as_root \\\"prime-select nvidia\\\" && sleep 1 && gnome-session-quit --logout --no-prompt\""

logout_cmd="\"gnome-session-quit --logout --no-prompt\""

nvidia_settings="\"nvidia-settings -p 'PRIME Profiles'\""
nvidia_active_icon="nvidia-active-symbolic"
nvidia_inactive_icon="nvidia-inactive-symbolic"
logout_icon="system-log-out"


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
echo "Switch to INTEL :: Log Out | iconName='prime-indicator-intel' bash=$activate_intel_and_logout terminal=false"
echo "Switch to NVIDIA :: Log Out | iconName='prime-indicator-nvidia' bash=$activate_nvidia_and_logout  terminal=false"
echo "---"
echo "Log Out | iconName=$logout_icon bash=$logout_cmd terminal=false"
