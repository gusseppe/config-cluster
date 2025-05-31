#!/bin/bash
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo -e "${GREEN}Uninstalling MLflow chart...${NC}"
helm uninstall mlflow --namespace agents
sleep 2

echo -e "${GREEN}Uninstalling Minio chart...${NC}"
helm uninstall minio --namespace agents
sleep 2

echo -e "${GREEN}Uninstalling PostgreSQL chart...${NC}"
helm uninstall postgresql --namespace agents
sleep 2

echo -e "${YELLOW}Helm releases have been uninstalled. Persistent volumes and PVCs remain intact.${NC}"
