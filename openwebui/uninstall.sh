#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

WEBUI_RELEASE="open-webui"

echo -e "${GREEN}Uninstalling Open WebUI chart from namespace 'agents'...${NC}"

if helm list --namespace agents | grep -q "$WEBUI_RELEASE"; then
  helm uninstall $WEBUI_RELEASE --namespace agents
  echo -e "${GREEN}✅ Open WebUI uninstalled successfully!${NC}"
else
  echo -e "${YELLOW}⚠️ Open WebUI is not installed in the 'agents' namespace. Skipping uninstallation.${NC}"
fi
