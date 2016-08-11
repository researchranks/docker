#!/usr/bin/env bash
# description: setup to harden ubuntu server
# tests: digital ocean small instance
# author: researchranks 08-11-2016


# Set magic variables for current file, directory, os, etc.
__dir="$(cd "$(dirname " ${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$( basename ${__file} .sh )"

# github related variables
__github_repository="harden-ubuntu-server"
__github_username="researchranks"
__working_folder=""


# Debug setup
# Exit on error. Append || true if you expect an error.
# Do not allow use of undefined vars. Use ${VAR:-} for undefined
# Catch error for mysqldump fail and gzip succeeds in `mysqldump |gzip`

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

#debug
echo $__dir ' --some data-- '

git clone https://github.com/$__github_username/$__github_repository.git


