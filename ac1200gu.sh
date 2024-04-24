#!/bin/bash

# 修改默认IP
sed -i 's/192.168.1.1/192.168.100.2/g' package/base-files/files/bin/config_generate

# mt7621 超频
cp -f $GITHUB_WORKSPACE/scripts/999-mt7621-cpu-overclock.patch target/linux/ramips/patches-5.15/999-mt7621-cpu-overclock.patch
