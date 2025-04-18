#!/bin/bash

# Deploy to Kubernetes
kubectl apply -f k8s/configmaps/mysql-init-configmap.yaml
kubectl apply -f k8s/mysql-deployment.yaml
kubectl apply -f k8s/redis-deployment.yaml
kubectl apply -f k8s/app1-deployment.yaml
kubectl apply -f k8s/app2-deployment.yaml

exit
