#!/bin/sh
maxValue=1
million=1
while [ 0 -eq 0 ]; do
    file="results/${million}million"
    if [ ! -f "$file" ]; then
        exit
    fi
    arg=$(cat $file | grep "${maxValue}\$" | tail -n 1)
    if [ -z "$arg" ]; then
        million=$((million+1))
        continue
    fi
    echo "$arg"
    maxValue=$((maxValue+1))
done
