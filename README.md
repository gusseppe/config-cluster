# Installation Guide

This repository contains multiple components, each with its own installation and setup process. Below are the steps to install each component. Inside each respective folder, you will find a detailed README.md with further instructions.

## Prerequisites

Ensure you have the following installed on your system:
- Kubernetes cluster (if required by components)
- Helm
- Docker
- Necessary permissions to deploy applications

## Components Installation

### Dashy
Dashy provides a dashboard for managing and monitoring applications.

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
KubeAI deploys AI/ML workloads in Kubernetes environments.

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

## Uninstallation
To remove any installed component, navigate to its respective folder and run:
```bash
./uninstall.sh
```

## Additional Notes
- Each component may have specific configuration files that need adjustment before deployment.
- Refer to the individual `README.md` files for advanced configuration options.

This guide provides a high-level overview of setting up the components. For in-depth details, always check the specific component documentation inside each folder.

