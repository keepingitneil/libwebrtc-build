set -e
source ./variables.sh

set +e
rm -rf "$OUTPUT_DIR"
set -e

mkdir "$OUTPUT_DIR" 

gn gen "$OUTPUT_DIR" --root="src" \
--args="is_debug=false \
target_os=\"android\" \
target_cpu=\"arm64\" \
rtc_use_h264=false \
rtc_include_tests=false \
rtc_build_examples=false \
is_component_build=false \
use_rtti=true \
use_custom_libcxx=false"
