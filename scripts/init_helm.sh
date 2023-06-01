#!/usr/bin/env bash
set -eux

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$SCRIPT_DIR/..
CLUSTER_NAME=dev-cluster

cd $PROJECT_DIR/$CLUSTER_NAME

helm dependency update
helm upgrade --install $CLUSTER_NAME .

