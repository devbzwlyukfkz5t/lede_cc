#!/bin/bash

# 修改默认IP
# sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 更改默认 Shell 为 zsh
# sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 自动登录
# sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 32M 固件, https://www.bgegao.com/2020/11/1885.html
# 第一条：这个很重要， 如果这条没有的话，那么软重启时（就是不拔电，用命令reboot重启，或者是系统里点重启按钮），你就要哭了，因为你的路由会变成黄灯一直卡在那里，别问我为什么，问我就想骂人了，我被这问题困扰了好久，找到好久才找到答案。这条命令的实际效果是在 mt7621_phicomm_k2p.dts 文件的 spi-max-frequency 这一行下，增加了一行 tbroken-flash-reset;
# 第二条：是修改 mt7621_phicomm_k2p.dts ，将里面的 <0xa0000 0xf60000> 换成 <0xa0000 0x1fb0000>
# 第三条：是修改 mt7621.mk ，将里面的磁盘大小 15744k 修改成 32448k，（也就是31MB的样子）
sed -i '/spi-max-frequency/a\\t\tbroken-flash-reset;' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/<0xa0000 0xf60000>/<0xa0000 0x1fb0000>/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/15744k/32448k/g' target/linux/ramips/image/mt7621.mk

./scripts/feeds update -a
./scripts/feeds install -a
