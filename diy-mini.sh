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
sed -i '/spi-max-frequency/a\\t\tbroken-flash-reset;' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/<0xa0000 0xf60000>/<0xa0000 0x1f60000>/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/"Phicomm K2P";/"Phicomm K2P (32M)";/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/15744k/32128k/g' target/linux/ramips/image/mt7621.mk

# 修改默认IP
sed -i 's/192.168.1.1/192.168.102.1/g' package/base-files/files/bin/config_generate

# 更改默认 Shell 为 zsh
# sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 自动登录
# sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 修改本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 科学上网插件
git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
#git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash

# 科学上网附加工具
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang

./scripts/feeds update -a
./scripts/feeds install -a

