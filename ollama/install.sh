#!/bin/bash
set -e

echo "🚀 Deploying Ollama..."

kubectl apply -f ollama.yaml

echo "✅ Ollama deployed successfully!"