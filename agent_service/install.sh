#!/bin/bash
set -e

echo "🚀 Deploying Agent service..."

kubectl apply -f agent-service.yaml

echo "✅ Agent service deployed successfully!"
