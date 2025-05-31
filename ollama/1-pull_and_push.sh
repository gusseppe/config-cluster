#!/bin/bash
set -euo pipefail

# Source and target image definitions
SOURCE_IMAGE="docker.io/gusseppe/ollama:latest"
TARGET_IMAGE="vcf-np-w2-harbor-az1.sunat.peru/agentes/ollama:latest"

# Pull, tag, and push the image
echo "🚀 Steps to pull, tag, and push the Ollama image:"
echo "1. Pull the image from the source registry:"
echo "   docker pull --platform=linux/amd64 ${SOURCE_IMAGE}"
#docker pull --platform=linux/amd64 "${SOURCE_IMAGE}"
echo

echo "2. Tag the image for the target registry:"
echo "   docker tag ${SOURCE_IMAGE} ${TARGET_IMAGE}"
#docker tag "${SOURCE_IMAGE}" "${TARGET_IMAGE}"
echo

echo "3. Push the image to the target registry:"
echo "   docker push ${TARGET_IMAGE}"
#docker push "${TARGET_IMAGE}"
echo
