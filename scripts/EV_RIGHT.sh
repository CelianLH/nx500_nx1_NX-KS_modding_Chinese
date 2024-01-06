#!/bin/bash
if [ $(/bin/grep ^NX500$ /etc/version.info) = "NX500" -a $(/bin/grep ^1.12$ /etc/version.info) = "1.12" ]; then
	to=$(prefman get 0 0x0000a690  b);  to=( $to )
	to=${to[5]}
	[[ "$to" = "1" ]] &&  prefman set 0 0x0000a690 b 0 ||  prefman set 0 0x0000a690 b 1
elif [  $(/bin/grep   ^NX1$   /etc/version.info) = "NX1" -a $(/bin/grep ^1.41$ /etc/version.info) = "1.41" ]; then
	to=$(prefman get 0 0x00000658  b);  to=( $to )
	to=${to[5]}
	[[ "$to" = "1" ]] &&  prefman set 0 0x00000658 b 0 ||  prefman set 0 0x00000658 b 1
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
