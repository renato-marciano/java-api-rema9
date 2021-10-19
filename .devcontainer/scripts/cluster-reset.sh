#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

k3d cluster delete
k3d registry delete --all

. "$SCRIPT_DIR/cluster-create.sh"
