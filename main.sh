#!/usr/bin/env bash
# description: setup to harden ubuntu server
# tests: digital ocean small instance
# author: researchranks 08-11-2016


# Set magic variables for current file, directory, os, etc.
__dir="$(cd "$(dirname " ${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$( basename ${__file} .sh )"
__github_repo="harden-ubuntu-server"
__github_user="researchranks"

# Debug setup
# Exit on error. Append || true if you expect an error.
# Do not allow use of undefined vars. Use ${VAR:-} for undefined
# Catch error for mysqldump fail and gzip succeeds in `mysqldump |gzip`

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

echo $__dir ' --some data-- '
# curl -L https://git.io/v6B1K -o main.sh | bash

# source <(curl -s https://raw.githubusercontent.com/researchranks/harden-ubuntu-server/master/main.sh)


# bash <(curl -s https://raw.githubusercontent.com/researchranks/harden-ubuntu-server/master/main.sh)



# git clone https://github.com/researchranks/harden-ubuntu-server.git && cd /hardern-ubuntu-server

# bash <(curl -s https://git.io/v6B1K)

# bash <(curl -s https://raw.githubusercontent.com/researchranks /harden-ubuntu-server/master/main.sh)

# source <(curl -s https://git.io/v6B1K)

# curl -L https://raw.githubusercontent.com/researchranks /harden-ubuntu-server/master/main.sh | bash -s
