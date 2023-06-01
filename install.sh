#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

$SCRIPT_DIR/scripts/init_k3d.sh
$SCRIPT_DIR/scripts/init_helm.sh
