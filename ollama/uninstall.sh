#!/bin/bash
set -e

echo "🔄 Uninstalling Ollama..."

if kubectl get -f ollama.yaml &>/dev/null; then
  kubectl delete -f ollama.yaml
  echo "✅ Ollama uninstalled successfully!"
else
  echo "⚠️ Ollama resources not found. Skipping uninstallation."
fi
