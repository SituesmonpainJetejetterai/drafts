#!/bin/sh

gacp() {

    # Find files with merge conflicts
    merge_conflict_files(){
        git diff --name-only --diff-filter=U
    }

    # Find files which are still to be committed
    still_to_be_committed(){
        git status -sb | sed "s/#.*//; s/M//; s/.*\s//; /^$/d"
    }

    # Edit files
    go_edit() {
        file="$(merge_conflict_files | sed -n "${1}p")"

        if [ -n "$(git ls-files "${file}")" ]; then
            git diff "${file}"
        else
            # If the file is new
            less -FX "${file}"
        fi
        vim "${file}"
    }

    get_changes() {
        printf "\n%s\n" "We need to incorporate changes from the remote before pushing our own commits"
        printf "\n%s" "To simply rebase with the remote, press \"r\""
        printf "\n%s" "To stash unstaged changes and apply them after pulling from remote, press \"s\""
        printf "\n%s" "To stash untracked changes, rebase with remote and then apply changes, press \"rs\" (this is the default option)"
        printf "\n%s\n" "To continue without doing anything, press Enter (carriage return)"

        if read -r track; then
            case "$track" in
                r)
                    printf "\n%s\n" "Just rebasing..."
                    git pull --rebase
                    ;;
                s)
                    printf "\n%s\n" "Stashing changes and pulling from remote"
                    git stash
                    git pull
                    git stash apply
                    ;;
                "")
                    printf "\n%s\n" "Continuing, hope you know what you've done"
                    ;;
                rs|*)
                    printf "\n%s\n" "Stashing and rebasing"
                    git pull --rebase --autostash
                    ;;
            esac
        fi
   }

    do_changes() {

        resume="y"
        while [ "${resume}" = "y" ] || [ "${resume}" = "Y" ];
        do
            printf "\n%s" "If you want to edit a file (in case of a conflict), press \"e\""
            printf "\n%s\n" "If you want to start committing and pushing, press \"c\""
            if read -r option; then
                case "${option}" in
                    e)
                        total=$(merge_conflict_files | wc -l)
                        if [ "${total}" -eq "0" ]; then
                            printf "\n%s\n" "Seems like there are no files with conflicts"
                        else
                            merge_conflict_files | nl -s:
                            printf "\n%s" "Press enter to edit each file one by one, in the order shown."
                            printf "\n%s" "Otherwise, specify the number(s) of the file(s) you want to edit: "
                            read -r numbers
                            if [ -z "${numbers}" ]; then
                                i=1
                                while [ ${i} -le "${total}" ]; do
                                    go_edit "${i}"
                                    i=$(( i + 1 ))
                                done
                            else
                                for n in ${numbers}; do
                                    go_edit "${n}"
                                done
                            fi
                        fi
                        ;;
                    c)
                        still_to_be_committed | nl -s:

                        printf "\n%s" "Enter the number(s) of the file you want to commit: "
                        read -r numbers

                        if [ -z "${numbers}" ]; then
                            # If no argument specified, add all numbers
                            printf "\n%s\n" "Staging all files"
                            still_to_be_committed
                            printf "\n%s" "Do you want to see the diff of the changes?: "
                            read -r sd
                            if [ "${sd}" = "y" ] || [ "${sd}" = "Y" ]; then
                                git diff .
                            fi
                            git add -A
                        else
                            # Add specified numbers
                            printf "\n%s\n" "Staging specified files"
                            for f in ${numbers}
                            do
                                # A variable containing the name of the file to be staged
                                file=$(still_to_be_committed | sed -n "${f}p")
                                # Print the name of the file while staging it
                                printf "\n%s" "${file}"
                                printf "\n%s" "do you want to see the diff of the changes?: "
                                read -r sd
                                if [ "${sd}" = "y" ] || [ "${sd}" = "y" ]; then
                                    git diff "${file}"
                                fi
                                git add "${file}"
                            done
                        fi

                        printf "\n\n%s" "Time for the commit message"
                        printf "\n%s" "If you want to use an editor (vim) for the commit message, press 'v'. Otherwise, simply type the commit message: "
                        read -r op
                        if [ "${op}" = "v" ]; then
                            # Open the text editor (vim in my case) to type the commit message
                            printf "\n%s\n\n" "Opening vim..."
                            git commit
                            printf "\n%s\n" "Closed vim. Check your commit message."
                        else
                            # Type the commit message directly
                            printf "\n%s\n" "Using the given commit message."
                            git commit -m "${op}"
                            printf "\n%s\n" "Closed vim. Check your commit message."
                        fi
                        ;;
                esac
            fi

            printf "\n%s" "Want to go again? Press \"y\" or \"Y\" to repeat: "
            read -r resume

        done
    }

    push_changes() {
        printf "\n%s\n" "Do you want to push? Press \"y\" or \"Y\" to do so: "
        if read -r push; then
            case "${push}" in
                y|Y)
                    printf "\n%s" "Enter the remote and the branch to push to. If not provided, the defaults of 'origin' and the current branch will be used: "
                    read -r remote branch
                    if [ -z "${branch}" ];
                    then
                        current_branch="$(git rev-parse --abbrev-ref HEAD)"
                        printf "\nPushing to origin and %s\n" "${current_branch}"
                        git push -u origin "${current_branch}"
                    else
                        printf "\n%s\n" "Pushing changes..."
                        git push -u "${remote:-origin}" "${branch}"
                    fi
                    ;;
                *)
                    printf "\n%s\n" "Not pushing"
                    ;;
            esac
        fi
    }

get_changes
do_changes
push_changes

}

gacp
