#!/bin/sh
million=$1
rm results/zeroes/values
while [ 0 -eq 0 ]; do
    file="results/${million}million"
    if [ ! -f $file ]; then
        exit 0
    fi
    echo -n "$million"'\t' >> results/zeroes/values
    < $file wc -l >> results/zeroes/values
    echo proccessed ${million} million
    million=$((million+1))
done
