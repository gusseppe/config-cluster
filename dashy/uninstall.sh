#!/bin/bash
set -e

echo "🔄 Uninstalling Dashy..."

if helm list | grep -q "dashy"; then
  helm uninstall dashy
  echo "✅ Dashy uninstalled successfully!"
else
  echo "⚠️ Dashy is not installed. Skipping uninstallation."
fi