#!/bin/bash
set -euo pipefail

# Image configurations for mlflow, minio, postgresql, and bitnami-shell

# --- MLflow ---
MLFLOW_SOURCE_REGISTRY="docker.io/burakince"
MLFLOW_SOURCE_IMAGE="mlflow:2.20.1"
MLFLOW_TARGET_REGISTRY="vcf-np-w2-harbor-az1.sunat.peru/agentes"
MLFLOW_TARGET_IMAGE="mlflow:2.20.1"

# --- Minio ---
MINIO_SOURCE_REGISTRY="docker.io/bitnami"
MINIO_SOURCE_IMAGE="minio:2022.10.8-debian-11-r0"
MINIO_TARGET_REGISTRY="vcf-np-w2-harbor-az1.sunat.peru/agentes"
MINIO_TARGET_IMAGE="minio:2022.10.8-debian-11-r0"

# --- PostgreSQL ---
POSTGRES_SOURCE_REGISTRY="docker.io/bitnami"
POSTGRES_SOURCE_IMAGE="postgresql:11.9.0-debian-10-r75"
POSTGRES_TARGET_REGISTRY="vcf-np-w2-harbor-az1.sunat.peru/agentes"
POSTGRES_TARGET_IMAGE="postgresql:11.9.0-debian-10-r75"

# --- Bitnami Shell ---
BITNAMI_SHELL_SOURCE_REGISTRY="docker.io/bitnami"
BITNAMI_SHELL_SOURCE_IMAGE="bitnami-shell:11-debian-11-r38"
BITNAMI_SHELL_TARGET_REGISTRY="vcf-np-w2-harbor-az1.sunat.peru/agentes"
BITNAMI_SHELL_TARGET_IMAGE="bitnami-shell:11-debian-11-r38"

# Helper function to pull, tag, and push an image
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
    #docker pull "${src_img}"
    #docker tag "${src_img}" "${tgt_img}"
    #docker push "${tgt_img}"
    echo
}

# Process all images

# MLflow
MLFLOW_FULL_SOURCE_IMAGE="${MLFLOW_SOURCE_REGISTRY}/${MLFLOW_SOURCE_IMAGE}"
MLFLOW_FULL_TARGET_IMAGE="${MLFLOW_TARGET_REGISTRY}/${MLFLOW_TARGET_IMAGE}"
docker_pull_tag_push "$MLFLOW_FULL_SOURCE_IMAGE" "$MLFLOW_FULL_TARGET_IMAGE"

# Minio
MINIO_FULL_SOURCE_IMAGE="${MINIO_SOURCE_REGISTRY}/${MINIO_SOURCE_IMAGE}"
MINIO_FULL_TARGET_IMAGE="${MINIO_TARGET_REGISTRY}/${MINIO_TARGET_IMAGE}"
docker_pull_tag_push "$MINIO_FULL_SOURCE_IMAGE" "$MINIO_FULL_TARGET_IMAGE"

# PostgreSQL
POSTGRES_FULL_SOURCE_IMAGE="${POSTGRES_SOURCE_REGISTRY}/${POSTGRES_SOURCE_IMAGE}"
POSTGRES_FULL_TARGET_IMAGE="${POSTGRES_TARGET_REGISTRY}/${POSTGRES_TARGET_IMAGE}"
docker_pull_tag_push "$POSTGRES_FULL_SOURCE_IMAGE" "$POSTGRES_FULL_TARGET_IMAGE"

# Bitnami Shell
BITNAMI_SHELL_FULL_SOURCE_IMAGE="${BITNAMI_SHELL_SOURCE_REGISTRY}/${BITNAMI_SHELL_SOURCE_IMAGE}"
BITNAMI_SHELL_FULL_TARGET_IMAGE="${BITNAMI_SHELL_TARGET_REGISTRY}/${BITNAMI_SHELL_TARGET_IMAGE}"
docker_pull_tag_push "$BITNAMI_SHELL_FULL_SOURCE_IMAGE" "$BITNAMI_SHELL_FULL_TARGET_IMAGE"
