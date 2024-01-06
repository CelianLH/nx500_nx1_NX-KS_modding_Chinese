#!/bin/bash
/opt/usr/nx-ks/popup_ok "确认卸载 ?" 卸载 取消; [  $? -eq 255 ] || exit
if [ $(/bin/grep ^NX500$ /etc/version.info) = "NX500" -a $(/bin/grep ^1.12$ /etc/version.info) = "1.12" ] ||
 [ $(/bin/grep   ^NX1$   /etc/version.info) = "NX1" -a $(/bin/grep ^1.41$ /etc/version.info) = "1.41"  ]; then
  if [ -x /usr/sbin/bluetoothd.orig ]; then
    mv /opt/usr/nx-ks/popup_timeout /sdcard/popup_timeout
    rm -r /opt/usr/nx-ks/
    swapoff /opt/usr/home/swapmod
    rm /opt/usr/home/swapmod
    mount -o remount,rw /
    cd /usr/sbin/
    mv /usr/sbin/bluetoothd.orig /usr/sbin/bluetoothd
    sync;sync;sync
    mount -o remount,ro /
    rm -f /root/focus_stack.cfg
    sync;sync;sync
    /sdcard/popup_timeout  " [  卸载完成  ] " 4 &
    rm -f /sdcard/popup_timeout
    sync;sync;sync
    sleep 5
  else
    /opt/usr/nx-ks/popup_timeout  " [  Mod不存在  ] " 4
  fi
fi
reboot
