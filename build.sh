#!/bin/bash

set -e

CWD=`pwd`

build_mac64() {
    echo "Building mac64 components..."
    # sh build_sms.sh
    sh build-lcb.sh M64

    echo "Creating zip archive..."
    cd $CWD/build
    cd Mac
    zip -qr ../lcb-Mac.zip .
    echo "Zip archive created"
    cd ..

    echo "Removing temporary build files"
    rm -r Mac

    echo "Build Completed."
}
build_windows64() {
    echo "Building Windows64 components..."
    # sh build_sms.sh
    sh build-lcb.sh W64

    echo "Creating zip archive..."
    cd $CWD/build
    cd Win64
    zip -qr ../lcb-Win64.zip .
    echo "Zip archive created"
    cd ..

    echo "Removing temporary build files"
    rm -r Win64

    echo "Build Completed."
}
build_windows32() {
    echo "Building Windows32 components..."
    # sh build_sms.sh
    sh build-lcb.sh W32

    echo "Creating zip archive..."
    cd $CWD/build
    cd Win32
    zip -qr ../lcb-Win32.zip .
    echo "Zip archive created"
    cd ..

    echo "Removing temporary build files"
    rm -r Win32

    echo "Build Completed."
}
build_linux64() {
    echo "Building Linux64 components..."
    # sh build_sms.sh
    sh build-lcb.sh L64

    echo "Creating zip archive..."
    cd $CWD/build
    cd Linux64
    zip -qr ../lcb-Linux64.zip .
    echo "Zip archive created"
    cd ..

    echo "Removing temporary build files"
    rm -r Linux64

    echo "Build Completed."
}
build_linux32() {
    echo "Building Linux32 components..."
    # sh build_sms.sh
    sh build-lcb.sh L32

    echo "Creating zip archive..."
    cd $CWD/build
    cd Linux32
    zip -qr ../lcb-Linux32.zip .
    echo "Zip archive created"
    cd ..

    echo "Removing temporary build files"
    rm -r Linux32

    echo "Build Completed."
}
build_all() {
    echo "Building all components..."
    # sh build_sms.sh
    sh build-lcb.sh

    echo "Creating zip archives..."
    cd $CWD/build

    cd Mac
    zip -qr ../lcb-Mac.zip .
    cd ..

    cd Win32
    zip -qr ../lcb-Win32.zip .
    cd ..

    cd Win64
    zip -qr ../lcb-Win64.zip .
    cd ..

    cd Linux32
    zip -qr ../lcb-Linux32.zip .
    cd ..

    cd Linux64
    zip -qr ../lcb-Linux64.zip .
    cd ..

    echo "Zip archives created"

    echo "Removing temporary build files"
    rm -r Mac Win32 Win64 Linux32 Linux64

    echo "Build Completed."
}

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
    build_all
fi
