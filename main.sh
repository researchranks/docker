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

install_docker(){
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
	
	echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
	
	$(update_ubuntu)
	
	apt-cache policy docker-engine
	apt-get install -y docker-engine
	
	echo $(systemctl status docker)
	echo '-- docker up --'
	docker info
}

install_docker_machine(){
	
	docker-machine rm default
	
	curl -L https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine && \
	chmod +x /usr/local/bin/docker-machine
	
# custom port address for docker-machine ssh
# ufw allow 2376

# --generic-ssh-user=USERNAME \
# --generic-ssh-key=PATH_TO_SSH_KEY \

# 
# docker-machine create \
#     --driver=generic \
#     --generic-ip-address=172.17.0.1 \
#     --generic-ssh-port=2376 \
# 	default
}

install_docker_compose(){
	apt-get -y install python-pip
	apt install docker-compose -y
}

install_docker_wordpress(){
	cd ~/
	git clone https://github.com/researchranks/docker-wordpress.git
	cd /docker-wordpress
	docker-compose up
}

clean_up_install(){
	source ${HOME}/.profile
	cd /tmp
	rm -rf ${__tmp_path}
}

update_ubuntu
install_setup
install_docker
install_docker_compose
install_docker_wordpress
clean_up_install