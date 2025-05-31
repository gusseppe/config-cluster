#!/bin/bash
set -e
echo "🚀 Deploying Dashy using the local Helm chart and custom image..."

# run the 1-generate-dashy-override.sh script
./2-generate-dashy-override.sh

helm upgrade --install dashy ./dashy-1.0.0.tgz \
  --namespace agents \
  --set image.repository=vcf-np-w2-harbor-az1.sunat.peru/agentes/dashy \
  --set image.tag=release-3.1.1 \
  --set service.type=LoadBalancer\
  -f dashy-values.yaml \
  -f dashy-override.yaml \
  --wait
echo "✨ Dashy deployment complete!"
