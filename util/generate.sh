#!/bin/sh
set -e
million=$1
while [ 0 -eq 0 ]; do
    bin/count "${million}" > "results/${million}million"
    echo Proccessed $million million.
    million=$((million+1))
done
