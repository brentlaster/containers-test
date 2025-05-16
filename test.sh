#!/bin/bash

# Timeout in seconds (adjust as needed)
TIMEOUT=60

# Check if Docker is available
while ! docker info >/dev/null 2>&1; do
  if [ $TIMEOUT -le 0 ]; then
    echo "Timeout: Docker is not available."
    exit 1
  fi

  echo "Waiting for Docker..."
  sleep 1
  TIMEOUT=$((TIMEOUT - 1))
done

echo "Docker is available!"
echo ...Removing any old minikube instances
minikube delete
echo ...Starting minikube
minikube start
minikube addons enable registry
echo ...Waiting on resources to be ready
kubectl wait --for=condition=Ready -n kube-system pod --all --timeout=120s
kubectl port-forward --namespace kube-system service/registry 5000:80 &
cd roar-docker
docker build -f Dockerfile_roar_db_image -t localhost:5000/roar-db:v1 .
docker build -f Dockerfile_roar_web_image --build-arg warFile=roar.war -t localhost:5000/roar-web:v1 .
docker push localhost:5000/roar-db:v1
docker push localhost:5000/roar-web:v1
echo Images created and pushed to localhost:5000

