#!/bin/bash
FILE="/sdcard/mod/cButton.sh"
#
if [ ! -f "$FILE" ]; then
    /opt/usr/nx-ks/popup_timeout "cButton文件不存在" 2
    /opt/usr/nx-ks/popup_timeout "请先创建 $FILE " 3
else
	$("$FILE")&
fi
