#!/bin/bash

# 修改默认IP
sed -i 's/192.168.1.1/192.168.101.2/g' package/base-files/files/bin/config_generate

# 科学上网
git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld

# mt7628 超频
cp -f $GITHUB_WORKSPACE/scripts/999-mt7628-overclocking.patch target/linux/ramips/patches-5.15/999-mt7628-overclocking.patch
