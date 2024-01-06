#!/bin/bash
FILE="/sdcard/mod/cCheckbox.sh"
#
if [ ! -f "$FILE" ]; then
    /opt/usr/nx-ks/popup_timeout "cCheckbox 文件不存在" 2
    /opt/usr/nx-ks/popup_timeout "请先创建 $FILE " 3
	rm /opt/usr/nx-ks/auto/cCheckbox.sh
else
	$("$FILE")&
fi
