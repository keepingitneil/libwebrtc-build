#!/bin/bash
WK_DIR=$(pwd)

source ./variables.sh

cd /tmp
rm -rf src
fetch --nohooks webrtc_android
cd src
git checkout "refs/remotes/branch-heads/$WEBRTC_VERSION"
cd ..
mv src "$WK_DIR"
cd "$WK_DIR"
gclient sync -f
