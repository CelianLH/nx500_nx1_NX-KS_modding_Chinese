#!/bin/bash
renice -n +17 -p $$
yell() { echo "$0: $*" >&2; }
die() { [ $blackout ] && $( killall -q blackout; sleep 2; nice -n +15 /opt/usr/nx-ks/onscreen_ks&) &
		yell "$*"; exit 111; }
ticking() {
	end=$((SECONDS+$1))
	while [ $SECONDS -lt $end ]; do
		hevc=($(st pmu show | grep hevc)); if [[ "${hevc[1]}" == "OFF" ]]; then systemctl set-environment rec=0; die; fi
	    sleep 0.5
	done
}
blackoutprep(){
	killall -q onscreen_ks
	/opt/usr/nx-ks/blackout&
}
blackouton(){
	sleep 2
	st app led off
}
touchoff(){
	if [ $(/bin/grep ^NX500$ /etc/version.info) = "NX500" -a $(/bin/grep ^1.12$ /etc/version.info) = "1.12" ]; then
		prefman set 0 0x0000a690 b 0
	elif [  $(/bin/grep   ^NX1$   /etc/version.info) = "NX1" -a $(/bin/grep ^1.41$ /etc/version.info) = "1.41" ]; then
		prefman set 0 0x00000658 b 0
	fi
	dm=$(st cap capdtm getusr DIALMODE);  dm=( $dm )
	dm=${dm[2]}
	case "$dm" in
	"DIALMODE_SMARTAUTO") st app mode auto 
	    ;;
	"DIALMODE_APERTURE") st app mode a
	    ;;
	"DIALMODE_SHUTTERSPEED") st app mode s 
	  ;;
	"DIALMODE_MANUAL") st app mode m  
	   ;;
	"DIALMODE_SMARTPRO") st app mode smart-pro
	   ;;
	*) 
	st app mode p
	;;
	esac
}

tii=($(systemctl show-environment))
#
recording_length=$(/opt/usr/nx-ks/popup_entry  "录制时长(分钟):" "确认" 取消 10 number)
if [[ -z "$recording_length" ]]; then die; fi
[[ $recording_length =~ ^[0-9]+$ ]] || recording_length=14
#
for i in "${tii[@]}"; do if [[ $i == "rec="* ]]; then rec=$((1-${i:4})); fi; done
if [[ -z "$rec" ]]; then rec=1; fi

/opt/usr/nx-ks/popup_ok "熄屏录制" 否 是 
if [[  $? -eq 0 ]]; then  
	blackout="on";  
	systemctl set-environment blackout="on";
fi
/opt/usr/nx-ks/popup_ok "启用触屏" 是 否 
if [[  $? -eq 0 ]]; then  
	touch="off";  
fi
/opt/usr/nx-ks/popup_ok "批量录制 - 每段视频 $recording_length 分钟 ?" 开始 取消 
if [[  $? -eq 0 ]]; then  
	systemctl set-environment rec=0;  
	die 
fi
systemctl set-environment rec=$rec
recording_length=$(($recording_length*60-1))
[ $(/bin/grep   ^NX1$  /etc/version.info) = "NX1" -a $(/bin/grep ^1.41$ /etc/version.info) = "1.41" ] && camisnx1="nx1"
[ $touch ] && touchoff
[ $blackout ] && blackoutprep&
until [ $rec -lt 1 ]
do
      /opt/usr/nx-ks/stapp "app nx record start" 
      [ $blackout ] && blackouton
      ticking $recording_length
      tii=($(systemctl show-environment))
      for i in "${tii[@]}"; do if [[ $i == "rec="* ]]; then rec=${i:4}; fi; done
      /opt/usr/nx-ks/stapp "app nx record stop"
      [ $camisnx1 ] && sleep 2
done
