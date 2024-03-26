# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Hank added below -------------------------------------------------------------------------------
echo "Hank's server (version -> 20240323)"
echo "kernel version (" $(uname -r) ")"
echo ""
echo $(java --version | grep openjdk)
echo $(javac --version)
echo $(python -V)
echo ""
echo 'You can use cmd: "Hank_help", todo STH.'
echo "---------------------------------------"

function Hank_server_help(){
	echo ""
	echo "---------------------------------------------------------"
	echo "| 1. python version change"
	echo "|   A. switch_to_py2"
	echo "|   B. switch_to_py3"
	echo "| 2. build code (stdout and write into file)"
	echo "|   A. make -j11 2>&1 | tee SomeFile.txt"
	echo "|"
	echo "---------------------------------------------------------"
}

function Hank_help(){
fun_Sel=0
until [ $fun_Sel -le 8 ] && [ $fun_Sel -ge 1 ]
do
        echo "Please select function you wanna go:"
        echo "1. switch_to_py2"
        echo "2. switch_to_py3"
        echo "3. Mitac bserver"
	echo "4. MiTac_my_server(10.99.0.98 must in my company)"
        echo "5. MiTac repo help"
        echo "6. build code (stdout and write into file)"
        echo "7. java_version_change"
        echo "8. javac_version_change"
        read fun_Sel
done

Device=""
if [[ $fun_Sel -eq 1 ]] ; then
        switch_to_py2
elif [[ $fun_Sel -eq 2 ]] ; then
        switch_to_py3
elif [[ $fun_Sel -eq 3 ]] ; then
        bserver
elif [[ $fun_Sel -eq 4 ]] ; then
        my_server
elif [[ $fun_Sel -eq 5 ]] ; then
        MiTac_repo_help
elif [[ $fun_Sel -eq 6 ]] ; then
        echo "cmd: make -j11 2>&1 | tee SomeFile.txt"
elif [[ $fun_Sel -eq 7 ]] ; then
	echo 'cmd: "sudo update-alternatives --config java"'
        sudo update-alternatives --config java
	echo $(java --version | grep openjdk)
	echo $(javac --version)
elif [[ $fun_Sel -eq 8 ]] ; then
	echo 'cmd: "sudo update-alternatives --config javac"'
        sudo update-alternatives --config javac
	echo $(java --version | grep openjdk)
	echo $(javac --version)
fi
}

function switch_to_py2(){
	echo $(python -V)" ------> "
	sudo rm -f /usr/bin/python
	sudo ln -sf /usr/bin/python2 /usr/bin/python
	echo $(python -V)
}

function switch_to_py3(){
	echo $(python -V)" ------> "
	sudo rm -f /usr/bin/python
	sudo ln -sf /usr/bin/python3 /usr/bin/python
	echo $(python -V)
}

export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_DIR=/home/hank/.buildAOS_cache

export ANDROID_SDK_ROOT=/home/hank/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/build-tools/34.0.0

function bserver () {
        echo "PW hint : C->5"
        ssh hankshen@10.99.253.71 -p 17222
}

function my_server(){
	ssh user@192.168.1.81
}

function MiTac_repo_help(){
	MiTac_choose=0
	until [ $MiTac_choose -le 4 ] && [ $MiTac_choose -ge 1 ]
	do
		echo "Please select MiTac repo help you wanna know:"
		echo "1. repo sync code address"
		echo "2. rslg"
		echo "3. pushGerrit"
		echo "4. ....."
		read MiTac_choose
	done

	Device=""
	if [[ $MiTac_choose -eq 1 ]] ; then	
		echo ""
		echo "chiron_pro AOS9 ->"
		echo "repo init -u http://10.88.26.87:18080/aiotbc/git/bsp/sc600/manifest.git -m quectel-sc600-20190515.xml -b master --reference /home/rdc3/git_mirror/AOS9 --depth=30"
		echo ""
		echo "chiron_pro_c25 AOS9 ->"
		echo "repo init -u http://10.88.26.87:18080/aiotbc/git/bsp/sc600/manifest.git -m mitac-sc600-c25_20210618.xml -b master --depth=30"
		echo ""
		echo "gemini_c26 AOS10 ->"
		echo "repo init -u http://10.88.25.195/aiotbc/git/bsp/sc600_10/manifest.git -m mitac-sc600_10_c26-20220905-gemini-dev.xml -b master"
	elif [[ $MiTac_choose -eq 2 ]] ; then
		rslg
	elif [[ $MiTac_choose -eq 3 ]] ; then
		pushGerrit
	elif [[ $MiTac_choose -eq 4 ]] ; then
		echo "4"
	fi


}

function rslg () {
	rm -rf /tmp/$USER
	mkdir -p /tmp/$USER
	#repo sync .
	python3 /home/user/bin/repo sync .
	while ! (curl -u readonly2:g7g2mc "ftp://10.88.25.179/Toolchain/hooks/.gitmessage.txt" -o /tmp/$USER/.gitmessage.txt > /dev/null 2>&1); do echo "...retry to ger template"; done;

	while ! (curl -u readonly2:g7g2mc "ftp://10.88.25.179/Toolchain/hooks/commit-msg" -o /tmp/$USER/commit-msg > /dev/null 2>&1); do echo "...retry to ger hook"; done;

	while ! ( echo "Update $REPO_PATH"; rm -f .git/hooks/.gitmessage.txt > /dev/null 2>&1;cp /tmp/$USER/.gitmessage.txt .git/hooks/.gitmessage.txt ); do echo "...retry to update template for $REPO_PATH"; done; git config commit.template .git/hooks/.gitmessage.txt;

	while ! ( echo "Update $REPO_PATH"; rm -f .git/hooks/commit-msg > /dev/null 2>&1;cp /tmp/$USER/commit-msg .git/hooks/commit-msg ); do echo "...retry to update hook for $REPO_PATH"; done; chmod +x `git rev-parse --git-dir`/hooks/commit-msg;
}

function pushGerrit () {
	remoteMaster=`git branch -a | grep "remotes/m/master"`
	originBranch=`echo $remoteMaster | cut -d ">" -f 2`
	origin=`echo $originBranch | cut -d "/" -f 1`
	branch=`echo $originBranch | cut -d "/" -f 2`
	echo "git push $origin HEAD:refs/for/$branch"
	git push $origin HEAD:refs/for/$branch
}

source /home/hank/init/repo_manager.sh

export LC_ALL=C
export LC_CTYPE=C.UTF-8
