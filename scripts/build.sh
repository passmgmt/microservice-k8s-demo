#!/usr/bin/env bash
set -euo pipefail

IMAGE="${IMAGE:-microservice-k8s-demo:local}"

mvn clean package

docker build --tag "$IMAGE" .
printf 'Built %s\n' "$IMAGE"
