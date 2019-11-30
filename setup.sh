#!/usr/bin/env bash


# setup gitconfig
ln -s "$PWD/gitconfig" "$HOME/.gitconfig" &2>/dev/null

# setup bashrc
# if ~/.bashrc present already, create new .mybashrc and add "source .mybashrc" in .bashrc
if [ -f "$HOME/.bashrc" ]; then
    echo "source $PWD/bashrc.funcs" >> $HOME/.bashrc
    echo "source $PWD/bashrc" >> $HOME/.bashrc
else
    echo "WARNING: bashrc setup failed, system .bashrc not found."
fi

