#!/bin/bash

NAME=$1
VERSION=$2
DESC=$3
DEPENDS=$4

WORKDIR="build/$NAME"
mkdir -p "$WORKDIR"

cat > "$WORKDIR/PKGINFO" <<EOF
name=$NAME
version=$VERSION
arch=x86_64
description=$DESC
depends=$DEPENDS
size=$(du -sb "$WORKDIR" | cut -f1)
EOF

mkdir -p "$WORKDIR/usr/bin"
cp "$NAME" "$WORKDIR/usr/bin/$NAME"

if [[ ! -f "$WORKDIR/usr/bin/$NAME" ]]; then
    echo "Binary $NAME not found. Exiting..."
    exit 1
fi

(cd "$WORKDIR" && find usr -type f > .files)

cd build
tar -cJf "$NAME.tar.xz" "$NAME"
echo "Done! -> build/$NAME.tar.xz"
cd ..
