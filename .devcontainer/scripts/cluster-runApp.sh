#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

TAG=`date -u +"%Y%m%dT%H%M%SZ"`
export IMAGE="k3d-registry.localhost:12345/app:${TAG}"
docker build -t $IMAGE .
docker push $IMAGE

kubectl wait --for=condition=complete job/helm-install-traefik-crd -n kube-system --timeout=60s
cat "${SCRIPT_DIR}/../local-deployment.yaml" | envsubst | kubectl apply -f -

echo ""
echo "Application: https://${CODESPACE_NAME}-8081.githubpreview.dev/"
echo "Dev Portal: https://${CODESPACE_NAME}-8081.githubpreview.dev/.platform"

# Launch app in a new tab
$BROWSER "https://${CODESPACE_NAME}-8081.githubpreview.dev"
