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
print_message "Deploying Checker service..."

# Apply Kubernetes manifests
kubectl apply -f checker.yaml || handle_error "Failed to apply checker.yaml"

print_message "✅ Checker service deployed successfully!"