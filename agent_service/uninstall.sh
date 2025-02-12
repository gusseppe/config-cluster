#!/bin/bash
set -e

echo "🔄 Uninstalling Agent Service..."

if kubectl get -f agent-service.yaml &>/dev/null; then
  kubectl delete -f agent-service.yaml
  echo "✅ Agent service uninstalled successfully!"
else
  echo "⚠️ Agent service resources not found. Skipping uninstallation."
fi
