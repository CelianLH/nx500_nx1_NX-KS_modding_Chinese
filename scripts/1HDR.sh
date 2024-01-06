#!/bin/bash
/usr/bin/st app mode m
/usr/bin/st app nx capture af-mode manual
/usr/bin/st cap capdtm setusr AFMODE 0x70003
[ $(/bin/grep ^NX500$ /etc/version.info) = "NX500" -a $(/bin/grep ^1.12$ /etc/version.info) = "1.12" ]  && nx500="good"
[ $(/bin/grep   ^NX1$   /etc/version.info) = "NX1" -a $(/bin/grep ^1.41$ /etc/version.info) = "1.41"  ] && nx1="good"
#
[[ $nx1 = "good"  ]] && prefman set 0 0x0310 l 65
[[ $nx500 = "good" ]] &&  prefman set 0 0xa340 l 65
/usr/bin/st app mode m ; sleep 1
[[ $nx500 = "good" ]] &&  st cap capt single start || $(st key push s1 && st key click s2 && st key release s1)
/usr/bin/st app mode m ; sleep 1
#
#
[[ $nx1 = "good"  ]] && prefman set 0 0x0310 l 92
[[ $nx500 = "good" ]] &&  prefman set 0 0xa340 l 92
/usr/bin/st app mode m ; sleep 1
[[ $nx500 = "good" ]] &&  st cap capt single start || $(st key push s1 && st key click s2 && st key release s1)
/usr/bin/st app mode m ; sleep 1
#
#
[[ $nx1 = "good"  ]] && prefman set 0 0x0310 l 119
[[ $nx500 = "good" ]] &&  prefman set 0 0xa340 l 119
/usr/bin/st app mode m ; sleep 1
[[ $nx500 = "good" ]] &&  st cap capt single start || $(st key push s1 && st key click s2 && st key release s1)
/usr/bin/st app mode m ; sleep 1
#
#
[[ $nx1 = "good"  ]] && prefman set 0 0x0310 l 146
[[ $nx500 = "good" ]] &&  prefman set 0 0xa340 l 146
/usr/bin/st app mode m ; sleep 1
[[ $nx500 = "good" ]] &&  st cap capt single start || $(st key push s1 && st key click s2 && st key release s1)
/usr/bin/st app mode m ; sleep 1
#
#
[[ $nx1 = "good"  ]] && prefman set 0 0x0310 l 200
[[ $nx500 = "good" ]] &&  prefman set 0 0xa340 l 200
/usr/bin/st app mode m ; sleep 1
[[ $nx500 = "good" ]] &&  st cap capt single start || $(st key push s1 && st key click s2 && st key release s1)
/usr/bin/st app mode m ; sleep 1
#
st key click s1
