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

echo "🚀 Steps to pull, tag, and push the Dashy image:"
echo "1. Pull the image from the source registry:"
echo "   docker pull ${FULL_SOURCE_IMAGE}"
echo
echo "2. Tag the image for the target registry:"
echo "   docker tag ${FULL_SOURCE_IMAGE} ${FULL_TARGET_IMAGE}"
echo
echo "3. Push the image to the target registry:"
echo "   docker push ${FULL_TARGET_IMAGE}"
echo