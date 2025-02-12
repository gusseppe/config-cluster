# Ollama Deployment Guide

A collection of scripts and configurations to deploy and manage Ollama, an AI model serving platform, on Kubernetes.

## Prerequisites

- Kubernetes cluster
- kubectl configured with your cluster

## Directory Structure

```
ollama/
├── utils/                  # Utility scripts and references
├── install.sh             # Installation script
├── ollama.yaml           # Kubernetes manifests
└── uninstall.sh          # Cleanup script
```

## Quick Start

1. Install Ollama:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
   This will apply the Kubernetes manifests defined in `ollama.yaml`

2. (Optional) Uninstall:
   ```bash
   chmod +x uninstall.sh
   ./uninstall.sh
   ```

## Configuration

The deployment is configured through `ollama.yaml`, which contains all necessary Kubernetes resources including:
- Deployments
- Services
- ConfigMaps (if any)
- Other required resources

## Deployment Verification

After installation, you can verify the deployment using:
```bash
kubectl get pods -l app=ollama
kubectl get svc -l app=ollama
```

## Notes

- Unlike other components, Ollama uses direct Kubernetes manifests instead of Helm
- All scripts include error handling and status messages
- The `utils/` directory contains reference files (not required for deployment)

## Troubleshooting

If you encounter issues:
1. Check pod status:
   ```bash
   kubectl get pods -l app=ollama
   ```
2. View pod logs:
   ```bash
   kubectl logs -l app=ollama
   ```
3. Check service status:
   ```bash
   kubectl get svc -l app=ollama
   ```
4. If needed, use the uninstall script and retry the installation

## Resource Cleanup

The uninstall script will remove all resources defined in `ollama.yaml`. If you need to manually clean up:
```bash
kubectl delete -f ollama.yaml
```