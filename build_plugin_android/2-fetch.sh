#!/bin/bash

set -e

WORKING_DIR=$(pwd)

set +e
rm -rf /tmp/unitywebrtc
mkdir -p /tmp/unitywebrtc
set -e

cd /tmp/unitywebrtc

git clone git@github.com:Unity-Technologies/com.unity.webrtc.git

cd com.unity.webrtc

git checkout "2.4.0-exp.4"

cd ..

mv com.unity.webrtc "$WORKING_DIR/src"

rm -rf com.unity.webrtc

