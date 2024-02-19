#!/usr/bin/env bash

set -euo pipefail

if grep -q ${HOME}/.local/bin <(echo ${PATH}); then
   >&2 echo ${HOME}/.local/bin is in PATH
else
   >&2 echo Please add ${HOME}/.local/bin to your PATH
   exit 1
fi

pip install --upgrade pip
python3 -m pip install --user pipx
python3 -m pipx ensurepath

>&2 echo pipx version $(pipx --version)
>&2 echo Installing Ansible

pipx install --include-deps ansible
pipx inject ansible argcomplete
>&2 echo Done
