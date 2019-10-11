#!/bin/sh

if [ ! -f "$1.fasm" ]; then
    echo >&2 "There isn't any files named '$1.fasm'"
    exit 1
fi

if [ ! -d "bin" ]; then
    mkdir bin
fi

ln -s "$1.fasm" "body.fasm"
fasm "wrapper.fasm" "bin/$1"
rm "body.fasm"
chmod +x "bin/$1"
