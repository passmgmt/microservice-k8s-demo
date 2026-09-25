#!/usr/bin/env bash
set -euo pipefail

RELEASE="${RELEASE:-microservice-demo}"
NAMESPACE="${NAMESPACE:-microservice-demo}"
LOCAL_PORT="${LOCAL_PORT:-8080}"

kubectl port-forward \
  --namespace "$NAMESPACE" \
  "service/$RELEASE-microservice-k8s-demo" \
  "$LOCAL_PORT:80"
