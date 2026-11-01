#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
XPL_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd -P)"
if [[ ! -f "$XPL_ROOT/setup_policy_server.py" ]]; then
    echo 'Install this directory at XPolicyLab/policy/RSIWAM first.' >&2
    exit 1
fi
# The caller selects a dedicated policy environment and installs the matching
# CUDA torch/torchvision pair first; no simulator environment is changed here.
python -m pip install -r "$SCRIPT_DIR/bundle/requirements.txt" -c "$SCRIPT_DIR/bundle/constraints-reference.txt"
python -m pip install --no-deps -e "$SCRIPT_DIR"
python -m pip install -e "$XPL_ROOT" -c "$SCRIPT_DIR/bundle/constraints-reference.txt"
printf '%s\n' 'RSIWAM installed in the active policy environment. The supplied constraints are a partial reference, not a full environment lock.'
