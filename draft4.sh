#!/usr/bin/env sh

# aflag=
# bflag=
# while getopts ab: name
# do
    # case $name in
    # a)    aflag=1;;
    # b)    bflag=1
          # bval="$OPTARG";;
    # ?)   printf "Usage: %s: [-a] [-b value] args\n" "$0"
          # exit 2;;
    # esac
# done
# if [ -n "$aflag" ]; then
    # printf "Option -a specified\n"
# fi
# if [ -n "$bflag" ]; then
    # printf 'Option -b "%s" specified\n' "$bval"
# fi
# shift $(($OPTIND - 1))
# printf "Remaining arguments are: %s\n" "$*"Q


aflag=
bflag=
while getopts   name
do
    case $name in
    a)    aflag=1;;
    b)    bflag=1
          bval="$OPTARG";;
    ?)   printf "Usage: %s: [-a] [-b value] args\n" "$0"
          exit 2;;
    esac
done
if [ -n "$aflag" ]; then
    printf "Option -a specified\n"
fi
if [ -n "$bflag" ]; then
    printf 'Option -b "%s" specified\n' "$bval"
fi
shift $(($OPTIND - 1))
printf "Remaining arguments are: %s\n" "$*"
