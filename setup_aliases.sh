#!/usr/bin/env bash

# Add automatic bash setup to ~/.bashrc or ~/.zshrc:
#
# ```bash
# if [[ -d "$HOME/.bash_setup" ]]; then
#     for script in "$HOME"/.bash_setup/*.sh; do
#         [[ -f "$script" ]] && source "$script"
#     done
# fi
# ```

mkdir -p $HOME/.bash_setup

ln -s $PWD/common/aliases.sh $HOME/.bash_setup/common_aliases.sh
ln -s $PWD/git/aliases.sh $HOME/.bash_setup/git_aliases.sh
ln -s $PWD/just/aliases.sh $HOME/.bash_setup/just_aliases.sh

if [[ "$(uname -s)" == "Darwin" ]]; then
    ln -s $PWD/fzf/aliases_macos.sh $HOME/.bash_setup/fzf_aliases.sh
elif [[ "$(uname -s)" == "Linux" ]]; then
    ln -s $PWD/fzf/aliases_linux.sh $HOME/.bash_setup/fzf_aliases.sh
fi

