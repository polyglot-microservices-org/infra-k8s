#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

echo "🚀 Applying all Kubernetes manifests to default namespace..."

# 1. Secrets (dynamic from .env if exists)
if [ -f "$BASE_DIR/bedrock-service/.env" ]; then
  echo "🔑 Creating bedrock-secrets from .env ..."
  kubectl delete secret bedrock-secrets --namespace=default --ignore-not-found
  kubectl create secret generic bedrock-secrets \
    --from-env-file=$BASE_DIR/bedrock-service/.env \
    --namespace=default
else
  echo "⚠️ No .env file found for bedrock-service! Skipping secrets."
fi

# 2. ConfigMaps
kubectl apply -f $BASE_DIR/frontend/k8s/configmap.yaml --namespace=default || true

# 3. Network Policies
kubectl apply -f $BASE_DIR/infra-k8s/network-policies/ --namespace=default || true

# 4. Each microservice
for service in notes-service todo-service user-service bedrock-service frontend; do
  echo "📦 Applying $service ..."
  kubectl apply -f $BASE_DIR/$service/k8s/ --namespace=default
done

echo "✅ All manifests applied."

