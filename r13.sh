#!/bin/bash

# mt7628 超频
cp -f $GITHUB_WORKSPACE/scripts/999-mt7628-cpu-overclock.patch target/linux/ramips/patches-5.15/999-mt7628-cpu-overclock.patch

./scripts/feeds update  -a
./scripts/feeds install -a