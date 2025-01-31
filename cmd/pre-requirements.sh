#!/bin/bash -l

# Author: @andresb39, @AnthonyMYCD, @YesMCD
# Company: myCloudDoor
# Date: January 2025
#
# Description:
#   This script checks and installs required dependencies: `tfenv` & `jq`.

set -euo pipefail # Improves script security

# Color configuration for messages
INFO_COLOR="\033[34;1m"
RESET_COLOR="\033[0m"
ERROR_COLOR="\033[31;1m"

info() { echo -e "${INFO_COLOR}INFO:${RESET_COLOR} $1" >&2; }
error() {
	echo -e "${ERROR_COLOR}ERROR:${RESET_COLOR} $1" >&2
	exit 1
}

# Check and install tfenv
if ! command -v tfenv &>/dev/null; then
	info "Installing tfenv..."
	git clone https://github.com/tfutils/tfenv.git "${HOME}/.tfenv"

	# Add tfenv to PATH based on the user's shell
	echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >>"${HOME}/.bashrc"
	echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >>"${HOME}/.zshrc"

	export PATH="$HOME/.tfenv/bin:$PATH"
	info "tfenv installed successfully."
else
	info "tfenv is already installed."
fi

# Check and install jq
if ! command -v jq &>/dev/null; then
	info "Installing jq..."

	if command -v apt-get &>/dev/null; then
		sudo apt-get update && sudo apt-get install -y jq
	elif command -v yum &>/dev/null; then
		sudo yum install -y jq
	elif command -v brew &>/dev/null; then
		brew install jq
	else
		error "Unsupported package manager. Install jq manually."
	fi

	info "jq installed successfully."
else
	info "jq is already installed."
fi

info "Pre-requirements check completed successfully."
