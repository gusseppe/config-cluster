#!/bin/bash
set -e

echo "🔄 Uninstalling Dashy from agents namespace..."

if helm list -n agents | grep -q "dashy"; then
  helm uninstall dashy -n agents
  echo "✅ Dashy uninstalled successfully from agents namespace!"
else
  echo "⚠️ Dashy is not installed in agents namespace. Skipping uninstallation."
fi