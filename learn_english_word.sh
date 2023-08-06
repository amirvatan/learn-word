#!/bin/bash
files=$(ls /usr/share/dict/)
echo "$files"
set -x
for file in $files;
do
    echo "$file"
    lines=$(wc /usr/share/dict/"$file" | awk '{print $1}')
    if [[ $lines -gt 10000 ]]; then
        dict=$file
    fi
done
set +x
