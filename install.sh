#!/bin/bash

# Function to display messages
print_message() {
    echo "🚀 $1"
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

# Array of components in installation order
COMPONENTS=("mlflow" "ollama" "dashy" "kubeai" "checker")

# Print installation start
print_message "Starting installation of all components..."

# Main installation loop
for component in "${COMPONENTS[@]}"; do
    if [ -d "$component" ]; then
        print_message "Installing $component..."
        
        # Navigate to component directory
        cd "$component" || handle_error "Failed to enter $component directory"
        
        # Check if install script exists and is executable
        if [ -f "install.sh" ]; then
            chmod +x install.sh
            if ./install.sh; then
                print_success "$component installed successfully"
            else
                handle_error "Failed to install $component"
            fi
        else
            print_warning "No install.sh found in $component"
        fi
        
        # Return to root directory
        cd .. || handle_error "Failed to return to root directory"
    else
        print_warning "$component directory not found"
    fi
done

print_success "All components installed successfully!"

# Print final instructions
print_message "You can verify the installations by checking each component's status:"
echo "
Check component status:
kubectl get pods -n default -l app=mlflow
kubectl get pods -n default -l app=ollama
kubectl get pods -n default -l app=checker-agent
kubectl get pods -n default -l app=dashy
kubectl get pods -n default -l app=kubeai
"