#!/bin/bash

set -e

CWD=`pwd`


do_build() {
	echo "Building lcb..."
        rm -rf $OUTPUT
	mkdir -p $OUTPUT
	cd $CWD
	cd ./app/lcb
	go get
	GOOS="$GOOS" GOARCH="$GOARCH" go build -ldflags="$LDFLAGS" -o $OUTPUT/$HARNESS
	cd ..
	rsync -a lcb/public lcb/curricula lcb/repository $OUTPUT/
	# mkdir -p $OUTPUT/in/results
	# rsync -a naprrql/in/master_nap.xml.zip  $OUTPUT/in/results
}

do_zip() {
	cd $OUTPUT
	cd ..
	zip -qr ../$ZIP lcb
	cd $CWD
}

build_mac64() {
	# MAC OS X (64 only)
	echo "Building Mac binaries..."
	GOOS=darwin
	GOARCH=amd64
	LDFLAGS="-s -w"
	OUTPUT=$CWD/build/Mac/lcb
	# GNATS=nats-streaming-server
	HARNESS=lcb
	ZIP=lcb-Mac.zip
	do_build
	#do_upx
	# do_shells
	# do_zip
	echo "...all Mac binaries built..."
}


build_windows64() {
	# WINDOWS 64
	echo "Building Windows64 binaries..."
	GOOS=windows
	GOARCH=amd64
	LDFLAGS="-s -w"
	OUTPUT=$CWD/build/Win64/lcb
	# GNATS=nats-streaming-server.exe
	HARNESS=lcb.exe
	ZIP=lcb-Win64.zip
	do_build
	#do_upx
	# do_bats
	# do_zip
	echo "...all Windows64 binaries built..."
}

build_windows32() {
	# WINDOWS 32
	echo "Building Windows32 binaries..."
	GOOS=windows
	GOARCH=386
	LDFLAGS="-s -w"
	OUTPUT=$CWD/build/Win32/lcb
	# GNATS=nats-streaming-server.exe
	HARNESS=lcb.exe
	ZIP=lcb-Win32.zip
	do_build
	#do_upx
	# do_bats
	# do_zip
	echo "...all Windows32 binaries built..."
}

build_linux64() {
	# LINUX 64
	echo "Building Linux64 binaries..."
	GOOS=linux
	GOARCH=amd64
	LDFLAGS="-s -w"
	OUTPUT=$CWD/build/Linux64/lcb
	# GNATS=nats-streaming-server
	HARNESS=lcb
	ZIP=lcb-Linux64.zip
	do_build
	#do_goupx
	# do_shells
	# do_zip
	echo "...all Linux64 binaries built..."
}

build_linux32() {
	# LINUX 32
	echo "Building Linux32 binaries..."
	GOOS=linux
	GOARCH=386
	LDFLAGS="-s -w"
	OUTPUT=$CWD/build/Linux32/lcb
	# GNATS=nats-streaming-server
	HARNESS=lcb
	ZIP=lcb-Linux32.zip
	do_build
	#do_goupx
	# do_shells
	# do_zip
	echo "...all Linux32 binaries built..."
}

# TODO ARM
# GOOS=linux GOARCH=arm GOARM=7 go build -o $CWD/build/LinuxArm7/go-nias/aggregator

if [ "$1" = "L32" ]
then
    build_linux32
elif [ "$1" = "L64"  ]
then
    build_linux64
elif [ "$1" = "W32"  ]
then
    build_windows32
elif [ "$1" = "W64"  ]
then
    build_windows64
elif [ "$1" = "M64"  ]
then
    build_mac64
else
    build_mac64
    build_windows64
    build_windows32
    build_linux64
    build_linux32
fi

