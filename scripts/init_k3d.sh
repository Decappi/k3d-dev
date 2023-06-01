#!/usr/bin/env bash
set -eux

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$SCRIPT_DIR/..
CLUSTER_NAME=dev-cluster
DB_STORAGE_NAME=appdata-postgresql

k3d cluster delete $CLUSTER_NAME

docker run -d --name registry -p 5000:5000 registry:2 || true #TODO use registry.localhost for local images
k3d registry create registry.localhost --port 5000 || true

#-v $PROJECT_DIR:/home/dev \

# creating storage folders and their permissions (When created by PersistentVolume, no 777 permissions are set)
mkdir -p $PROJECT_DIR/storage/$DB_STORAGE_NAME
chmod 0777 $PROJECT_DIR/storage/$DB_STORAGE_NAME

k3d cluster create $CLUSTER_NAME \
-p 443:443@loadbalancer \
-p 5432:30432@loadbalancer \
-v $PROJECT_DIR/storage/:/var/lib/rancher/k3s/storage@all \
--registry-use k3d-registry.localhost:5000

kubectl label nodes k3d-$CLUSTER_NAME-server-0 database=true
