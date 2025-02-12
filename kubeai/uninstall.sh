#!/bin/bash
set -e

echo "🔄 Uninstalling KubeAI Engine..."

if helm list | grep -q "kubeai"; then
  helm uninstall kubeai
  echo "✅ KubeAI Engine uninstalled successfully!"
else
  echo "⚠️ KubeAI is not installed. Skipping uninstallation."
fi