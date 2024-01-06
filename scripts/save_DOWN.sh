#!/bin/bash
/opt/usr/nx-ks/popup_ok "保存 EV+DN 配置 ?" 保存 取消; [  $? -eq 255 ] || exit
[ -d "/sdcard/presets" ] || mkdir /sdcard/presets
prefman save_file 0 /sdcard/presets/preset0_down1
prefman save_file 0 /sdcard/presets/preset0_down2
sync
sync
sync
/opt/usr/nx-ks/popup_timeout  " [ EV+DN 已保存  ] " 2 
exit
