#!/bin/bash
find_dict() {
    files=$(ls /usr/share/dict/)
    set -x
    for file in $files;
    do
        lines=$(wc /usr/share/dict/"$file" | awk '{print $1}')
        words=$(wc /usr/share/dict/"$file" | awk '{print $2}')
        if [[ $lines -gt 10000 ]]; then
            if [[ $lines -eq $words ]];
            then
                echo "$file"
            fi
        fi
    done
    set +x
}
get_word_from_1000(){
    word=$(shuf -n1 ./1-1000.txt)
    echo "$word"
}
get_word() {
    dict=$(find_dict)
    word=$(shuf -n1 /usr/share/dict/$dict)
    echo "$word"
}

get_definition()
{
    word=$(get_word)
    status_code=$(curl -w "%{http_code}\n" "https://api.dictionaryapi.dev/api/v2/entries/en/$word" | jq | tail -n 1)
    echo "$status_code"
    if [[ $status_code == "404" ]];
    then
        get_definition
    fi
    data=$(curl -w "%{http_code}\n" "https://api.dictionaryapi.dev/api/v2/entries/en/$word" | jq)
    echo "$data"
}
get_definition
