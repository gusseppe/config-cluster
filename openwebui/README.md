# Open WebUI Deployment (Kubernetes, Helm, Local Registry)

## Overview
Open WebUI is deployed as part of the multi-component AI/ML stack using Kubernetes and Helm, with all images sourced from a local container registry. This deployment is designed for local or air-gapped environments and is fully namespace-isolated under `agents`.

## Prerequisites
- Kubernetes cluster (v1.24+ recommended)
- Helm (v3+)
- Local container registry accessible at `vcf-np-w2-harbor-az1.sunat.peru/agentes`
- `kubectl` and `docker` CLI tools
- The `agents` namespace must exist (created by the top-level install script)

## Images Used
- `vcf-np-w2-harbor-az1.sunat.peru/agentes/open-webui:v0.6.9` (main WebUI)
- `vcf-np-w2-harbor-az1.sunat.peru/agentes/ollama:latest` (if embedded Ollama enabled)
- Redis and other dependencies are pulled as needed

## Configuration
- All configuration is managed via `config-openwebui.yaml` in this folder.
- The deployment uses the `agents` namespace and local registry images by default.
- Service is exposed as a `LoadBalancer` on port 30080 (see `service` section in config).
- Environment variables and advanced options (SSO, storage, persistence, etc.) are set in the config file.

## Install
Run from the `config-local/openwebui` directory or from the top-level `config-local` folder:

```bash
./install.sh
```

Or, from the top-level config-local folder to install all components in order:

```bash
./install.sh
```

This will:
- Pull and push required images to the local registry
- Deploy Open WebUI using Helm with the provided configuration

## Uninstall
To remove the deployment:

```bash
./uninstall.sh
```

## Customization
- Edit `config-openwebui.yaml` to adjust environment variables, storage, SSO, or other settings.
- To use an external Ollama instance, set `ollama.enabled: false` and provide `ollamaUrls`.
- For persistent storage, set `persistence.enabled: true` and configure the storage class/size.

## Access
- The service is exposed as a LoadBalancer on port 30080 by default. Use `kubectl get svc -n agents` to find the external IP/hostname.
- Default authentication is disabled (`WEBUI_AUTH: False`), but can be enabled/configured in the config file.

## Notes
- All images must be present in the local registry before install (handled by `1-pull_and_push.sh`).
- This deployment is intended for local, development, or air-gapped environments.
- For advanced configuration, see comments in `config-openwebui.yaml` and the [Open WebUI documentation](https://docs.openwebui.com/).

## Folder Contents
- `install.sh` / `uninstall.sh`: Install/uninstall scripts for this component
- `1-pull_and_push.sh`: Pulls images and pushes to local registry
- `config-openwebui.yaml`: Main Helm values/config file

---
For questions or troubleshooting, see the top-level `README.md` or contact the deployment maintainer.
