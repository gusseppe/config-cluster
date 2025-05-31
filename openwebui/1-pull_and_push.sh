#!/bin/bash
set -euo pipefail

# --- Open WebUI ---
WEBUI_SOURCE_IMAGE="ghcr.io/open-webui/open-webui:v0.6.9"
WEBUI_TARGET_IMAGE="vcf-np-w2-harbor-az1.sunat.peru/agentes/open-webui:v0.6.9"

# --- Ollama ---
OLLAMA_SOURCE_IMAGE="gusseppe/ollama:latest"
# OLLAMA_SOURCE_IMAGE="ollama/ollama:0.7.0"
OLLAMA_TARGET_IMAGE="vcf-np-w2-harbor-az1.sunat.peru/agentes/ollama:latest"
# OLLAMA_TARGET_IMAGE="vcf-np-w2-harbor-az1.sunat.peru/agentes/ollama:0.7.0"

# Helper function to pull, tag, and push an image
# Uses --platform=linux/amd64 for compatibility

docker_pull_tag_push() {
    local src_img="$1"
    local tgt_img="$2"
    echo "🚀 Steps to pull, tag, and push the image:"
    echo "1. Pull the image from the source registry:"
    echo "   docker pull ${src_img}"
    echo
    echo "2. Tag the image for the target registry:"
    echo "   docker tag ${src_img} ${tgt_img}"
    echo
    echo "3. Push the image to the target registry:"
    echo "   docker push ${tgt_img}"
    echo
    echo "⚡ Executing commands..."
    # docker pull --platform=linux/amd64 "${src_img}"
    # docker tag "${src_img}" "${tgt_img}"
    # docker push "${tgt_img}"
    echo
}

# Open WebUI
docker_pull_tag_push "$WEBUI_SOURCE_IMAGE" "$WEBUI_TARGET_IMAGE"

# Ollama
docker_pull_tag_push "$OLLAMA_SOURCE_IMAGE" "$OLLAMA_TARGET_IMAGE"
