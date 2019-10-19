#!/bin/sh
million=$1
while [ 0 -eq 0 ]; do
    file="results/${million}million"
    if [ ! -f $file ]; then
        exit 0
    fi
    printf "${million}\t"
    count=$(cat $file | grep -P "[13579]\t" | wc -l)
    echo $count
    million=$((million+1))
done
