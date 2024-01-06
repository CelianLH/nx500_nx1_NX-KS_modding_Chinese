#!/bin/sh
dfmsd -t &
sleep 3
dfmstool -s "osd string 2 Otto Kiksmaler NX1/500 Camera Info v0.1"
dfmstool -s "osd string 3 将在15秒后退出..."
grep NX500 /etc/version.info > /dev/null && (
SHUTTER_COUNT=`prefman get 3 0x208 l|grep value|cut -d" " -f4`;
POWERON_COUNT=`prefman get 3 0x244 l|grep value|cut -d" " -f4`;
FLASHIN_COUNT=`prefman get 3 0x248 l|grep value|cut -d" " -f4`;
FLASHEX_COUNT=`prefman get 3 0x24c l|grep value|cut -d" " -f4`;
dfmstool -s "osd string 4 快门次数: $SHUTTER_COUNT"
dfmstool -s "osd string 5 开机次数: $POWERON_COUNT"
dfmstool -s "osd string 6 闪光灯插入次数: $FLASHIN_COUNT"
dfmstool -s "osd string 7 FLASHEX: $FLASHEX_COUNT"
)
grep NX1 /etc/version.info > /dev/null && (
SHUTTER_COUNT=`prefman get 4 0x208 l|grep value|cut -d" " -f4`;
POWER_COUNT=`prefman get 4 0x244 l|grep value|cut -d" " -f4`;
FLASHIN_COUNT=`prefman get 4 0x248 l|grep value|cut -d" " -f4`;
FLASHEXT_COUNT=`prefman get 4 0x24c l|grep value|cut -d" " -f4`;
dfmstool -s "osd string 4 快门次数: $SHUTTER_COUNT"
dfmstool -s "osd string 5 开机次数: $POWERON_COUNT"
dfmstool -s "osd string 6 闪光灯插入次数: $FLASHIN_COUNT"
dfmstool -s "osd string 7 FLASHEX: $FLASHEX_COUNT"
)
sleep 15
killall -KILL dfmsd

