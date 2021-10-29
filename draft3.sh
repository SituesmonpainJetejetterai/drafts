#!/usr/bin/env sh

# leftover() {
    # git status -sb | sed "s/#.*//; s/M//; s/.*\s//; /^$/d"
# }
# 
# leftover | nl -s: | sed -e "s/.*\s//"
# 
# printf "\nGive 3 numbers: "
# read -r num
# for n in ${num}
# do
    # temp=$(leftover | sed -n "${n}p")
    # git add "${temp}"
# done

echo "find . -type f -name '"*"${1}"*\'""
