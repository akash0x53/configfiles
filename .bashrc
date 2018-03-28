# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

git_branch(){
	git branch 2>/dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1)/"
}
color_prompt=yes
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[33m\]$(git_branch)\[\033[0m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -l --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias ls='ls -lFsth --color="auto"'
alias ps='ps -f'
alias emacs='emacs -nw'
alias fucking='sudo'
export JAVA_HOME="/usr/bin/java"
export PATH=$PATH:"/usr/lib/jvm/jdk_1.6.0_45/bin"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="/opt/go/bin:$PATH"
export PATH="/opt/nodejs/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/android/platform-tools:$PATH"
export GOROOT="/opt/go/"


eval "$(pyenv init -)"

#Generate Mercurial diff and save in `diffs' subdir.
generate_diff(){
	name=$1
	diff_dir="diffs"
	mkdir -p ${diff_dir}
	branch=`hg branch`
	now=`date +"%F_%T"`
	export diff_file_path="${PWD}/${diff_dir}/${branch}_${now}_${name:-diff}.diff"
	`hg diff > ${diff_file_path}`
	[ $? -eq 0 ] && echo "created diff ${diff_file_path}"
}




check_freq() {
	user=$1
	hg log --user "${user}" -T "{date|isodate}\n"|cut -d ' ' -f2|cut -d: -f1|sort -n|uniq -c
}

sshany() {
	host=$1
	shift
	ssh "web@192.168.$host"
}

sshtestcloud() {
	ssh web@52.6.183.193
}

suspendme() {
	i3lock -i $HOME/wallpaper/anon.png && sudo pm-suspend
}

ejectdev() {
	udisksctl unmount -b $1
	udisksctl power-off -b $1
}

mountdev() {
	udisksctl mount -b $1
}
vzcode() {
	cd /home/akash/Vaultize/codebase
}

hgport() {
	if (($#<2)); then
		echo "Usage: hgport <branch_name> <commits>"
		return 1
	fi

	local branch=$1
	local idx=0
	local commits=$(($#-1))

	hg shelve
	if (($?==255));then
		echo "You might have hg shelve disabled, please enable and retry"
		return 2
	fi

	echo "This is not undoable task. Do you want to continue?"
	read inp
	if (($inp!='y'));then
		return 1
	fi
	unset inp

	hg checkout --clean $branch

	echo "hg branch $(hg branch)"

	while true; do
		shift
		commit_code=$1
		echo "Grafting commit $commit_code"
		hg graft $commit_code
		idx=$idx+1
		if (($idx==$commits));then
			break
		fi
	done
	echo "Outgoing changes for branch $branch"
	hg outgoing -b $branch
	
	echo "Do you want push to remote?"
	read inp
	if (($inp=='y'));then
		hg push -b $branch
	fi
	hg checkout default
	hg unshelve
}

view_changes()
{
	cur=`hg tip|head -n1|cut -d":" -f3`
	echo "current $cur"
	hg pull && hg upd
	hg log -r "${cur}:." --template "{author}\t{desc}\n---------------------\n"
}

record_screen()
{
	byzanz-record -d $1 $2
}

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="/home/akash/.pyenv/shims/:$PATH"
export PATH="/opt/google/chrome/:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

#RPi tool-chain
export PATH="/os/rpi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin":$PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LIBGL_ALWAYS_SOFTWARE=1


#hour=$(date +%H)
#if (($hour > 18));then
#	export TERMINAL="gnome-terminal --window-with-profile Daylight"
#else
#	export TERMINAL="gnome-terminal --window-with-profile Daylight"
#fi

#469.480 MHZ

genpass()
{
	FOR=$1
	LEN=$2
	shift
	if [ "$LEN" == "" ];then
		LEN=8
	fi
	paswd=$(head -c200 /dev/urandom |tr -cd [:alnum:]+[\!\@\#\$]|head -c $LEN)
	echo "$paswd"|xclip -selection c
	echo "Copied to clipboard"
	if [ "$FOR" == "" ];then
		FOR=$(date)
	fi
	echo "${FOR}: $paswd" >> ~/.pass
}


PATH="$PATH:/home/akash/.mos/bin"
export HOSTALIASES=~/.hosts
