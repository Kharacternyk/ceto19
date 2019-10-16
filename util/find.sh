#!/bin/sh
million=1
while [ 0 -eq 0 ]; do
    file="results/${million}million"
    if [ ! -f $file ]; then
        exit 1
    fi
    results=$(cat $file | grep "$1\$" | tail -n 1)
    if [ ! -z "$results" ]; then
        echo $results
        exit
    fi
    echo no results at million $million
    million=$((million+1))
done