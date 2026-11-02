#!/usr/bin/env bash

if brew list --formula fd &>/dev/null; then
    echo "fd is already installed. Skipping."
else
    echo "Installing fd..."
    brew install fd
fi

if brew list --formula bat &>/dev/null; then
    echo "bat is already installed. Skipping."
else
    echo "Installing bat..."
    brew install bat
fi

