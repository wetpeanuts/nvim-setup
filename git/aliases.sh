#!/usr/bin/env bash

alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gch="git checkout"
alias gpl="git pull"
alias gps="git push"
alias gpsf="git push --force-with-lease"
alias grb="git rebase"
alias grbd="git rebase develop"
alias grbi="git rebase -i"
alias grbi1="git rebase -i HEAD~1"
alias grbi2="git rebase -i HEAD~2"
alias grbi3="git rebase -i HEAD~3"
alias grbi4="git rebase -i HEAD~4"
alias grbi5="git rebase -i HEAD~5"
alias grbi6="git rebase -i HEAD~6"
alias grbi7="git rebase -i HEAD~7"
alias grbi8="git rebase -i HEAD~8"
alias grbi9="git rebase -i HEAD~9"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias gs="git status"
alias gd="git diff"
alias gl="git log"
alias gcp="git cherry-pick"
alias gf="git fetch"
alias gb="git branch"
alias gbd="git branch -D"
alias gsu="git submodule update --init --recursive"
alias gpd="git fetch && git checkout develop && git pull origin develop && git submodule update --init --recursive"
alias glfo="git ls-files --others"

gpsu() {
    local branch
    branch=$(git branch --show-current) || return
    if [[ -z "$branch" ]]; then
        echo "Error: not on a branch (detached HEAD)."
        return 1
    fi
    git push --set-upstream origin "$branch"
}

