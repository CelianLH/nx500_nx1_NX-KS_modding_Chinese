#!/bin/bash
[[ -f /sdcard/presets/FullSave0 && 
-f /sdcard/presets/FullSave1 &&
-f /sdcard/presets/FullSave2 &&
-f /sdcard/presets/FullSave3 &&
-f /sdcard/presets/FullSave4 &&
-f /sdcard/presets/FullSave5 &&
-f /sdcard/presets/FullSave6 &&
-f /sdcard/presets/FullSave7 &&
-f /sdcard/presets/FullSave8 &&
-f /sdcard/presets/FullSave9 &&
-f /sdcard/presets/FullSave10 ]] && $( prefman load_file 0 /sdcard/presets/FullSave0; 
	prefman load_file 1 /sdcard/presets/FullSave1; 
	prefman load_file 2 /sdcard/presets/FullSave2; 
	prefman load_file 3 /sdcard/presets/FullSave3; 
	prefman load_file 4 /sdcard/presets/FullSave4; 
	prefman load_file 5 /sdcard/presets/FullSave5; 
	prefman load_file 6 /sdcard/presets/FullSave6; 
	prefman load_file 7 /sdcard/presets/FullSave7; 
	prefman load_file 8 /sdcard/presets/FullSave8; 
	prefman load_file 9 /sdcard/presets/FullSave9; 
	prefman load_file 10 /sdcard/presets/FullSave10; 
	prefman save; 
	sync;sync;sync;
	/opt/usr/nx-ks/popup_timeout  " [  加载完成  ] " 2; st key click pwoff ) || /opt/usr/nx-ks/popup_timeout  " [  文件缺失  ] " 3
exit
