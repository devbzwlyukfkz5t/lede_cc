#!/bin/bash

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# 32M 固件, https://www.bgegao.com/2020/11/1885.html
sed -i 's/<0x50000 0xf70000>/<0x50000 0x1fb0000>/g' target/linux/ramips/dts/mt7628an_hiwifi_hc5x61a.dtsi
sed -i 's/fc0000/2000000/g'              target/linux/ramips/dts/mt7628an_hiwifi_hc5x61a.dtsi
sed -i 's/fe0000/2020000/g'              target/linux/ramips/dts/mt7628an_hiwifi_hc5x61a.dtsi
sed -i 's/ff0000/2030000/g'              target/linux/ramips/dts/mt7628an_hiwifi_hc5x61a.dtsi
sed -i 's/"HC5861B";/"HC5861B (32M)";/g' target/linux/ramips/dts/mt7628an_hiwifi_hc5861b.dts
sed -i 's/15808k/32448k/g'               target/linux/ramips/image/mt76x8.mk

# 修改默认IP
sed -i 's/192.168.1.1/192.168.101.2/g' package/base-files/files/bin/config_generate

# 科学上网
git clone --depth=1 https://github.com/fw876/helloworld.git                package/helloworld
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall          package/luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2         package/luci-app-passwall2
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall

# mt7628 超频
# cp -f $GITHUB_WORKSPACE/scripts/999-mt7628-cpu-overclock.patch target/linux/ramips/patches-5.15/999-mt7628-cpu-overclock.patch
