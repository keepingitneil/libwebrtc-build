#!/bin/bash
source ./variables.sh
fetch --nohooks webrtc_android
cd src
git checkout "refs/remotes/branch-heads/$WEBRTC_VERSION"
gclient sync -f
