#!/usr/bin/env bash
set -euo pipefail

RELEASE="${RELEASE:-microservice-demo}"
NAMESPACE="${NAMESPACE:-microservice-demo}"
IMAGE_REPOSITORY="${IMAGE_REPOSITORY:-microservice-k8s-demo}"
IMAGE_TAG="${IMAGE_TAG:-local}"

kubectl apply --filename k8s/namespace.yaml
helm upgrade --install "$RELEASE" helm \
  --namespace "$NAMESPACE" \
  --set image.repository="$IMAGE_REPOSITORY" \
  --set image.tag="$IMAGE_TAG" \
  --wait

kubectl rollout status deployment/"$RELEASE-microservice-k8s-demo" --namespace "$NAMESPACE"
