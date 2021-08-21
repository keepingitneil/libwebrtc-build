#!/bin/bash

SRC_DIR=$(pwd)/src
WK_DIR=$(pwd)

cd src/Plugin~/tools

# Plugin~/WebRTCPlugin/Codec/AndroidCodec/android_codec_factory_helper.cc

find . -type f -name "*.txt" -exec sed -i 's/Java_org_webrtc/Java_org_unityrtc/g' {} +

cd "$SRC_DIR/Plugin~/WebRTCPlugin/Codec"

find . -type f -name "*.cc" -exec sed -i 's/org\/webrtc/org\/unityrtc/g' {} +
find . -type f -name "*.h" -exec sed -i 's/org\/webrtc/org\/unityrtc/g' {} +

patch $WK_DIR/WebRTC.cs.patch $WK_DIR/Runtime/Scripts/WebRTC.cs
