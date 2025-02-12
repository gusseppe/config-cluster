#!/bin/bash
set -e
echo "🚀 Deploying KubeAI with custom images using the local chart file..."
helm upgrade --install kubeai ./kubeai-0.12.0.tgz \
  --set image.repository=vcf-np-w2-harbor-az1.sunat.peru/agentes/kubeai \
  --set image.tag=v0.14.0 \
  --set modelLoading.image=vcf-np-w2-harbor-az1.sunat.peru/agentes/kubeai-model-loader:v0.14.0 \
  --set modelServers.VLLM.images.cpu=vcf-np-w2-harbor-az1.sunat.peru/agentes/vllm:v0.6.3.post1-cpu \
  --set openwebui.image.repository=vcf-np-w2-harbor-az1.sunat.peru/agentes/open-webui \
  --set openwebui.image.tag=v0.5.7 \
  --set openwebui.service.type=LoadBalancer \
  --set openwebui.service.port=30080 \
  -f kubeai-engine-values.yaml \
  --wait
echo "✨ KubeAI deployment complete!"
