#!/bin/sh
set -e
sum=$(./run.sh "sum$1" $2)
echo "scale=7; $sum/$2" | bc
