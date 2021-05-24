set -e
source variables.sh

cd src

git stash
git checkout "refs/remotes/branch-heads/$WEBRTC_VERSION"
set +e
git branch -D rename
set -e

cd ..

git checkout -b rename

patch -N "src/BUILD.gn" < "patches/add_jsoncpp.patch"

cd src


sed -i 's/package\ org.webrtc/package\ org.unityrtc/g' *.java
sed -i 's/package\ org.webrtc/package\ org.unityrtc/g' audio/*.java

