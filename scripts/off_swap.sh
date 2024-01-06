#!/bin/bash
swapoff /opt/usr/home/swapmod
rm /opt/usr/home/swapmod
systemctl set-environment swmo=""
/opt/usr/nx-ks/br_up.sh
/opt/usr/nx-ks/popup_timeout  " [ 虚拟内存已移除 ] " 2
exit
