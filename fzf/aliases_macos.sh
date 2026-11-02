#!/usr/bin/env bash

ff() {
    fd --type f --hidden --exclude .git | fzf --multi \
        --bind 'enter:become(${EDITOR:-nvim} {+})'
}

fg() {
    git ls-files --others | fzf --multi \
        --bind 'enter:become(${EDITOR:-nvim} {+})'
}
