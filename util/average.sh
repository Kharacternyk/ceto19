#!/bin/sh
set -e
sum=$(./run.sh sum $1)
echo "scale=6; $sum/$1" | bc
