# MLflow Deployment Guide

A collection of scripts and configurations to deploy and manage MLflow, a platform for the machine learning lifecycle.

## Prerequisites

- Kubernetes cluster
- Helm
- kubectl configured with your cluster

## Directory Structure

```
mlflow/
├── utils/                          # Utility scripts and references
├── install.sh                      # Installation script
├── mlflow-0.7.13.tgz              # Helm chart
├── config-mlflow.yaml             # MLflow configuration values
└── uninstall.sh                   # Cleanup script
```

## Quick Start

1. Install MLflow:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
   This will:
   - Deploy MLflow using the local Helm chart (version 0.7.13)
   - Apply configurations from config-mlflow.yaml
   - Wait for deployment completion
   - Display deployment status

2. (Optional) Uninstall:
   ```bash
   chmod +x uninstall.sh
   ./uninstall.sh
   ```

## Configuration

MLflow is configured using `config-mlflow.yaml`, which contains:
- Deployment settings
- Service configurations
- Storage settings
- Additional MLflow-specific parameters

## Deployment Verification

After installation, the script automatically checks the deployment status using:
```bash
helm status mlflow
```

## Notes

- The deployment uses the `--cleanup-on-fail` flag for automatic cleanup in case of failure
- All scripts include error handling and status messages
- The `utils/` directory contains reference files (not required for deployment)
- The installation uses Helm with the `--wait` flag to ensure complete deployment

## Troubleshooting

If you encounter issues:
1. Check the deployment status: `helm status mlflow`
2. View the pod logs: `kubectl logs -l app=mlflow`
3. Ensure all configuration values in `config-mlflow.yaml` are correct
4. If needed, use the uninstall script and retry the installation