#!/usr/bin/env bash
# description: setup to harden ubuntu server
# tests: digital ocean small instance
# author: researchranks 08-11-2016
# github: https://github.com/researchranks/harden-ubuntu-server

# Set magic variables for current file, directory, os, etc.
__dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$( basename ${__file} .sh )"
__tmp_path="$(mktemp --directory)"

# github related variables
__github_repository="harden-ubuntu-server"
__github_username="researchranks"


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

# git clone  https://github.com/${__github_username}/${__github_repository}.git


download_docker_repo(){
	echo ${__tmp_path}
	echo ${__dir}
}


# Custom Functions
update_ubuntu(){
	apt-get update
	apt-get autoclean
	apt-get autoremove --purge
}

download_docker_repo