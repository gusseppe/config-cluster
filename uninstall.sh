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

# Array of components in reverse order for safe uninstallation
COMPONENTS=("checker" "kubeai" "dashy" "ollama" "mlflow")

# Print uninstallation start
print_message "Starting uninstallation of all components..."

# Main uninstallation loop
for component in "${COMPONENTS[@]}"; do
    if [ -d "$component" ]; then
        print_message "Uninstalling $component..."
        
        # Navigate to component directory
        cd "$component" || handle_error "Failed to enter $component directory"
        
        # Check if uninstall script exists and is executable
        if [ -f "uninstall.sh" ]; then
            chmod +x uninstall.sh
            if ./uninstall.sh; then
                print_success "$component uninstalled successfully"
            else
                handle_error "Failed to uninstall $component"
            fi
        else
            print_warning "No uninstall.sh found in $component"
        fi
        
        # Return to root directory
        cd .. || handle_error "Failed to return to root directory"
    else
        print_warning "$component directory not found"
    fi
done

print_success "All components uninstalled successfully!"

# Print final verification instructions
print_message "You can verify the uninstallation by checking remaining resources:"
echo "
Verify no resources remain:
kubectl get pods -n default -l app=mlflow
kubectl get pods -n default -l app=ollama
kubectl get pods -n default -l app=checker-agent
kubectl get pods -n default -l app=dashy
kubectl get pods -n default -l app=kubeai
"