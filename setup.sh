#!/usr/bin/env bash

link_file()
{
    local conf_file=$1

    echo -n "Setup $conf_file"
    ln -s "${PWD}/${conf_file}" "$HOME/${conf_file}" &> /dev/null
    [ "$?" -eq "0" ] && echo "    ... DONE." || echo "    ... MAY ALREADY EXISTS."
}


#-------- install required tools -------
sudo apt install xsel $> /dev/null


#----------- setup gitconfig -----------
link_file gitconfig


#----------- setup bashrc --------------
# if ~/.bashrc present already, create new .mybashrc and add "source .mybashrc" in .bashrc
if [ -f "$HOME/.bashrc" ]; then
    if [ ! -w "$HOME/.bashrc" ]; then
        echo "NOTE: .bashrc file locked"
    else
        echo "source $PWD/bashrc.funcs" >> $HOME/.bashrc
        echo "source $PWD/bashrc" >> $HOME/.bashrc
        chmod -w "$HOME/.bashrc"
    fi
else
    echo "WARNING: bashrc setup failed, system .bashrc not found."
fi


#------------ setup vimrc -------------
mkdir -p $HOME/.vim
if [ ! -d "$HOME/.vim/autoload" ]; then
    git clone https://github.com/tpope/vim-pathogen.git $HOME/.vim/
fi
link_file vimrc


#------------ SSH config ---------------
# Create key-pair for github account and add in ssh-config

KFILE="$HOME/.ssh/gh"
SSH_CONF="$HOME/.ssh/config"

if [ ! -f "$KFILE" ]; then
    ssh-keygen -t rsa -b 4096 -f "$KFILE" -N ''
    gh_ssh="""
    Host    github.com\n
        HostName githun.com\n
        IdentityFile $KFILE\n
    """
    touch "$SSH_CONF"
    echo -e $gh_ssh >> "$SSH_CONF"
    cat "$KFILE.pub" | xsel -ib
    notify-send "Public key copied to clipboard"
fi


#----------- setup pyenv ----------------
if [ ! -d "$HOME/.pyenv" ]; then
    git clone https://github.com/pyenv/pyenv.git "$HOME/.pyenv"
fi

