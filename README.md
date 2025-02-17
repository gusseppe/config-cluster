# AI/ML Infrastructure Deployment Guide

This repository contains multiple components for a comprehensive AI/ML infrastructure deployment. You can install all components at once or individually as needed.

## Prerequisites

Ensure you have the following installed on your system:
- Kubernetes cluster
- Helm
- Docker
- Harbor registry access
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
3. Dashy (Dashboard interface)
4. KubeAI (Kubernetes AI tools)
5. Checker (Model validation service)

## Quick Uninstallation

To uninstall all components:
```bash
chmod +x uninstall.sh
./uninstall.sh
```

This will uninstall the components in reverse order to ensure proper dependency handling.

## Individual Component Installation

### Checker Service
Provides model validation and LLM-based checking capabilities.
1. Navigate to the `checker` folder:
   ```bash
   cd checker
   ```
2. Run the installation script:
   ```bash
   ./install.sh
   ```
3. For more details, refer to `checker/README.md`.

### Dashy
Provides a dashboard for managing and monitoring applications.
1. Navigate to the `dashy` folder:
   ```bash
   cd dashy
   ```
2. Run the installation script:
   ```bash
   ./install.sh
   ```
3. For more details, refer to `dashy/README.md`.

### KubeAI
Deploys AI/ML workloads in Kubernetes environments.
1. Navigate to the `kubeai` folder:
   ```bash
   cd kubeai
   ```
2. Run the installation script:
   ```bash
   ./install.sh
   ```
3. For more details, refer to `kubeai/README.md`.

### MLflow
MLflow is a tool for managing ML experiments and models.
1. Navigate to the `mlflow` folder:
   ```bash
   cd mlflow
   ```
2. Run the installation script:
   ```bash
   ./install.sh
   ```
3. For more details, refer to `mlflow/README.md`.

### Ollama
Ollama is a lightweight AI model deployment framework.
1. Navigate to the `ollama` folder:
   ```bash
   cd ollama
   ```
2. Run the installation script:
   ```bash
   ./install.sh
   ```
3. For more details, refer to `ollama/README.md`.

## Component Dependencies

The installation order is important due to the following dependencies:
- Checker service requires:
  - MLflow for model tracking
  - Ollama for LLM capabilities
  - Minio for artifact storage
- Other components can be installed independently

## Service Access

After installation, services can be accessed at:
- MLflow: http://<load-balancer-ip>:5001
- Checker: http://<load-balancer-ip>:8501
- Dashy: http://<load-balancer-ip>:80
- Ollama: http://<load-balancer-ip>:11434

## Troubleshooting

If you encounter issues during installation:

1. Check the logs of the failed component:
   ```bash
   kubectl logs -l app=<component-name>
   ```

2. Verify pod status:
   ```bash
   kubectl get pods
   ```

3. Check service exposure:
   ```bash
   kubectl get svc
   ```

4. Verify component dependencies:
   ```bash
   # Check MLflow
   kubectl get svc mlflow
   
   # Check Ollama
   kubectl get svc ollama-service
   
   # Check Minio
   kubectl get svc minio
   ```

5. Check individual component README files for specific troubleshooting steps

6. Try uninstalling and reinstalling the failed component

## Additional Notes

- Each component may have specific configuration files that need adjustment before deployment
- All components pull images from the specified Harbor registry
- The installation scripts include error handling and status messages
- Components can be installed individually if you don't need the entire stack
- Each service is exposed via LoadBalancer by default
- Environment variables and configurations can be modified in each component's YAML files

This guide provides both quick installation methods and detailed individual component setup instructions. For in-depth details, always check the specific component documentation inside each folder.