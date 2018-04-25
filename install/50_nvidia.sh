#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/.."

source lib/colors.sh

if lspci | grep -q -i nvidia; then
    if [ ! -z "${TB_NVIDIA}" ]; then
        if grep --quiet '^ID=ubuntu' /etc/os-release; then
            if [ ! -f /etc/apt/sources.list.d/graphics-drivers-ubuntu-ppa-xenial.list ]; then
                echo "==> ${LBLUE}Adding Ubuntu graphics repository…${END}"
                sudo add-apt-repository -y ppa:graphics-drivers/ppa
                sudo aptitude update && sudo aptitude safe-upgrade -y
            fi
        fi
    else
        echo "==> ${BROWN}Warning! NVIDIA detected but \$TB_NVIDIA variable is not set. Skip install drivers!${END}"
    fi
fi