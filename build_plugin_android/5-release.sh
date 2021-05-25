#!/bin/bash
set -e

RELEASE_DIR=/tmp/webrtcrelease
REPO="git@github.com:chef-studios-inc/com.unity.webrtc.git"
BUILD_DIR="$(pwd)/src"

set +e
rm -rf "$RELEASE_DIR"
set -e

mkdir -p "$RELEASE_DIR"

cd "$RELEASE_DIR"

git clone "$REPO"

cd com.unity.webrtc 

cp -r "$BUILD_DIR/Runtime" .
cp -r "$BUILD_DIR/Editor" .
cp -r "$BUILD_DIR/Samples~" .
cp "$BUILD_DIR/package.json" .
cp "$BUILD_DIR/package.json.meta" .
cp "$BUILD_DIR/.gitignore" .
cp "$BUILD_DIR/Editor.meta" .
cp "$BUILD_DIR/Runtime.meta" .
rm -rf "Runtime/Plugins/iOS"
rm "Runtime/Plugins/iOS.meta"

git add .
git commit -m "Release"
git push
