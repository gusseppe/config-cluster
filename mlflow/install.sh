#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'



# Ensure namespace exists
echo -e "${GREEN}Creating namespace 'agents' if it does not exist...${NC}"
kubectl get namespace agents || kubectl create namespace agents

# Crear carpetas en los nodos POSTGRESQL
folder_path="/bitnami/postgresql/agents"


sudo mkdir -p $folder_path && sudo chmod -R 777 $folder_path

# Volumen y PVC para PostgreSQL
echo -e "${GREEN}Creando Volumen y PVC para PostgreSQL...${NC}"
kubectl apply -f pg-volume.yaml
sleep 2
kubectl apply -f pg-pvc.yaml --namespace agents
sleep 2

# Instalar chart de PostgreSQL
echo -e "${GREEN}Instalando chart de PostgreSQL...${NC}"
helm upgrade --cleanup-on-fail --install postgresql ./postgresql-11.9.11.tgz --values config-postgresql.yaml --namespace agents
sleep 10
echo -e "${YELLOW}Output de helm status postgresql:${NC}"
helm status postgresql --namespace agents



# Crear carpetas en los nodos MINIO
folder_path="/bitnami/minio/agents"


sudo mkdir -p $folder_path && sudo chmod -R 777 $folder_path
# Volumen y PVC para Minio
echo "Creando Volumen y PVC para Minio..."
kubectl apply -f minio-volume.yaml
sleep 2
kubectl apply -f minio-pvc.yaml --namespace agents
sleep 2

# Instalar chart de Minio
echo "${GREEN}Instalando chart de Minio...${NC}"
helm upgrade --cleanup-on-fail --install minio ./minio-11.10.9.tgz --values config-minio.yaml --namespace agents
sleep 10
echo "Output de helm status Minio:"
helm status minio --namespace agents


# Instalar chart de MLflow
echo "${GREEN}Instalando chart de MLflow...${NC}"
helm  upgrade --cleanup-on-fail --install  mlflow ./mlflow-0.7.13.tgz --values config-mlflow.yaml --namespace agents
sleep 10
echo "Output de helm status MLflow:"
helm status mlflow --namespace agents
