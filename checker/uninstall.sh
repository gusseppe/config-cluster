#!/bin/bash

# Function to display messages
print_message() {
    echo "🔄 $1"
}

# Function to display success
print_success() {
    echo "✅ $1"
}

# Function to display warnings
print_warning() {
    echo "⚠️ $1"
}

# Function to handle errors
handle_error() {
    echo "❌ Error: $1"
    exit 1
}

# Main uninstallation
print_message "Uninstalling Checker service..."

# Check if resources exist and delete them
if kubectl get -f checker.yaml &>/dev/null; then
    kubectl delete -f checker.yaml || handle_error "Failed to delete checker.yaml resources"
    print_success "Checker service uninstalled successfully!"
else
    print_warning "Checker service resources not found. Skipping uninstallation."
fi