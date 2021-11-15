#!/bin/sh

# The "help" function
help(){
    printf "\n%s\n%s\n%s\n%s" \
        "Usage: " \
        "backup-file.sh [ -o | -b | -h ]" \
        "If the -o flag is set, the script will generate a \".orig\" file" \
        "If the -b flag is set, it'll create a \".bak\" file"
}

# Declaring flags for getopts
while getopts ":hb:o:" opt; do
    case ${opt} in
        h)
            help
            ;;
        b)
            printf "\n%s\n\n" "Copying into a \".bak\" file"
            # Assign a variable with the value of "$OPTARG" to reuse it
            name="$OPTARG"
            # Verbose version of cp
            cp -v "${name}" "${name}.bak"
            printf "\n"
            # Check permissions of file
            ls -l "${name}.bak"
            ;;
        o)
            printf "\n%s\n\n" "Copying into a \".orig\" file"
            # Assign a variable with the value of "$OPTARG" to reuse it
            name="$OPTARG"
            # Verbose version of cp
            cp -v "${name}" "${name}.orig"
            # Take away write permissions from everybody
            chmod a-w "${name}.orig"
            printf "\n"
            # Checking permissions of file
            ls -l "${name}.orig"
            ;;
        *)
            printf "\n%s" "You are useless. Try again"
            help
            ;;
    esac
done
