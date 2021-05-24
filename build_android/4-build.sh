#!/bin/bash
set -e

source ./variables.sh

set +e
rm -rf "$ARTIFACTS_DIR"
mkdir -p "$ARTIFACTS_DIR/lib/arm64"
set -e

ninja -C "$OUTPUT_DIR" webrtc

cp "$OUTPUT_DIR/obj/libwebrtc.a" "$ARTIFACTS_DIR/lib/arm64"

cd src
python tools_webrtc/android/build_aar.py \
  --build-dir $OUTPUT_DIR \
  --output $OUTPUT_DIR/libwebrtc.aar \
  --arch arm64-v8a \
  --extra-gn-args "is_debug=false \
    rtc_use_h264=false \
    rtc_include_tests=false \
    rtc_build_examples=false \
    is_component_build=false \
    use_rtti=true \
    use_custom_libcxx=false"


# copy aar
cp "$OUTPUT_DIR/libwebrtc.aar" "$ARTIFACTS_DIR/lib/arm64/libwebrtc.aar"

find . -name "*.h" -print | cpio -pd "$ARTIFACTS_DIR/include"

cd ..

cd "$ARTIFACTS_DIR"

zip -r webrtc-android.zip lib include
mv webrtc-android.zip ..
