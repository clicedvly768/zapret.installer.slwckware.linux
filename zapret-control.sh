#!/bin/bash

if [ -f "$(dirname "$0")/lib/utils.sh" ]; then
    source "$(dirname "$0")/lib/utils.sh"
fi
if [ -f "$(dirname "$0")/lib/init.sh" ]; then
    source "$(dirname "$0")/lib/init.sh"
fi
if [ -f "$(dirname "$0")/lib/service.sh" ]; then
    source "$(dirname "$0")/lib/service.sh"
fi
if [ -f "$(dirname "$0")/lib/install.sh" ]; then
    source "$(dirname "$0")/lib/install.sh"
fi
if [ -f "$(dirname "$0")/lib/config.sh" ]; then
    source "$(dirname "$0")/lib/config.sh"
fi
if [ -f "$(dirname "$0")/lib/menu.sh" ]; then
    source "$(dirname "$0")/lib/menu.sh"
fi

set -e  

if [ "$(id -u)" -eq 0 ]; then
    SUDO=""
else
    if command -v sudo > /dev/null 2>&1; then
        SUDO="sudo"
    elif command -v doas > /dev/null 2>&1; then
        SUDO="doas"
    else
        echo "Скрипт не может быть выполнен не от имени суперпользователя."
        exit 1
    fi
fi

if [[ $EUID -ne 0 ]]; then
    exec $SUDO "$0" "$@"
fi
check_openwrt
check_tput
$TPUT_B
check_fs
detect_init
main_menu
