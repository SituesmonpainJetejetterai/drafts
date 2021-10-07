#!/usr/bin/bash

dirs=$(ls -d -- */)
for f in $dirs; 
do
    echo "${f}"
    if [ -d "${f}/.git/" ]; then
        cd "${f}" && git pull && cd - || return
    fi
done

printf "\nUseless script now\n"
