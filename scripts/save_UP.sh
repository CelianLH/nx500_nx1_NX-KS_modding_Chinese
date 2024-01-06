#!/bin/bash
/opt/usr/nx-ks/popup_ok "保存 EV+UP 配置 ?" 保存 取消; [  $? -eq 255 ] || exit
[ -d "/sdcard/presets" ] || mkdir /sdcard/presets
prefman save_file 0 /sdcard/presets/preset0_up1
prefman save_file 0 /sdcard/presets/preset0_up2
sync
sync
sync
/opt/usr/nx-ks/popup_timeout  " [ EV+UP 已保存  ] " 2
exit
