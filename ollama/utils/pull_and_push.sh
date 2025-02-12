#!/bin/bash
set -euo pipefail

# Load configuration from the file "config"
if [ -f config ]; then
    source config
else
    echo "❌ Config file 'config' not found! Please create it and set the appropriate values."
    exit 1
fi

# Construct full image names from the configuration values
FULL_SOURCE_IMAGE="${SOURCE_REGISTRY}/${SOURCE_IMAGE}"
FULL_TARGET_IMAGE="${TARGET_REGISTRY}/${TARGET_IMAGE}"

echo "🚀 Steps to pull, tag, and push the Ollama image:"
echo "1. Pull the image from the source registry:"
echo "   docker pull ${FULL_SOURCE_IMAGE}"
echo
echo "2. Tag the image for the target registry:"
echo "   docker tag ${FULL_SOURCE_IMAGE} ${FULL_TARGET_IMAGE}"
echo
echo "3. Push the image to the target registry:"
echo "   docker push ${FULL_TARGET_IMAGE}"
echo

# Function to generate the Kubernetes deployment and service YAML
generate_ollama_yaml() {
    cat > ollama.yaml << EOF
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ollama-deployment
  labels:
    app: ollama
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ollama
  template:
    metadata:
      labels:
        app: ollama
    spec:
      containers:
      - name: ollama-container
        image: ${FULL_TARGET_IMAGE}
        ports:
        - containerPort: 11434
---
apiVersion: v1
kind: Service
metadata:
  name: ollama-service
spec:
  selector:
    app: ollama
  ports:
  - protocol: TCP
    port: 11434
    targetPort: 11434
  type: ClusterIP
EOF
}

echo "📄 Generating ollama.yaml..."
generate_ollama_yaml
echo "✅ ollama.yaml file generated successfully."
