#!/usr/bin/env bash
# description: setup to harden ubuntu server
# tests: digital ocean small instance
# author: researchranks 08-11-2016
# github: https://github.com/researchranks/harden-ubuntu-server

# Set magic variables for current file, directory, os, etc.
__dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$( basename ${__file} .sh )"
__tmp_path="$(/bin/mktemp --directory -t)"

# github related variables
__github_repository="docker"
__github_username="researchranks"

# Use {} when expanding a variable
# Use () when executing a variable


# Debug setup
# Exit on error. Append || true if you expect an error.
# Do not allow use of undefined vars. Use ${VAR:-} for undefined
# Catch error for mysqldump fail and gzip succeeds in `mysqldump |gzip`

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

#debug
echo ${__dir}


install_setup(){
	echo ${__tmp_path}
	cd ${__tmp_path}
	
	git clone  https://github.com/${__github_username}/${__github_repository}.git
	
	mv ${__github_repository}/.profile ~/
	
}


# Custom Functions
update_ubuntu(){
	apt-get update && \
	apt-get upgrade -y
	
	apt-get autoremove --purge && \
	apt-get autoclean -y
}


install_firewall(){
	
}

install_docker(){
	
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

	echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
	
	$(update_ubuntu)
	
	apt-cache policy docker-engine
	
	
}

clean_up_install(){
	source $HOME/.profile
	rm -rf /tmp/${__tmp_path}
}

update_ubuntu
install_setup