#!/usr/bin/env sh

finder() {
    find "$HOME" -name ".git" -prune -o -type d -print
}

finder | nl -w 1 -s: | less -FX

printf "\n%s" "Number for directory: "
read -r directory
move="$(finder | sed -n """$directory"" p")"
echo "$move"


































# set -f
# set -- $@

# f="$(find "$HOME" -type d -name ".git" -prune -o -type d -print)"
# set - "$f"
# set -- $@
# printf "%s\n" "$f" | nl -w 1 -s: | less -FX
# # printf "\n%s" "${5}"
# printf "\n%s" "Which directory do you want to go to: "
# read -r directory
# # move="$($f | sed -n """$directory" p"")"
# $f | sed -n "5 p"
# # cd "$move"
# 
# set + "$f"


# cd "${5}"
# printf "\n%s" "$PWD"

# printf "%s\n" "${5}"
# $@ | sed -n "26p"
# printf "\n%s\n" ""
