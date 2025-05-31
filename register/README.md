# Register Service Deployment Guide

A deployment configuration for the Register service, a machine learning model validation service that integrates with MLflow, Minio, and uses LLM capabilities through Ollama. All resources are deployed in the `agents` namespace and use images from your local registry.

## Prerequisites

- Kubernetes cluster
- kubectl configured with your cluster
- MLflow server running in the cluster (in the `agents` namespace)
- Minio S3 storage configured (in the `agents` namespace)
- Ollama service deployed (in the `agents` namespace)
- Local container registry (vcf-np-w2-harbor-az1.sunat.peru/agentes) with the required images pushed

## Directory Structure

```
register/
├── 1-pull_and_push.sh        # Script to pull, tag, and push the register image to your local registry
├── install.sh                # Installation script (applies register.yaml)
├── register.yaml             # Kubernetes manifests (Deployment & Service)
├── uninstall.sh              # Cleanup script
```

## Quick Start

1. Build and push the Register image to your local registry:
   ```bash
   chmod +x 1-pull_and_push.sh
   ./1-pull_and_push.sh
   ```
   This will pull, tag, and push the register-agent image to `vcf-np-w2-harbor-az1.sunat.peru/agentes`.

2. Deploy the Register service:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
   This will apply the Kubernetes manifests defined in `register.yaml` to the `agents` namespace.

3. (Optional) Uninstall:
   ```bash
   chmod +x uninstall.sh
   ./uninstall.sh
   ```

## Configuration

The deployment is configured through `register.yaml`, which contains:
- Deployment for the register service (in the `agents` namespace)
- LoadBalancer Service for external access (in the `agents` namespace)
- Uses image: `vcf-np-w2-harbor-az1.sunat.peru/agentes/register-agent:latest`

### Environment Variables

The service is configured with several environment variables:
- `MLFLOW_TRACKING_URI`: Connection to MLflow server (e.g. `http://mlflow.agents.svc.cluster.local:5001`)
- `MLFLOW_S3_ENDPOINT_URL`: Minio S3 endpoint for artifact storage (e.g. `http://minio.agents.svc.cluster.local:9000`)
- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`: Minio credentials
- `OPENAI_API_BASE_URLS`: Connection to Ollama service (e.g. `http://ollama-service:11434/v1`)
- `AGENT_LLM_NAME` and `RAG_LLM_NAME`: LLM model names (e.g. `llama3.2:3b`)

## Deployment Verification

After installation, verify the deployment using:
```bash
kubectl get pods -n agents -l app=register-agent
kubectl get svc -n agents register-agent
```

## Service Access

The service is exposed via LoadBalancer on port 8501. Access it at:
```
http://<load-balancer-ip>:8501
```

## Notes

- All resources are deployed in the `agents` namespace
- The service integrates with MLflow for model tracking and validation
- Uses Minio as S3-compatible storage for artifacts
- Connects to Ollama for LLM capabilities
- Runs on port 8501 (Streamlit default port)
- Container image is pulled from your local registry

## Dependencies

The service requires:
1. MLflow server for model tracking (in `agents` namespace)
2. Minio for artifact storage (in `agents` namespace)
3. Ollama for LLM model serving (in `agents` namespace)

## Troubleshooting

If you encounter issues:

1. Check pod status:
   ```bash
   kubectl get pods -n agents -l app=register-agent
   ```

2. View pod logs:
   ```bash
   kubectl logs -n agents -l app=register-agent
   ```

3. Verify service exposure:
   ```bash
   kubectl get svc -n agents register-agent
   ```

4. Check connectivity to dependencies:
   ```bash
   # Check MLflow
   kubectl get svc -n agents mlflow

   # Check Minio
   kubectl get svc -n agents minio

   # Check Ollama
   kubectl get svc -n agents ollama-service
   ```

## Resource Cleanup

The uninstall script will remove all resources defined in `register.yaml` from the `agents` namespace. For manual cleanup:
```bash
kubectl delete -n agents -f register.yaml
```

## Security Notes

- Minio credentials are specified in the deployment manifest
- The service uses LoadBalancer type for external access
- Images are pulled from your local registry (vcf-np-w2-harbor-az1.sunat.peru/agentes)