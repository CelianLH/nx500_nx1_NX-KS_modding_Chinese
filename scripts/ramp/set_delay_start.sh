#!/bin/bash
tii=($(systemctl show-environment))
for i in "${tii[@]}"; do if [[ $i == "p_7="* ]]; then p_7=${i:4}; fi; done
#
p_7=$(/opt/usr/nx-ks/popup_entry "延时启动时间(分钟):" "确认" 取消 $p_7 number )
[[ $p_7 =~ ^[0-9]+$ ]] || mod_gui /opt/usr/nx-ks/gui_ramp
#
systemctl set-environment p_7=$p_7
/opt/usr/nx-ks/loader.sh "/opt/usr/nx-ks/ramp/init.sh"
