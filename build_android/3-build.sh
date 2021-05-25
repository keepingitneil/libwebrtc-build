#!/bin/bash
set -e

source ./variables.sh

set +e
rm -rf "$ARTIFACTS_DIR"
mkdir -p "$ARTIFACTS_DIR/lib/arm64"
set -e

for target_cpu in "arm64"
do
  for is_debug in "true" "false"
  do
    # generate ninja files
    gn gen "$OUTPUT_DIR" --root="src" \
      --args="is_debug=${is_debug} \
      target_os=\"android\" \
      target_cpu=\"${target_cpu}\" \
      rtc_use_h264=false \
      rtc_include_tests=false \
      rtc_build_examples=false \
      is_component_build=false \
      use_rtti=true \
      use_custom_libcxx=false"

    # build static library
    ninja -C "$OUTPUT_DIR" webrtc

    filename="libwebrtc.a"
    if [ $is_debug = "true" ]; then
      filename="libwebrtcd.a"
    fi

    # copy static library
    cp "$OUTPUT_DIR/obj/libwebrtc.a" "$ARTIFACTS_DIR/lib/${target_cpu}/${filename}"
  done
done

cp "$OUTPUT_DIR/obj/libwebrtc.a" "$ARTIFACTS_DIR/lib/arm64"

cd src

for is_debug in "true" "false"
do
  python tools_webrtc/android/build_aar.py \
    --build-dir $OUTPUT_DIR \
    --output $OUTPUT_DIR/libwebrtc.aar \
    --arch arm64-v8a \
    --extra-gn-args "is_debug=${is_debug} \
      rtc_use_h264=false \
      rtc_include_tests=false \
      rtc_build_examples=false \
      is_component_build=false \
      use_rtti=true \
      use_custom_libcxx=false"

  filename="libwebrtc.aar"
  if [ $is_debug = "true" ]; then
    filename="libwebrtc-debug.aar"
  fi
  # copy aar
  cp "$OUTPUT_DIR/libwebrtc.aar" "$ARTIFACTS_DIR/lib/${filename}"
done

find . -name "*.h" -print | cpio -pd "$ARTIFACTS_DIR/include"

cd ..

cd "$ARTIFACTS_DIR"

zip -r webrtc-android.zip lib include
mv webrtc-android.zip ..
