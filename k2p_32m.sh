#!/bin/bash

# 32M 固件, https://www.bgegao.com/2020/11/1885.html
sed -i '/spi-max-frequency/a\\t\tbroken-flash-reset;' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/<0xa0000 0xf60000>/<0xa0000 0x1fb0000>/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/"Phicomm K2P";/"Phicomm K2P (32M)";/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/15744k/32448k/g' target/linux/ramips/image/mt7621.mk

# 修改默认IP
sed -i 's/192.168.1.1/192.168.101.2/g' package/base-files/files/bin/config_generate

# mt7621 超频
cp -f $GITHUB_WORKSPACE/scripts/999-mt7621-cpu-overclock.patch target/linux/ramips/patches-5.15/999-mt7621-cpu-overclock.patch

./scripts/feeds update  -a
./scripts/feeds install -a