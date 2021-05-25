#!/bin/bash
set -e

RELEASE_DIR=/tmp/webrtcrelease
REPO="git@github.com:chef-studios-inc/unitywebrtc.git"
BUILD_DIR="$(pwd)/src"

set +e
rm -rf "$RELEASE_DIR"
set -e

mkdir -p "$RELEASE_DIR"

cd "$RELEASE_DIR"

git clone "$REPO"

cd unitywebrtc

cp -r "$BUILD_DIR/Runtime" .
cp -r "$BUILD_DIR/Editor" .
cp "$BUILD_DIR/package.json" .
cp "$BUILD_DIR/package.json.meta" .
cp "$BUILD_DIR/.gitignore" .

git add .
git commit -m "Release"
git push
