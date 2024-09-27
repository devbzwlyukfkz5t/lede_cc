#!/bin/bash

# 32M 固件, https://www.bgegao.com/2020/11/1885.html
sed -i 's/<0x50000 0xf70000>/<0x50000 0xfb0000>/g'     target/linux/ramips/dts/mt7628an_hiwifi_hc5x61a.dtsi
sed -i 's/fc0000/1000000/g'                            target/linux/ramips/dts/mt7628an_hiwifi_hc5x61a.dtsi
sed -i 's/fe0000/1020000/g'                            target/linux/ramips/dts/mt7628an_hiwifi_hc5x61a.dtsi
sed -i 's/ff0000/1030000/g'                            target/linux/ramips/dts/mt7628an_hiwifi_hc5x61a.dtsi
sed -i 's/"HiWiFi HC5861B";/"HiWiFi HC5861B (32M)";/g' target/linux/ramips/dts/mt7628an_hiwifi_hc5861b.dts
sed -i 's/15808k/32448k/g'                             target/linux/ramips/image/mt76x8.mk

# 修改默认IP
sed -i 's/192.168.1.1/192.168.101.2/g' package/base-files/files/bin/config_generate

# 科学上网
git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld

# mt7628 超频
cp -f $GITHUB_WORKSPACE/scripts/999-mt7628-cpu-overclock.patch target/linux/ramips/patches-5.15/999-mt7628-cpu-overclock.patch
