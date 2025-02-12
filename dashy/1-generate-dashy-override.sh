#!/bin/bash

# Get LoadBalancer services and extract NAME, EXTERNAL-IP, and PORT
kubectl get svc -o json | jq -r '.items[] | select(.spec.type == "LoadBalancer") | "\(.metadata.name) \(.status.loadBalancer.ingress[0].ip) \(.spec.ports[0].port)"' > loadbalancer-services.txt

# Initialize the YAML file
cat <<EOF > dashy-override.yaml
static:
  configMapContent:
    conf: |-
      # Page meta info, like heading, footer text and nav links
      pageInfo:
        title: Dashboard
        description: Apps para los agentes
        navLinks:
          - title: GitHub
            path: https://github.com/Lissy93/dashy
          - title: Documentation
            path: https://dashy.to/docs

      # Optional app settings and configuration
      appConfig:
        theme: material

      # Main content - An array of sections, each containing an array of items
      sections:
        - name: Apps
          items:
EOF

# Populate the YAML file with LoadBalancer services
while read -r name external_ip port; do
  cat <<EOF >> dashy-override.yaml
            - title: $name
              description: $name
              url: "http://$external_ip:$port"
EOF
done < loadbalancer-services.txt

echo "sunat-dashy-override.yaml generated successfully!"
