#!/bin/bash
set -euo pipefail

CLUSTERS=$(k3d cluster list -o json | jq 'length')
if [ $CLUSTERS -eq '0' ]; then
  k3d registry create registry.localhost --port 12345 
  k3d cluster create --registry-use k3d-registry.localhost:12345 -p "8081:80@loadbalancer" --volume "$(pwd)/.devcontainer/platform/data:/platformdata"
  
  kubectl wait --for=condition=complete job/helm-install-traefik-crd -n kube-system --timeout=60s
  kubectl apply -f .devcontainer/platform
else
  k3d cluster start
fi