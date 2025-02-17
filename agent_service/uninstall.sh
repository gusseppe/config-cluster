#!/bin/bash
set -e

echo "🔄 Uninstalling Agent Service..."

if kubectl get -f checker-agent.yaml &>/dev/null; then
  kubectl delete -f checker-agent.yaml
  echo "✅ Agent service uninstalled successfully!"
else
  echo "⚠️ Agent service resources not found. Skipping uninstallation."
fi
