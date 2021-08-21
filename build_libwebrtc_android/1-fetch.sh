#!/bin/bash
WK_DIR=$(pwd)

source ./variables.sh

cd /tmp
rm -rf src
rm -rf .gclient*
fetch --nohooks webrtc_android
cd src
git checkout "refs/remotes/branch-heads/$WEBRTC_VERSION"
gclient sync -f
cd ..
mv src "$WK_DIR"
cd "$WK_DIR"
