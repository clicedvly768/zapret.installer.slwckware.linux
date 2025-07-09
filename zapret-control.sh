#!/bin/bash

if [ -f "$(dirname "$0")/files/utils.sh" ]; then
    source "$(dirname "$0")/files/utils.sh"
fi
if [ -f "$(dirname "$0")/files/init.sh" ]; then
    source "$(dirname "$0")/files/init.sh"
fi
if [ -f "$(dirname "$0")/files/service.sh" ]; then
    source "$(dirname "$0")/files/service.sh"
fi
if [ -f "$(dirname "$0")/files/install.sh" ]; then
    source "$(dirname "$0")/files/install.sh"
fi
if [ -f "$(dirname "$0")/files/config.sh" ]; then
    source "$(dirname "$0")/files/config.sh"
fi
if [ -f "$(dirname "$0")/files/menu.sh" ]; then
    source "$(dirname "$0")/files/menu.sh"
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
