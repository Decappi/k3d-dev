#!/usr/bin/env bash
set -eux

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/common.sh

cd $PROJECT_DIR/$CLUSTER_NAME

helm dependency update
helm upgrade --install $CLUSTER_NAME .
