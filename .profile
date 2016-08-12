#!/usr/bin/env bash
# 0: priority of profiles
# 1: ~/.bash_profile (empty)
# 2: ~/.bash_login (empty)
# 3: ~/.profile (default)

# Custom Variables
__dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$( basename ${__file} .sh )"
__tmp_dir="$(mktemp)"

# Custom Paths
export TERM=xterm


# Custom Functions
ip_address(){
	/sbin/ifconfig eth0 | \
	grep 'inet addr:' | \
	cut -d: -f2 | \
	awk '{ print $1}'
}

update_profile(){
	source $HOME/.profile
}


# Custom Aliases
alias ip-address=ip_address
alias update=update_profile