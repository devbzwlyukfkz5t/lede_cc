#!/bin/bash

# 32M 固件, https://www.bgegao.com/2020/11/1885.html
sed -i '/spi-max-frequency/a\\t\tbroken-flash-reset;'  target/linux/ramips/dts/mt7628an_hiwifi_hc5x61a.dtsi
sed -i '/tbroken-flash-reset/a\\t\tSPI_NOR_4B_OPCODES;' target/linux/ramips/dts/mt7628an_hiwifi_hc5x61a.dtsi
sed -i 's/"HiWiFi HC5861B";/"HiWiFi HC5861B (32M)";/g' target/linux/ramips/dts/mt7628an_hiwifi_hc5861b.dts
sed -i 's/15808k/32448k/g'                             target/linux/ramips/image/mt76x8.mk

# 修改默认IP
sed -i 's/192.168.1.1/192.168.101.2/g' package/base-files/files/bin/config_generate

# 科学上网
git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld

# mt7628 超频
cp -f $GITHUB_WORKSPACE/scripts/999-mt7628-cpu-overclock.patch target/linux/ramips/patches-5.15/999-mt7628-cpu-overclock.patch
