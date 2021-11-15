#!/bin/sh

help(){
    printf "\n%s\n%s\n%s\n%s" \
        "Usage: " \
        "backup-file.sh [ -o | -b | -h ]" \
        "If the -o flag is set, the script will generate a \".orig\" file" \
        "If the -b flag is set, it'll create a \".bak\" file"
}

while getopts ":hb:o:" opt; do
    case ${opt} in
        h)
            help
            ;;
        b)
            printf "\n%s\n\n" "Copying into a \".bak\" file"
            name="$OPTARG"
            cp -v "${name}" "${name}.bak"
            printf "\n"
            ls -l "${name}.bak"
            ;;
        o)
            printf "\n%s\n\n" "Copying into a \".orig\" file"
            name="$OPTARG"
            cp -v "${name}" "${name}.orig"
            chmod a-w "${name}.orig"
            printf "\n"
            ls -l "${name}.orig"
            ;;
        *)
            printf "\n%s" "You are useless. Try again"
            help
            ;;
    esac
done
