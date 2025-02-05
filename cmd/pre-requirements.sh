#!/bin/bash -l

# Author: @andresb39, @AnthonyMYCD, @YesMCD
# Company: myCloudDoor
# Date: January 2025
#
# Description:
#   Ensures required dependencies (`tfenv` and `jq`) are installed.
#   If they are missing, installs them automatically.

set -euo pipefail

# Color configuration for messages
INFO_COLOR="\033[34;1m"
ERROR_COLOR="\033[31;1m"
RESET_COLOR="\033[0m"

info() { echo -e "${INFO_COLOR}INFO:${RESET_COLOR} $1" >&2; }
error() {
	echo -e "${ERROR_COLOR}ERROR:${RESET_COLOR} $1" >&2
	exit 1
}

install_package() {
	local package=$1
	info "Installing $package..."
	if command -v apt-get &>/dev/null; then
		sudo apt-get update && sudo apt-get install -y "$package"
	elif command -v yum &>/dev/null; then
		sudo yum install -y "$package"
	elif command -v brew &>/dev/null; then
		brew install "$package"
	else
		error "Unsupported package manager. Install $package manually."
	fi
}

# Ensure tfenv is installed
if ! command -v tfenv &>/dev/null; then
	info "Installing tfenv..."
	git clone https://github.com/tfutils/tfenv.git "$HOME/.tfenv"
	export PATH="$HOME/.tfenv/bin:$PATH"
	echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >>"$HOME/.bashrc"
	sudo ln -s "$HOME/.tfenv/bin/"* /usr/local/bin
else
	info "tfenv is already installed."
fi

# Ensure jq is installed
command -v jq &>/dev/null || install_package "jq"

info "Pre-requirements check completed successfully."
