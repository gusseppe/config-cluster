#!/bin/bash
set -e

echo "🚀 Deploying MLflow using local Helm chart..."

# Install/upgrade MLflow using Helm
helm upgrade --install mlflow-agentes ./mlflow-0.7.13.tgz \
  --cleanup-on-fail \
  --values config-mlflow.yaml \
  --wait

echo "📊 Checking MLflow deployment status..."
helm status mlflow

echo "✨ MLflow deployment complete!"