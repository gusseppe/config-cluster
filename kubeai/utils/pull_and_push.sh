#!/bin/bash
set -e

# Configuration
CUSTOM_REGISTRY="vcf-np-w2-harbor-az1.sunat.peru/agentes"

# Version configurations
KUBEAI_VERSION="v0.14.0"
VLLM_VERSION="v0.6.3.post1"
WEBUI_VERSION="v0.5.7"
OLLAMA_VERSION="0.5.7"

# Base image names and their new names in your registry
KUBEAI_BASE="docker.io/substratusai/kubeai"
LOADER_BASE="docker.io/substratusai/kubeai-model-loader"
VLLM_BASE="docker.io/substratusai/vllm"
WEBUI_BASE="ghcr.io/open-webui/open-webui"
OLLAMA_BASE="docker.io/ollama/ollama"

# New image names
NEW_KUBEAI="kubeai"
NEW_LOADER="kubeai-model-loader"
NEW_VLLM="vllm"
NEW_WEBUI="open-webui"
NEW_OLLAMA="ollama"

# List of images to migrate: "original_image new_image"
IMAGES=(
  "${KUBEAI_BASE}:${KUBEAI_VERSION} ${CUSTOM_REGISTRY}/${NEW_KUBEAI}:${KUBEAI_VERSION}"
  "${LOADER_BASE}:${KUBEAI_VERSION} ${CUSTOM_REGISTRY}/${NEW_LOADER}:${KUBEAI_VERSION}"
  "${VLLM_BASE}:${VLLM_VERSION}-cpu ${CUSTOM_REGISTRY}/${NEW_VLLM}:${VLLM_VERSION}-cpu"
  "${WEBUI_BASE}:${WEBUI_VERSION} ${CUSTOM_REGISTRY}/${NEW_WEBUI}:${WEBUI_VERSION}"
  "${OLLAMA_BASE}:${OLLAMA_VERSION} ${CUSTOM_REGISTRY}/${NEW_OLLAMA}:${OLLAMA_VERSION}"
)

# Function to print and execute docker commands
migrate_images() {
  echo "🚀 Docker commands for migrating images to ${CUSTOM_REGISTRY}:"
  echo
  
  for entry in "${IMAGES[@]}"; do
    read -r ORIGINAL NEW_IMAGE <<< "$entry"
    
    echo "----------------------------------------"
    echo "For image: ${ORIGINAL}"
    echo
    echo "1. Pull the image from source registry:"
    echo "   docker pull ${ORIGINAL}"
    echo
    echo "2. Tag the image for target registry:"
    echo "   docker tag ${ORIGINAL} ${NEW_IMAGE}"
    echo
    echo "3. Push the image to target registry:"
    echo "   docker push ${NEW_IMAGE}"
    echo
    

  done

}

migrate_images
