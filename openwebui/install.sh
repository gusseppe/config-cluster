#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'



# Ensure namespace exists
echo -e "${GREEN}Creating namespace 'agents' if it does not exist...${NC}"
kubectl get namespace agents || kubectl create namespace agents

# Instalar chart de Open WebUI
WEBUI_CHART="open-webui-6.15.0.tgz"
WEBUI_RELEASE="open-webui"
WEBUI_VALUES="config-openwebui.yaml"
echo "${GREEN}Instalando chart de Open WebUI...${NC}"
helm upgrade --cleanup-on-fail --install $WEBUI_RELEASE ./$WEBUI_CHART --values $WEBUI_VALUES --namespace agents
sleep 10
echo "Output de helm status $WEBUI_RELEASE:"
helm status $WEBUI_RELEASE --namespace agents
