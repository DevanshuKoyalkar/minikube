#!/bin/bash

# Check if tag is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <nginx-tag>"
  exit 1
fi

NGINX_TAG=$1
NAMESPACE=myapp

# Update the ConfigMap
kubectl patch configmap nginx-image-config -n $NAMESPACE --type=merge -p "{\"data\":{\"tag\":\"$NGINX_TAG\"}}"

# Force a rollout restart of the deployment to pick up the new tag
kubectl rollout restart deployment nginx-deployment -n $NAMESPACE

echo "Updated nginx tag to $NGINX_TAG and triggered deployment restart" 