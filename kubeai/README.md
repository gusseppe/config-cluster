# KubeAI Deployment Guide

A collection of scripts and configurations to deploy and manage KubeAI, an AI model serving platform on Kubernetes.

## Prerequisites

- Kubernetes cluster
- Helm
- kubectl configured with your cluster
- Access to the specified container registry (vcf-np-w2-harbor-az1.sunat.peru)

## Directory Structure

```
kubeai/
├── utils/                          # Image build utilities (reference only)
├── install.sh                      # Installation script
├── kubeai-0.12.0.tgz              # Helm chart
├── kubeai-engine-values.yaml      # Configuration values
└── uninstall.sh                   # Cleanup script
```

## Quick Start

1. Install KubeAI:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
   This deploys KubeAI with:
   - Custom images from private registry
   - OpenWebUI configured with LoadBalancer service
   - MinIO credentials for storage
   - Additional configurations from kubeai-engine-values.yaml

2. (Optional) Uninstall:
   ```bash
   chmod +x uninstall.sh
   ./uninstall.sh
   ```

## Components

The deployment includes:
- KubeAI core (v0.14.0)
- KubeAI Model Loader
- VLLM CPU Model Server
- OpenWebUI (v0.5.7)

## Configuration

### Service Configuration
- OpenWebUI is exposed via LoadBalancer on port 30080
- Custom configuration values are defined in `kubeai-engine-values.yaml`


### Images
All images are pulled from the private registry:
- KubeAI: vcf-np-w2-harbor-az1.sunat.peru/agentes/kubeai:v0.14.0
- Model Loader: vcf-np-w2-harbor-az1.sunat.peru/agentes/kubeai-model-loader:v0.14.0
- VLLM CPU: vcf-np-w2-harbor-az1.sunat.peru/agentes/vllm:v0.6.3.post1-cpu
- OpenWebUI: vcf-np-w2-harbor-az1.sunat.peru/agentes/open-webui:v0.5.7

## Notes

- The `utils/` directory contains reference files for image building (not required for deployment)
- All scripts include error handling and status messages
- The installation uses Helm with the `--wait` flag to ensure complete deployment