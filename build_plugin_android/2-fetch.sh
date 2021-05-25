#!/bin/bash

set -e

WORKING_DIR=$(pwd)

set +e
rm -rf /tmp/unitywebrtc
mkdir -p /tmp/unitywebrtc
set -e

cd /tmp/unitywebrtc

git clone git@github.com:Unity-Technologies/com.unity.webrtc.git

git checkout "2.4.0-exp.1"

rm -rf com.unity.webrtc
mv com.unity.webrtc "$WORKING_DIR/src"
