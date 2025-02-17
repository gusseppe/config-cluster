#!/bin/bash
set -e

echo "🚀 Deploying Agent service..."

kubectl apply -f checker-agent.yaml

echo "✅ Agent service deployed successfully!"
