# Dashy Deployment Guide

A collection of scripts to deploy and manage Dashy, a configurable dashboard for your applications.

## Prerequisites

- Kubernetes cluster
- Helm
- kubectl configured with your cluster
- jq (for service discovery)

## Directory Structure

```
dashy/
├── utils/
├── 1-generate-dashy-override.sh    # Generates dashboard configuration
├── dashy-1.0.0.tgz                 # Helm chart
├── dashy-override.yaml             # Auto-generated config
├── dashy-values.yaml               # Base values
├── install.sh                      # Installation script
├── loadbalancer-services.txt       # Service discovery output
└── uninstall.sh                    # Cleanup script
```

## Quick Start

1. Generate Dashboard Configuration:
   ```bash
   chmod +x 1-generate-dashy-override.sh
   ./1-generate-dashy-override.sh
   ```
   This script discovers LoadBalancer services and generates `dashy-override.yaml`.

2. Install Dashy:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
   Deploys Dashy using the local Helm chart and custom configuration.

3. (Optional) Uninstall:
   ```bash
   chmod +x uninstall.sh
   ./uninstall.sh
   ```

## Configuration Files

- `dashy-values.yaml`: Base Helm chart values
- `dashy-override.yaml`: Auto-generated configuration based on your LoadBalancer services
- `loadbalancer-services.txt`: List of discovered services with their IPs and ports

## Notes

- The dashboard is configured with a material theme
- Service discovery is automatic for LoadBalancer type services
- All scripts include error handling and status messages
- The installation uses a local image from `vcf-np-w2-harbor-az1.sunat.peru/agentes/dashy:release-3.1.1`