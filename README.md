# AI/ML Infrastructure Deployment Guide

This repository contains multiple components for a comprehensive AI/ML infrastructure deployment. You can install all components at once or individually as needed.

## Prerequisites

Ensure you have the following installed on your system:
- Kubernetes cluster
- Helm
- Docker
- Local container registry (harbor) with required images pushed
- Necessary permissions to deploy applications

## Quick Installation

To install all components at once:
```bash
chmod +x install.sh
./install.sh
```

This will install the components in the following order:
1. MLflow (Model tracking and registry)
2. Ollama (AI model serving)
3. Open WebUI (Web interface for LLMs)
4. Register (Model validation service)
5. Dashy (Dashboard interface)

## Quick Uninstallation

To uninstall all components:
```bash
chmod +x uninstall.sh
./uninstall.sh
```

This will uninstall the components in reverse order to ensure proper dependency handling.

## Individual Component Installation

Each component can be installed individually by navigating to its folder and running its install script:

### MLflow
1. `cd mlflow`
2. `./install.sh`
3. See `mlflow/README.md` for details.

### Ollama
1. `cd ollama`
2. `./install.sh`
3. See `ollama/README.md` for details.

### Open WebUI
1. `cd openwebui`
2. `./install.sh`
3. See `openwebui/README.md` for details.

### Register Service
1. `cd register`
2. `./install.sh`
3. See `register/README.md` for details.

### Dashy
1. `cd dashy`
2. `./install.sh`
3. See `dashy/README.md` for details.

## Component Dependencies

The installation order is important due to the following dependencies:
- Register service requires:
  - MLflow for model tracking
  - Ollama for LLM capabilities
  - Minio for artifact storage (deployed with MLflow)
- Other components can be installed independently

## Service Access

After installation, services can be accessed at their respective LoadBalancer IPs/hostnames and ports (see each component's README for details).

## Troubleshooting

If you encounter issues during installation:

1. Check the logs of the failed component:
   ```bash
   kubectl logs -n agents -l app=<component-name>
   ```
2. Verify pod status:
   ```bash
   kubectl get pods -n agents
   ```
3. Check service exposure:
   ```bash
   kubectl get svc -n agents
   ```
4. Verify component dependencies:
   ```bash
   kubectl get svc -n agents mlflow
   kubectl get svc -n agents ollama-service
   kubectl get svc -n agents minio
   ```
5. Check individual component README files for specific troubleshooting steps
6. Try uninstalling and reinstalling the failed component

## Additional Notes

- Each component may have specific configuration files that need adjustment before deployment
- All components pull images from your local registry (vcf-np-w2-harbor-az1.sunat.peru/agentes)
- The installation scripts include error handling and status messages
- Components can be installed individually if you don't need the entire stack
- Each service is exposed via LoadBalancer by default
- Environment variables and configurations can be modified in each component's YAML files

This guide provides both quick installation methods and detailed individual component setup instructions. For in-depth details, always check the specific component documentation inside each folder.