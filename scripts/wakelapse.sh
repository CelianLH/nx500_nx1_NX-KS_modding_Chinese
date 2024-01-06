#!/bin/bash
hevc=($(st pmu show | grep hevc)); 
if [[ "${hevc[1]}" == "ON" ]]; then 
	/opt/usr/nx-ks/popup_timeout  "视频模式 !?" 3
	/opt/usr/nx-ks/popup_timeout  "你在找麻烦吗?" 2
	/opt/usr/nx-ks/popup_timeout  "麻烦来了: 3, 2,... 1" 2
	killall mod_gui
	exit
fi
#
tl_d=$(/opt/usr/nx-ks/popup_entry "延时摄影时长(分钟):" "设置" 取消 30 number )
[[ $tl_d =~ ^[0-9]+$ ]] || exit
tl_d=$(($tl_d*60))
#
tl_g=$(/opt/usr/nx-ks/popup_entry  "照片拍摄间隔(秒):" "设置" 取消 5 number)
[[ $tl_g =~ ^[0-9]+$ ]] || exit
#
sleepytime=$(/opt/usr/nx-ks/popup_entry "延时启动(分钟后):" "设置并启动" 取消 0 number )
[[ $sleepytime =~ ^[0-9]+$ ]] || exit
#
sed -e "s/\${tl_d}/"$tl_d"/" -e "s/\${tl_g}/"$tl_g"/"   /opt/usr/nx-ks/timelapse.tp >  /opt/usr/nx-ks/auto/tl.sh
chmod +x /opt/usr/nx-ks/auto/tl.sh
#
sleepytime=$(($sleepytime*60))
#
/usr/bin/st app nx capture af-mode manual
/usr/bin/st cap capdtm setusr AFMODE 0x70003
af_info=($(st cap iq af pos))
pos_temp=${af_info[2]} 
echo $pos_temp > /sdcard/presets/hib
sync; sync; sync;
sleep 0.25
#
[[ $sleepytime > "0" ]] && $(  /opt/usr/nx-ks/popup_timeout  "Wakeup in $(($sleepytime/60))min. Zzzz." 3 && rtcwake -m mem -s $sleepytime && reboot ) || /opt/usr/nx-ks/auto/tl.sh
