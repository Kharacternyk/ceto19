#!/bin/sh
million=1
while [ 0 -eq 0 ]; do
    file="results/${million}million"
    if [ ! -f $file ]; then
        exit 0
    fi
    echo >&2 $million
    grep "[1-9][0-9]\$" < $file
    million=$((million+1))
done
 
