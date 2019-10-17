#!/bin/sh
million=$1
while [ 0 -eq 0 ]; do
    file="results/${million}million"
    if [ ! -f $file ]; then
        exit 0
    fi
    echo -n "$million"'\t'
    count=$(< $file wc -l)
    echo "scale=5; $count/1000000" | bc
    million=$((million+1))
done
