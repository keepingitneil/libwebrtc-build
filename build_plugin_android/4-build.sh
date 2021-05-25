#!/bin/bash -eu

export SOLUTION_DIR=$(pwd)/src/Plugin~
export PLUGIN_DIR=$(pwd)/src/Runtime/Plugins/Android
export ARCH_ABI=arm64-v8a
export ANDROID_NDK=$(pwd)/android-ndk-r21b

unzip -d "$SOLUTION_DIR/webrtc" ../build_libwebrtc_android/webrtc-android.zip 

# Build UnityRenderStreaming Plugin 
cd "$SOLUTION_DIR"
cmake . \
  -B build \
  -D CMAKE_SYSTEM_NAME=Android \
  -D CMAKE_SYSTEM_VERSION=21 \
  -D CMAKE_ANDROID_ARCH_ABI=$ARCH_ABI \
  -D CMAKE_ANDROID_NDK=$ANDROID_NDK \
  -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_ANDROID_STL_TYPE=c++_static

cmake \
  --build build \
  --target WebRTCPlugin

# libwebrtc.so move into libwebrtc.aar
cp -f $SOLUTION_DIR/webrtc/lib/libwebrtc.aar $PLUGIN_DIR
pushd $PLUGIN_DIR
mkdir -p jni/$ARCH_ABI
mv libwebrtc.so jni/$ARCH_ABI
zip -g libwebrtc.aar jni/$ARCH_ABI/libwebrtc.so
rm -r jni
popd
