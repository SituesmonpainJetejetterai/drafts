#!/usr/bin/env bash

printf "\nadding lines to ~/.bashrc to source the scripts\n\n"
string=$(cat <<EOT
# ---
## Sourcing fucking everything
for f in $HOME/.bash/.*
do
    if [ ! -d "\${f}" ]; then source "\${f}"; fi
done
EOT
)

grep -qx "$string" text.md || echo "$string" >> text.md
# echo "$string"

## Useless text
