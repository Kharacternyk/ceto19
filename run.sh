#!/bin/sh
set -e
body="$1"
./build.sh "$1" > /dev/null
shift
"bin/${body}" $@
