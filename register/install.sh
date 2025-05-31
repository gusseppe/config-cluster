#!/bin/bash

# Function to display messages
print_message() {
    echo "🚀 $1"
}

# Function to handle errors
handle_error() {
    echo "❌ Error: $1"
    exit 1
}

# Main installation
print_message "Deploying Register service..."

# Apply Kubernetes manifests
kubectl apply -f register.yaml || handle_error "Failed to apply register.yaml"

print_message "✅ Register service deployed successfully!"