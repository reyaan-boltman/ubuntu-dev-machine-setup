#!/usr/bin/env bash
set -euo pipefail

# Install git and ansible if not already present
if ! command -v git &>/dev/null || ! command -v ansible &>/dev/null; then
  echo "Installing git and ansible..."
  sudo apt-get update -qq
  sudo apt-get install -y git ansible
fi

# Run the playbook from the directory this script lives in
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ansible-playbook \
  -i "${SCRIPT_DIR}/hosts" \
  "${SCRIPT_DIR}/main.yml" \
  -e "{ laptop_mode: True }" \
  -e "{ virtual_machine_mode: False }" \
  -e "local_username=$(id -un)" \
  -K
