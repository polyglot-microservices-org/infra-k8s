#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

echo "🔥 Cleaning up all resources in default namespace..."
kubectl delete all --all -n default --ignore-not-found
kubectl delete pvc --all -n default --ignore-not-found
kubectl delete configmap --all -n default --ignore-not-found
kubectl delete secret --all -n default --ignore-not-found
kubectl delete networkpolicy --all -n default --ignore-not-found
kubectl delete hpa --all -n default --ignore-not-found
kubectl delete statefulset --all -n default --ignore-not-found
kubectl delete pv --all --ignore-not-found

echo "✅ Default namespace fully cleaned."

