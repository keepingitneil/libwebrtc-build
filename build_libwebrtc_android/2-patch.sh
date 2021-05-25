set -e
source variables.sh

SRC_DIR=$(pwd)/src
SDK_DIR=$(pwd)/src/sdk/android
RTC_BASE_DIR=$(pwd)/src/rtc_base
MODULES_DIR=$(pwd)/src/modules
JNI_DIR=$(pwd)/src/sdk/android/src/jni

cd src

git stash
git clean -fd

cd ..

patch -N "src/BUILD.gn" < "patches/add_jsoncpp.patch"

cd "$SDK_DIR"

sed -i 's/api\/org\/webrtc/api\/org\/unityrtc/g' BUILD.gn
sed -i 's/java\/org\/webrtc/java\/org\/unityrtc/g' BUILD.gn
mv "$SDK_DIR/api/org/webrtc" "$SDK_DIR/api/org/unityrtc"
mv "$SDK_DIR/src/java/org/webrtc" "$SDK_DIR/src/java/org/unityrtc"
find . -type f -name "*.java" -exec sed -i 's/org\.webrtc/org\.unityrtc/g' {} +
find . -type f -name "*.java" -exec sed -i 's/org\.webrtc/org\.unityrtc/g' {} +

cd "$RTC_BASE_DIR"
mv "$RTC_BASE_DIR/java/src/org/webrtc" "$RTC_BASE_DIR/java/src/org/unityrtc"
sed -i 's/java\/src\/org\/webrtc/java\/src\/org\/unityrtc/g' BUILD.gn
find . -type f -name "*.java" -exec sed -i 's/org\.webrtc/org\.unityrtc/g' {} +
find . -type f -name "*.java" -exec sed -i 's/org\.webrtc/org\.unityrtc/g' {} +

# /src/modules/audio_device/android/java/src/org/webrtc/voiceengine/WebRtcAudioTrack
cd "$MODULES_DIR"
mv "$MODULES_DIR/audio_device/android/java/src/org/webrtc" "$MODULES_DIR/audio_device/android/java/src/org/unityrtc"
sed -i 's/java\/src\/org\/webrtc/java\/src\/org\/unityrtc/g' audio_device/BUILD.gn
find . -type f -name "*.java" -exec sed -i 's/org\.webrtc/org\.unityrtc/g' {} +
find . -type f -name "*.java" -exec sed -i 's/org\.webrtc/org\.unityrtc/g' {} +

cd "$SRC_DIR"
find . -type f -name "*.cc" -exec sed -i 's/org\.webrtc/org\.unityrtc/g' {} +
find . -type f -name "*.h" -exec sed -i 's/org\.webrtc/org\.unityrtc/g' {} +
find . -type f -name "*.cc" -exec sed -i 's/org_webrtc/org_unityrtc/g' {} +
find . -type f -name "*.h" -exec sed -i 's/org_webrtc/org_unityrtc/g' {} +
