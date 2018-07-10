
cd tools; go build release.go; cd ..
./tools/release lcb > version/version.go
sh build.sh
./tools/release lc-builder lcb-Mac.zip build/lcb-Mac.zip
./tools/release lc-builder lcb-Win64.zip build/lcb-Win64.zip
./tools/release lc-builder lcb-Win32.zip build/lcb-Win32.zip
./tools/release lc-builder lcb-Linux64.zip build/lcb-Linux64.zip
./tools/release lc-builder lcb-Linux32.zip build/lcb-Linux32.zip
