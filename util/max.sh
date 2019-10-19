#!/bin/sh
maxValue=1
while [ 0 -eq 0 ]; do
    arg=$(util/find.sh $maxValue 1 2> /dev/null)
    if [ -z "$arg" ]; then
        echo >&2 "Can't find $maxValue."
    else
        echo "$arg"
    fi
    maxValue=$((maxValue+1))
done
