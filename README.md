NX-KS Mod-pack  
如何安装:  
      1) 准备一张SD卡，相机开启蓝牙  
      2) 解压所有文件到SD卡根目录  
      3) SD卡插入相机，并把相机开机  
      4) 耐心等待重启1-2次  
      5) 当Mod安装完成会提示[已安装完成]  
      6) 开机后屏幕上会显示NX-KS图标  
		- (如果15秒没有显示图标，请打开蓝牙)  
      x)卸载Mod: 主菜单> 设置> 卸载 Mod  
  
打开Mod菜单方法：点击屏幕上的图标  或者 双击EV（+/-）按键  
部分功能有Bug，例如导致卡死，拔出电池即可。  
部分功能为二进制文件，需要进行编译源码汉化，因此暂未进行汉化。  
  
禁止利用NX-KS安装文件进行任何形式的盈利活动。  
  
Links：  
GitHub: https://github.com/ottokiksmaler/nx500_nx1_modding  
NX-KS Release: https://nxfiles.nx.tc/files/NX-KS-mod  
long NX-KS thread on dpreview: https://www.dpreview.com/forums/thread/4006750

---

## 紧急救砖：NX500 免拆机固件恢复（Unbrick / Recovery Mode）

如果安装 Mod、`nx-on-wake` 或执行 `systemctl rescue` 后导致 **Samsung NX500** 无法正常开机（软砖 / soft brick），可使用机身隐藏的恢复按键组合免拆机刷回官方固件（无需拆机、无需短接主板或专用软件）：

1. 下载官方原版未修改的 NX500 固件（如 v1.12），将 `nx500.bin` 解压到干净的 **FAT32** SD 卡根目录。
2. 拔出相机电池，插入准备好的 SD 卡。
3. 将相机屏幕**完全向上翻起至自拍位置**，重新装入电池（保持电源关闭）。
4. 同时按住 **MOBILE (Wi-Fi)** 键 + **AEL** 键 + **全按快门**，再打开相机电源开关。
5. 屏幕进入蓝底 **Recovery Mode**（`F/W Check` / `Update` / `Update Finish`）后松手，按屏幕提示**长按快门键**开始刷写 `nx500.bin`。

> **注意**：务必使用官方未修改固件，保持电量充足，刷写期间（`Updating / Do not power off.`）**切勿断电或拔电池**，直至出现 `Update Finish`。该方法已在 `nx-on-wake` 软砖的 NX500 上实机验证完整恢复；**NX1 未验证**（NX1 无翻转屏且按键 GPIO 定义不同）。技术依据与致谢：WApaperplane（[`nx500-dnloader`](https://github.com/WApaperplane/nx500-dnloader/blob/main/docs/BOOT0_ANATOMY.md)）、ge0rg（[`nx500_nx1_modding#121`](https://github.com/ottokiksmaler/nx500_nx1_modding/issues/121)）与 REVPKD（对照 `gpio_map_nx500.h` GPIO 19/27/30/31 定位并实机验证）。
