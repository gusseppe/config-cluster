#!/bin/bash
set -euo pipefail

# Source and target image definitions from config file
SOURCE_REGISTRY="docker.io/lissy93"
SOURCE_IMAGE="dashy:release-3.1.1"

TARGET_REGISTRY="vcf-np-w2-harbor-az1.sunat.peru/agentes"
TARGET_IMAGE="dashy:release-3.1.1"

FULL_SOURCE_IMAGE="${SOURCE_REGISTRY}/${SOURCE_IMAGE}"
FULL_TARGET_IMAGE="${TARGET_REGISTRY}/${TARGET_IMAGE}"

echo "🚀 Steps to pull, tag, and push the Dashy image:"
echo "1. Pull the image from the source registry:"
echo "   docker pull --platform=linux/amd64 ${FULL_SOURCE_IMAGE}"
docker pull --platform=linux/amd64 "${FULL_SOURCE_IMAGE}"
echo

echo "2. Tag the image for the target registry:"
echo "   docker tag ${FULL_SOURCE_IMAGE} ${FULL_TARGET_IMAGE}"
docker tag "${FULL_SOURCE_IMAGE}" "${FULL_TARGET_IMAGE}"
echo

echo "3. Push the image to the target registry:"
echo "   docker push ${FULL_TARGET_IMAGE}"
docker push "${FULL_TARGET_IMAGE}"
echo