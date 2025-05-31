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

# Array of components in installation order (no kubeai)
COMPONENTS=("mlflow" "ollama" "openwebui" "register" "dashy")

print_message "Starting installation of all components..."

for component in "${COMPONENTS[@]}"; do
    if [ -d "$component" ]; then
        print_message "Installing $component..."
        cd "$component" || handle_error "Failed to enter $component directory"

        # Only use install.sh
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

        cd .. || handle_error "Failed to return to root directory"
    else
        print_warning "$component directory not found"
    fi

done

print_success "All components installed successfully!"