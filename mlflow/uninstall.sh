#!/bin/bash
set -e

echo "🔄 Uninstalling MLflow..."

if helm list | grep -q "mlflow"; then
  helm uninstall mlflow
  echo "✅ MLflow uninstalled successfully!"
else
  echo "⚠️ MLflow is not installed. Skipping uninstallation."
fi