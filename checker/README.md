# Checker Service Deployment Guide

A deployment configuration for the Checker service, a machine learning model validation service that integrates with MLflow and uses LLM capabilities through Ollama.

## Prerequisites

- Kubernetes cluster
- kubectl configured with your cluster
- Access to the specified Harbor registry
- MLflow server running in the cluster
- Minio S3 storage configured
- Ollama service deployed

## Directory Structure

```
checker/
├── utils/                  # Utility scripts and references
├── checker.yaml           # Kubernetes manifests
├── install.sh             # Installation script
└── uninstall.sh          # Cleanup script
```

## Quick Start

1. Install the Checker service:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
   This will apply the Kubernetes manifests defined in `checker.yaml`

2. (Optional) Uninstall:
   ```bash
   chmod +x uninstall.sh
   ./uninstall.sh
   ```

## Configuration

The deployment is configured through `checker.yaml`, which contains the following Kubernetes resources:
- Deployment configuration for the checker service
- LoadBalancer Service for external access

### Environment Variables

The service is configured with several environment variables:
- `MLFLOW_TRACKING_URI`: Connection to MLflow server
- `MLFLOW_S3_ENDPOINT_URL`: Minio S3 endpoint for artifact storage
- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`: Minio credentials
- `OPENAI_API_BASE_URLS`: Connection to Ollama service
- `MODEL_NAME`: Specific LLM model to use (default: llama3.2:1b)

## Deployment Verification

After installation, verify the deployment using:
```bash
kubectl get pods -l app=checker-agent
kubectl get svc checker-agent
```

## Service Access

The service is exposed via LoadBalancer on port 8501. You can access it at:
```
http://<load-balancer-ip>:8501
```

## Notes

- The service integrates with MLflow for model tracking and validation
- Uses Minio as S3-compatible storage for artifacts
- Connects to Ollama for LLM capabilities
- Runs on port 8501 (Streamlit default port)
- Container image is pulled from Harbor registry

## Dependencies

The service requires:
1. MLflow server for model tracking
2. Minio for artifact storage
3. Ollama for LLM model serving

## Troubleshooting

If you encounter issues:

1. Check pod status:
   ```bash
   kubectl get pods -l app=checker-agent
   ```

2. View pod logs:
   ```bash
   kubectl logs -l app=checker-agent
   ```

3. Verify service exposure:
   ```bash
   kubectl get svc checker-agent
   ```

4. Check connectivity to dependencies:
   ```bash
   # Check MLflow
   kubectl get svc mlflow

   # Check Minio
   kubectl get svc minio

   # Check Ollama
   kubectl get svc ollama-service
   ```

## Resource Cleanup

The uninstall script will remove all resources defined in `checker.yaml`. For manual cleanup:
```bash
kubectl delete -f checker.yaml
```

## Security Notes

- Minio credentials are specified in the deployment manifest
- The service uses LoadBalancer type for external access
- Harbor registry access may require proper authentication