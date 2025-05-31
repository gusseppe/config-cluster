# MLflow, PostgreSQL, and MinIO Deployment Guide

A collection of scripts and configurations to deploy and manage MLflow, PostgreSQL, and MinIO using Helm and Kubernetes.

## Prerequisites

- Kubernetes cluster
- Helm
- kubectl configured with your cluster

## Directory Structure

```
mlflow/
├── 1-pull_and_push.sh              # Script to pull and push images
├── install.sh                    # Main installation script
├── uninstall.sh                    # Cleanup script
├── README.md                       # This documentation
├── config-mlflow.yaml              # MLflow configuration values
├── config-minio.yaml               # MinIO configuration values
├── config-postgresql.yaml          # PostgreSQL configuration values
├── minio-11.10.9.tgz               # MinIO Helm chart
├── mlflow-0.7.13.tgz               # MLflow Helm chart
├── postgresql-11.9.11.tgz          # PostgreSQL Helm chart
├── minio-pvc.yaml                  # MinIO PersistentVolumeClaim
├── minio-volume.yaml               # MinIO PersistentVolume
├── pg-pvc.yaml                     # PostgreSQL PersistentVolumeClaim
├── pg-volume.yaml                  # PostgreSQL PersistentVolume
```

## Quick Start

1. Install PostgreSQL, MinIO, and MLflow:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
   This will:
   - Deploy PostgreSQL, MinIO, and MLflow using local Helm charts
   - Apply configurations from their respective config YAML files
   - Create PersistentVolumes and PersistentVolumeClaims
   - Wait for deployment completion
   - Display deployment status for each component

2. (Optional) Uninstall:
   ```bash
   chmod +x uninstall.sh
   ./uninstall.sh
   ```
   This will uninstall the Helm releases for MLflow, MinIO, and PostgreSQL, but will leave persistent volumes and claims intact.

## Configuration

Each component is configured using its respective YAML file:
- `config-mlflow.yaml`: MLflow settings
- `config-minio.yaml`: MinIO settings (including PVC name and storage)
- `config-postgresql.yaml`: PostgreSQL settings

PersistentVolumes and PersistentVolumeClaims are defined in:
- `pg-volume.yaml`, `pg-pvc.yaml` (PostgreSQL)
- `minio-volume.yaml`, `minio-pvc.yaml` (MinIO)

## Deployment Verification

After installation, the script automatically checks the deployment status using:
```bash
helm status postgresql --namespace agents
helm status minio --namespace agents
helm status mlflow --namespace agents
```

## Notes

- The deployment uses the `--cleanup-on-fail` flag for automatic cleanup in case of failure
- All scripts include error handling and status messages
- All resources are deployed in the `agents` namespace

## Troubleshooting

If you encounter issues:
1. Check the deployment status: `helm status <release> --namespace agents`
2. View the pod logs: `kubectl logs -n agents -l app=<component>`
3. Ensure all configuration values in the YAML files are correct
4. If needed, use the uninstall script and retry the installation