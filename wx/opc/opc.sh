#!/usr/bin/bash
# OpenCode.ai related  
clear

# Colors
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export WHITE='\033[0;37m'
export NC='\033[0m' # No Color

# Commands

hea1() {
    echo -e "${CYAN}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
    echo -e "${PURPLE}$1${NC}"
    echo -e "${CYAN}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
}

# ////////////////////////////////////// Opencode.ai //////////////////////////////////////

opencode_i() {
    hea1 "Installing Opencode.ai CLI"
    co1="curl -fsSL https://opencode.ai/install | bash"
    echo -e "${GREEN}Executing: $co1${NC}"
    eval "$co1"
}

opencode_use() {
    hea1 "OpenCode Init"

     # Get Name of project
    echo -e "Enter the name of the project: "
    read name_of_project
    if [ -z "$name_of_project" ]; then
        echo -e "${RED}BASTARD ! Project name cannot be empty${NC}"
        exit 1
    fi

    echo -e "${GREEN} [?] Now go into directory run opencode and /init"

}

