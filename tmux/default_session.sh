#!/bin/bash

SESSION="$(basename "$PWD")"

# Check if session already exists
tmux has-session -t "$SESSION" 2>/dev/null

if [ $? != 0 ]; then
    # Use tmux IDs instead of numeric indices so this works with any base-index.
    tmux new-session -d -s "$SESSION" -n dev -x "$(tput cols)" -y "$(tput lines)"
    WINDOW="$(tmux display-message -p -t "$SESSION" '#{window_id}')"
    LEFT="$(tmux display-message -p -t "$WINDOW" '#{pane_id}')"

    # Split vertically (left|right)
    RIGHT="$(tmux split-window -h -P -F '#{pane_id}' -t "$LEFT")"

    # Split right pane horizontally (top/bottom)
    tmux split-window -v -P -F '#{pane_id}' -t "$RIGHT"

    # Run nvim in the left pane.
    tmux send-keys -t "$LEFT" "nvim" Enter

    # Run opencode in the top-right pane.
    tmux send-keys -t "$RIGHT" "opencode" Enter

    # Focus the left pane on attach.
    tmux select-pane -t "$LEFT"
fi

# Attach to session
tmux attach-session -t "$SESSION"
